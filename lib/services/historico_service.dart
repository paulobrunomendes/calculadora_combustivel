import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/viagem.dart';

class HistoricoService {
  static const _key = 'historico_viagens';

  static Future<List<Viagem>> carregar() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_key);
    if (json == null) return [];
    final list = jsonDecode(json) as List;
    return list
        .map((e) => Viagem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<void> _salvar(List<Viagem> lista) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key,
      jsonEncode(lista.map((v) => v.toJson()).toList()),
    );
  }

  static Future<void> adicionarViagem(Viagem viagem) async {
    final lista = await carregar();
    lista.insert(0, viagem);
    await _salvar(lista);
  }

  static Future<void> removerViagem(String id) async {
    final lista = await carregar();
    lista.removeWhere((v) => v.id == id);
    await _salvar(lista);
  }

  static Future<void> limparHistorico() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
