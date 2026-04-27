import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

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

  static Future<UpdateInfo?> verificar() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final versaoAtual = packageInfo.version;

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

      if (!_maisRecente(tag, versaoAtual)) return null;

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

  static Future<void> baixarEInstalar(
    String url, {
    void Function(double progresso)? onProgress,
  }) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/abast_smart_update.apk');

    final request = http.Request('GET', Uri.parse(url));
    final response = await http.Client().send(request);

    final total = response.contentLength ?? 0;
    var recebido = 0;
    final bytes = <int>[];

    await for (final chunk in response.stream) {
      bytes.addAll(chunk);
      recebido += chunk.length;
      if (total > 0) onProgress?.call(recebido / total);
    }

    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
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
