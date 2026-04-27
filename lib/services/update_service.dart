import 'dart:convert';
import 'package:http/http.dart' as http;

class UpdateInfo {
  final String versao;
  final String downloadUrl;
  final String notas;

  const UpdateInfo({
    required this.versao,
    required this.downloadUrl,
    required this.notas,
  });
}

class UpdateService {
  static const _owner = 'paulobrunomendes';
  static const _repo = 'calculadora_combustivel';

  // Manter sincronizado com pubspec.yaml → version
  static const _versaoAtual = '1.0.1';

  static Future<UpdateInfo?> verificar() async {
    try {
      final response = await http
          .get(
            Uri.parse(
                'https://api.github.com/repos/$_owner/$_repo/releases/latest'),
            headers: {'Accept': 'application/vnd.github+json'},
          )
          .timeout(const Duration(seconds: 8));

      if (response.statusCode != 200) return null;

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final tag = (data['tag_name'] as String).replaceFirst('v', '');

      if (!_maisRecente(tag, _versaoAtual)) return null;

      // Prefere o .apk direto; se não tiver, usa a página do release
      String url = data['html_url'] as String;
      for (final asset in (data['assets'] as List)) {
        if ((asset['name'] as String).endsWith('.apk')) {
          url = asset['browser_download_url'] as String;
          break;
        }
      }

      final body = (data['body'] as String? ?? '').trim();
      final notas = body.isEmpty ? 'Nova versão disponível.' : body;

      return UpdateInfo(versao: tag, downloadUrl: url, notas: notas);
    } catch (_) {
      return null;
    }
  }

  static bool _maisRecente(String remota, String local) {
    List<int> parse(String v) =>
        v.split('.').map((e) => int.tryParse(e) ?? 0).toList();

    final r = parse(remota);
    final l = parse(local);
    for (int i = 0; i < 3; i++) {
      final rv = i < r.length ? r[i] : 0;
      final lv = i < l.length ? l[i] : 0;
      if (rv > lv) return true;
      if (rv < lv) return false;
    }
    return false;
  }
}
