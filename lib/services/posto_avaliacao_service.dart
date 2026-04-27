import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PostoAvaliacao {
  final String autorNome;
  final double nota;
  final double? precoGasolina; // R$/L — informado pelo usuário
  final String comentario;
  final DateTime data;

  PostoAvaliacao({
    required this.autorNome,
    required this.nota,
    this.precoGasolina,
    required this.comentario,
    required this.data,
  });

  Map<String, dynamic> toJson() => {
        'autorNome': autorNome,
        'nota': nota,
        'precoGasolina': precoGasolina,
        'comentario': comentario,
        'data': data.toIso8601String(),
      };

  factory PostoAvaliacao.fromJson(Map<String, dynamic> json) => PostoAvaliacao(
        autorNome: json['autorNome'] as String,
        nota: (json['nota'] as num).toDouble(),
        precoGasolina: json['precoGasolina'] != null
            ? (json['precoGasolina'] as num).toDouble()
            : null,
        comentario: json['comentario'] as String,
        data: DateTime.parse(json['data'] as String),
      );
}

class PostoAvaliacaoService {
  static const _indexKey = 'posto_avaliacoes_index';

  static String _keyForPosto(double lat, double lon) =>
      'posto_${lat.toStringAsFixed(4)}_${lon.toStringAsFixed(4)}';

  // ── Avaliações de um posto específico ─────────────────────────────────────

  static Future<List<PostoAvaliacao>> getAvaliacoes(
      double lat, double lon) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _keyForPosto(lat, lon);
    final raw = prefs.getString(key);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List;
    return list
        .map((e) => PostoAvaliacao.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<void> adicionarAvaliacao(
    double lat,
    double lon,
    PostoAvaliacao avaliacao, {
    Map<String, dynamic>? postoInfo,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _keyForPosto(lat, lon);
    final lista = await getAvaliacoes(lat, lon);
    lista.insert(0, avaliacao);
    await prefs.setString(
        key, jsonEncode(lista.map((e) => e.toJson()).toList()));

    // Atualiza o índice global
    if (postoInfo != null) {
      await _atualizarIndice(prefs, lat, lon, postoInfo, lista);
    }
  }

  // ── Índice global de postos avaliados ─────────────────────────────────────

  static Future<void> _atualizarIndice(
    SharedPreferences prefs,
    double lat,
    double lon,
    Map<String, dynamic> postoInfo,
    List<PostoAvaliacao> avaliacoes,
  ) async {
    final key = _keyForPosto(lat, lon);
    final raw = prefs.getString(_indexKey);
    final index = raw != null
        ? (jsonDecode(raw) as List).cast<Map<String, dynamic>>()
        : <Map<String, dynamic>>[];

    // Calcula média e último preço
    double mediaNotas = 0;
    double? ultimoPreco;
    if (avaliacoes.isNotEmpty) {
      mediaNotas =
          avaliacoes.fold(0.0, (acc, a) => acc + a.nota) / avaliacoes.length;
      ultimoPreco = avaliacoes.firstWhere((a) => a.precoGasolina != null,
              orElse: () => avaliacoes.first)
          .precoGasolina;
    }

    // Remove entrada existente e reinsere no topo (mais recente primeiro)
    index.removeWhere((e) => e['key'] == key);
    index.insert(0, {
      'key': key,
      'lat': lat,
      'lon': lon,
      'nome': postoInfo['nome'] ?? 'Posto',
      'brand': postoInfo['brand'] ?? '',
      'address': postoInfo['address'] ?? '',
      'phone': postoInfo['phone'] ?? '',
      'totalAvaliacoes': avaliacoes.length,
      'mediaNotas': mediaNotas,
      'ultimoPreco': ultimoPreco,
      'ultimaAvaliacao': DateTime.now().toIso8601String(),
    });

    await prefs.setString(_indexKey, jsonEncode(index));
  }

  /// Retorna todos os postos que têm pelo menos uma avaliação,
  /// do mais recentemente avaliado ao mais antigo.
  static Future<List<Map<String, dynamic>>> getPostosComAvaliacoes() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_indexKey);
    if (raw == null) return [];
    return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
  }

  /// Apaga todas as avaliações de um posto e remove do índice.
  static Future<void> limparAvaliacoes(double lat, double lon) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _keyForPosto(lat, lon);
    await prefs.remove(key);

    final raw = prefs.getString(_indexKey);
    if (raw == null) return;
    final index = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    index.removeWhere((e) => e['key'] == key);
    await prefs.setString(_indexKey, jsonEncode(index));
  }
}
