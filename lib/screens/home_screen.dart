import 'dart:async';
import 'dart:convert';
import 'dart:math' show min, max;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_widget/home_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../config.dart';
import '../main.dart';
import '../models/viagem.dart';
import '../services/historico_service.dart';
import '../services/update_service.dart';
import 'historico_screen.dart';
import 'tabela_consumo_screen.dart';
import 'gps_screen.dart';
import 'posto_detalhe_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Campos de cálculo
  final _distanciaController = TextEditingController();
  final _consumoController = TextEditingController();
  final _precoController = TextEditingController();

  // Campos Mapbox
  final _origemController = TextEditingController();
  final _destinoController = TextEditingController();
  final _origemFocus = FocusNode();
  final _destinoFocus = FocusNode();
  final _mapController = MapController();

  String _combustivel = 'Gasolina';
  bool _idaEVolta = false;
  double? _resultado;
  double? _litrosUsados;
  int _pedagios = 0;
  String? _veiculoSelecionado;

  bool _buscandoDistancia = false;
  String? _erroDistancia;
  LatLng? _pontoOrigem;
  LatLng? _pontoDestino;
  List<LatLng> _rotaPontos = [];

  // Coordenadas salvas ao selecionar sugestão (evita re-geocodificação)
  LatLng? _coordOrigemSelecionada;
  LatLng? _coordDestinoSelecionada;

  // Edição de rota
  List<LatLng> _waypoints = [];
  bool _modoEdicaoRota = false;
  String? _tempoViagem;

  // Postos de gasolina
  List<Map<String, dynamic>> _postosProximos = [];
  bool _mostrarPostos = false;
  bool _buscandoPostos = false;

  // Carregadores elétricos
  List<Map<String, dynamic>> _carregadoresEletricos = [];
  bool _mostrarCarregadores = false;
  bool _buscandoCarregadores = false;

  // Pedágios no mapa
  List<LatLng> _pedagiosPontos = [];

  List<Map<String, dynamic>> _sugestoesOrigem = [];
  List<Map<String, dynamic>> _sugestoesDestino = [];
  Timer? _debounceOrigem;
  Timer? _debounceDestino;

  // Comparador Gasolina vs Etanol
  final _precoGasolinaCompController = TextEditingController();
  final _precoEtanolCompController = TextEditingController();
  String? _comparadorMsg;
  bool _etanolCompensa = false;

  String _versaoApp = '';

  static const _azulPrimario = Color(0xFF2563EB);
  static const _verde = Color(0xFF10b981);
  static const _brasilCenter = LatLng(-15.7801, -47.9292);

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) {
      setState(() => _versaoApp = info.version);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _checarAtualizacao());
    _carregarUltimosValores();
    _precoGasolinaCompController.addListener(_calcularComparador);
    _precoEtanolCompController.addListener(_calcularComparador);
    _origemFocus.addListener(() {
      if (!_origemFocus.hasFocus) {
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) setState(() => _sugestoesOrigem = []);
        });
      }
    });
    _destinoFocus.addListener(() {
      if (!_destinoFocus.hasFocus) {
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) setState(() => _sugestoesDestino = []);
        });
      }
    });
  }

  // ── API Mapbox ────────────────────────────────────────────────────────────

  Future<LatLng?> _geocodificar(String endereco) async {
    final url = Uri.parse(
      'https://api.mapbox.com/geocoding/v5/mapbox.places/'
      '${Uri.encodeComponent(endereco)}.json'
      '?country=BR&language=pt&access_token=$mapboxToken',
    );
    final resp = await http.get(url);
    if (resp.statusCode != 200) return null;
    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    final features = data['features'] as List;
    if (features.isEmpty) return null;
    final coords = features[0]['geometry']['coordinates'] as List;
    return LatLng(coords[1].toDouble(), coords[0].toDouble());
  }

  Future<void> _buscarSugestoes(String query, bool isOrigem) async {
    if (query.length < 2) {
      setState(() {
        if (isOrigem) _sugestoesOrigem = [];
        else _sugestoesDestino = [];
      });
      return;
    }
    final url = Uri.parse(
      'https://api.mapbox.com/geocoding/v5/mapbox.places/'
      '${Uri.encodeComponent(query)}.json'
      '?autocomplete=true&country=BR&language=pt'
      '&types=place,address,locality,region&access_token=$mapboxToken',
    );
    try {
      final resp = await http.get(url);
      if (resp.statusCode != 200) return;
      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      final features = data['features'] as List;
      if (!mounted) return;
      final sugestoes = features.take(5).map((f) {
        final coords = f['geometry']['coordinates'] as List;
        return {
          'name': f['place_name'] as String,
          'lat': (coords[1] as num).toDouble(),
          'lon': (coords[0] as num).toDouble(),
        };
      }).toList();
      setState(() {
        if (isOrigem) _sugestoesOrigem = sugestoes;
        else _sugestoesDestino = sugestoes;
      });
    } catch (_) {}
  }

  void _onOrigemChanged(String value) {
    _coordOrigemSelecionada = null; // invalida ao digitar
    _debounceOrigem?.cancel();
    _debounceOrigem = Timer(const Duration(milliseconds: 350), () {
      _buscarSugestoes(value, true);
    });
  }

  void _onDestinoChanged(String value) {
    _coordDestinoSelecionada = null; // invalida ao digitar
    _debounceDestino?.cancel();
    _debounceDestino = Timer(const Duration(milliseconds: 350), () {
      _buscarSugestoes(value, false);
    });
  }

  void _selecionarOrigem(String nome, double lat, double lon) {
    _origemController.text = nome;
    _origemFocus.unfocus();
    setState(() {
      _sugestoesOrigem = [];
      _coordOrigemSelecionada = LatLng(lat, lon);
    });
  }

  void _selecionarDestino(String nome, double lat, double lon) {
    _destinoController.text = nome;
    _destinoFocus.unfocus();
    setState(() {
      _sugestoesDestino = [];
      _coordDestinoSelecionada = LatLng(lat, lon);
    });
  }

  int _contarPedagios(Map<String, dynamic> response) {
    try {
      final legs = (response['routes'] as List)[0]['legs'] as List;
      final steps = legs[0]['steps'] as List? ?? [];
      int count = 0;
      for (final step in steps) {
        if (step is! Map) continue;
        for (final inter in (step['intersections'] as List? ?? [])) {
          if (inter is Map && inter.containsKey('toll_collection')) count++;
        }
      }
      return count;
    } catch (_) {
      return 0;
    }
  }

  List<LatLng> _extrairPedagiosPontos(Map<String, dynamic> response) {
    final pontos = <LatLng>[];
    try {
      for (final leg in (response['routes'] as List)[0]['legs'] as List) {
        for (final step in leg['steps'] as List? ?? []) {
          if (step is! Map) continue;
          for (final inter in step['intersections'] as List? ?? []) {
            if (inter is Map && inter.containsKey('toll_collection')) {
              final loc = inter['location'] as List;
              pontos.add(LatLng((loc[1] as num).toDouble(), (loc[0] as num).toDouble()));
            }
          }
        }
      }
    } catch (_) {}
    return pontos;
  }

  Future<void> _buscarDistanciaMapbox() async {
    final origem = _origemController.text.trim();
    final destino = _destinoController.text.trim();

    if (origem.isEmpty || destino.isEmpty) {
      setState(() => _erroDistancia = 'Preencha a origem e o destino.');
      return;
    }

    setState(() {
      _buscandoDistancia = true;
      _erroDistancia = null;
      _rotaPontos = [];
      _pontoOrigem = null;
      _pontoDestino = null;
      _resultado = null;
      _litrosUsados = null;
      _pedagios = 0;
      _waypoints = [];
      _modoEdicaoRota = false;
      _tempoViagem = null;
      _postosProximos = [];
      _mostrarPostos = false;
      _carregadoresEletricos = [];
      _mostrarCarregadores = false;
    });

    try {
      // Usa coordenadas da sugestão selecionada; só re-geocodifica se digitado manualmente
      final pontoOrigem =
          _coordOrigemSelecionada ?? await _geocodificar(origem);
      if (pontoOrigem == null) {
        setState(() {
          _erroDistancia = 'Origem não encontrada.';
          _buscandoDistancia = false;
        });
        return;
      }

      final pontoDestino =
          _coordDestinoSelecionada ?? await _geocodificar(destino);
      if (pontoDestino == null) {
        setState(() {
          _erroDistancia = 'Destino não encontrado.';
          _buscandoDistancia = false;
        });
        return;
      }

      final url = Uri.parse(
        'https://api.mapbox.com/directions/v5/mapbox/driving/'
        '${pontoOrigem.longitude},${pontoOrigem.latitude};'
        '${pontoDestino.longitude},${pontoDestino.latitude}'
        '?geometries=geojson&steps=true&alternatives=true&access_token=$mapboxToken',
      );

      final resp = await http.get(url);
      if (resp.statusCode != 200) throw Exception();

      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      final routes = data['routes'] as List;
      if (routes.isEmpty) throw Exception();

      // Seleciona a rota de menor distância
      routes.sort((a, b) =>
          (a['distance'] as num).compareTo(b['distance'] as num));
      final melhorRota = routes[0] as Map<String, dynamic>;

      final km = (melhorRota['distance'] as num).toDouble() / 1000;
      final duracao = (melhorRota['duration'] as num).toDouble();
      final coords = melhorRota['geometry']['coordinates'] as List;
      final pontos = coords
          .map((c) => LatLng((c[1] as num).toDouble(), (c[0] as num).toDouble()))
          .toList();

      setState(() {
        _pontoOrigem = pontoOrigem;
        _pontoDestino = pontoDestino;
        _rotaPontos = pontos;
        _distanciaController.text = km.toStringAsFixed(1);
        _pedagios = _contarPedagios(data);
        _pedagiosPontos = _extrairPedagiosPontos(data);
        _tempoViagem = _formatarTempo(duracao);
        _buscandoDistancia = false;
        _erroDistancia = null;
      });

      _mapController.fitCamera(
        CameraFit.bounds(
          bounds: LatLngBounds.fromPoints([pontoOrigem, pontoDestino]),
          padding: const EdgeInsets.all(50),
        ),
      );

      // Busca postos e carregadores automaticamente ao longo da rota
      _buscarPostos();
      _buscarCarregadoresEletricos();
    } catch (_) {
      setState(() {
        _erroDistancia = 'Erro ao buscar rota. Verifique sua conexão.';
        _buscandoDistancia = false;
      });
    }
  }

  String _formatarTempo(double segundos) {
    final total = segundos.round();
    final horas = total ~/ 3600;
    final minutos = (total % 3600) ~/ 60;
    if (horas > 0) {
      return '${horas}h ${minutos.toString().padLeft(2, '0')}min';
    }
    return '${minutos}min';
  }

  // ── Edição de rota (waypoints) ────────────────────────────────────────────

  Future<void> _adicionarWaypoint(LatLng ponto) async {
    setState(() {
      _waypoints.add(ponto);
      _buscandoDistancia = true;
    });
    await _recalcularComWaypoints();
  }

  Future<void> _removerWaypoint(int index) async {
    setState(() {
      _waypoints.removeAt(index);
      _buscandoDistancia = true;
    });
    await _recalcularComWaypoints();
  }

  Future<void> _recalcularComWaypoints() async {
    if (_pontoOrigem == null || _pontoDestino == null) return;
    try {
      final allPoints = [_pontoOrigem!, ..._waypoints, _pontoDestino!];
      final coordStr =
          allPoints.map((p) => '${p.longitude},${p.latitude}').join(';');
      final url = Uri.parse(
        'https://api.mapbox.com/directions/v5/mapbox/driving/$coordStr'
        '?geometries=geojson&steps=true&alternatives=true&access_token=$mapboxToken',
      );
      final resp = await http.get(url);
      if (resp.statusCode != 200) throw Exception();
      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      final routes = data['routes'] as List;
      if (routes.isEmpty) throw Exception();
      routes.sort((a, b) =>
          (a['distance'] as num).compareTo(b['distance'] as num));
      final melhorRota = routes[0] as Map<String, dynamic>;
      final km = (melhorRota['distance'] as num).toDouble() / 1000;
      final duracao = (melhorRota['duration'] as num).toDouble();
      final coords = melhorRota['geometry']['coordinates'] as List;
      final pontos = coords
          .map((c) =>
              LatLng((c[1] as num).toDouble(), (c[0] as num).toDouble()))
          .toList();
      setState(() {
        _rotaPontos = pontos;
        _distanciaController.text = km.toStringAsFixed(1);
        _pedagios = _contarPedagios(data);
        _pedagiosPontos = _extrairPedagiosPontos(data);
        _tempoViagem = _formatarTempo(duracao);
        _buscandoDistancia = false;
        _resultado = null;
        _litrosUsados = null;
        _erroDistancia = null;
        _postosProximos = [];
        _mostrarPostos = false;
        _carregadoresEletricos = [];
        _mostrarCarregadores = false;
      });
      _buscarPostos();
      _buscarCarregadoresEletricos();
      _mapController.fitCamera(
        CameraFit.bounds(
          bounds: LatLngBounds.fromPoints(allPoints),
          padding: const EdgeInsets.all(50),
        ),
      );
    } catch (_) {
      setState(() {
        _erroDistancia = 'Erro ao recalcular rota.';
        _buscandoDistancia = false;
      });
    }
  }

  // ── Tabela de consumo ─────────────────────────────────────────────────────

  Future<void> _abrirTabelaConsumo() async {
    final resultado = await Navigator.push<(double, String)>(
      context,
      MaterialPageRoute(builder: (_) => const TabelaConsumoScreen()),
    );
    if (resultado != null && mounted) {
      setState(() {
        _consumoController.text =
            resultado.$1.toStringAsFixed(1).replaceAll('.', ',');
        _veiculoSelecionado = resultado.$2;
      });
    }
  }

  // ── Postos de gasolina (Overpass/OpenStreetMap) ───────────────────────────

  Future<void> _buscarPostos() async {
    if (_rotaPontos.isEmpty) return;

    setState(() {
      _buscandoPostos = true;
      _postosProximos = [];
      _mostrarPostos = false;
    });

    try {
      // Bounding box com margem de 0.05° (~5,5 km) — filtramos por distância depois
      const pad = 0.05;
      final minLat = _rotaPontos.map((p) => p.latitude).reduce(min) - pad;
      final maxLat = _rotaPontos.map((p) => p.latitude).reduce(max) + pad;
      final minLon = _rotaPontos.map((p) => p.longitude).reduce(min) - pad;
      final maxLon = _rotaPontos.map((p) => p.longitude).reduce(max) + pad;

      // Inclui nodes, ways e relations — sem limite de resultados
      final query =
          '[out:json][timeout:60];'
          '('
          'node["amenity"="fuel"]($minLat,$minLon,$maxLat,$maxLon);'
          'way["amenity"="fuel"]($minLat,$minLon,$maxLat,$maxLon);'
          'relation["amenity"="fuel"]($minLat,$minLon,$maxLat,$maxLon);'
          ');'
          'out center body;';

      final resp = await http.post(
        Uri.parse('https://overpass-api.de/api/interpreter'),
        body: {'data': query},
      );

      if (resp.statusCode != 200) throw Exception('Overpass error');

      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      final elements = data['elements'] as List;

      // Amostra pontos do trajeto a cada ~300 m de distância real
      const distCalc = Distance();
      const sampleM   = 300.0;  // amostrar a cada 300 m
      const thresholdM = 4000.0; // posto considerado "no trajeto" até 4 km

      final amostras = <LatLng>[_rotaPontos.first];
      double acumulado = 0.0;
      for (int i = 1; i < _rotaPontos.length; i++) {
        acumulado += distCalc(_rotaPontos[i - 1], _rotaPontos[i]);
        if (acumulado >= sampleM) {
          amostras.add(_rotaPontos[i]);
          acumulado = 0.0;
        }
      }
      if (amostras.last != _rotaPontos.last) amostras.add(_rotaPontos.last);

      final postos = <Map<String, dynamic>>[];
      final vistosId = <dynamic>{};

      for (final e in elements) {
        // Coordenada: node → lat/lon direto; way/relation → center
        double? lat, lon;
        final tipo = e['type'] as String?;
        if (tipo == 'way' || tipo == 'relation') {
          final center = e['center'] as Map<String, dynamic>?;
          if (center == null) continue;
          lat = (center['lat'] as num?)?.toDouble();
          lon = (center['lon'] as num?)?.toDouble();
        } else {
          lat = (e['lat'] as num?)?.toDouble();
          lon = (e['lon'] as num?)?.toDouble();
        }
        if (lat == null || lon == null) continue;

        final id = e['id'];
        if (!vistosId.add(id)) continue;

        final ponto = LatLng(lat, lon);

        // Verifica se está a ≤ 2,5 km de algum ponto amostrado do trajeto
        bool noTrajeto = false;
        for (final rp in amostras) {
          if (distCalc(ponto, rp) <= thresholdM) {
            noTrajeto = true;
            break;
          }
        }
        if (!noTrajeto) continue;

        final tags = e['tags'] as Map<String, dynamic>? ?? {};
        final brand = tags['brand'] as String? ?? '';
        final nome = brand.isNotEmpty
            ? brand
            : tags['name'] as String? ?? 'Posto';
        final address = [
          tags['addr:street'] as String? ?? '',
          tags['addr:housenumber'] as String? ?? '',
          tags['addr:city'] as String? ?? '',
        ].where((s) => s.isNotEmpty).join(', ');
        final phone = tags['phone'] as String? ??
            tags['contact:phone'] as String? ?? '';
        postos.add({
          'lat': lat,
          'lon': lon,
          'nome': nome,
          'brand': brand,
          'address': address,
          'phone': phone,
          'id': id.toString(),
        });
      }

      if (!mounted) return;
      setState(() {
        _postosProximos = postos;
        _mostrarPostos = postos.isNotEmpty;
        _buscandoPostos = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _buscandoPostos = false);
    }
  }

  void _abrirModalPosto(Map<String, dynamic> posto) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => PostoDetalheSheet(posto: posto),
    );
  }

  // ── Carregadores elétricos (Overpass/OpenStreetMap) ───────────────────────

  Future<void> _buscarCarregadoresEletricos() async {
    if (_rotaPontos.isEmpty) return;

    setState(() {
      _buscandoCarregadores = true;
      _carregadoresEletricos = [];
      _mostrarCarregadores = false;
    });

    try {
      const pad = 0.05;
      final minLat = _rotaPontos.map((p) => p.latitude).reduce(min) - pad;
      final maxLat = _rotaPontos.map((p) => p.latitude).reduce(max) + pad;
      final minLon = _rotaPontos.map((p) => p.longitude).reduce(min) - pad;
      final maxLon = _rotaPontos.map((p) => p.longitude).reduce(max) + pad;

      final query =
          '[out:json][timeout:60];'
          '('
          'node["amenity"="charging_station"]($minLat,$minLon,$maxLat,$maxLon);'
          'way["amenity"="charging_station"]($minLat,$minLon,$maxLat,$maxLon);'
          ');'
          'out center body;';

      final resp = await http.post(
        Uri.parse('https://overpass-api.de/api/interpreter'),
        body: {'data': query},
      );

      if (resp.statusCode != 200) throw Exception('Overpass error');

      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      final elements = data['elements'] as List;

      const distCalc = Distance();
      const sampleM = 300.0;
      const thresholdM = 4000.0;

      final amostras = <LatLng>[_rotaPontos.first];
      double acumulado = 0.0;
      for (int i = 1; i < _rotaPontos.length; i++) {
        acumulado += distCalc(_rotaPontos[i - 1], _rotaPontos[i]);
        if (acumulado >= sampleM) {
          amostras.add(_rotaPontos[i]);
          acumulado = 0.0;
        }
      }
      if (amostras.last != _rotaPontos.last) amostras.add(_rotaPontos.last);

      final carregadores = <Map<String, dynamic>>[];
      final vistosId = <dynamic>{};

      for (final e in elements) {
        double? lat, lon;
        final tipo = e['type'] as String?;
        if (tipo == 'way') {
          final center = e['center'] as Map<String, dynamic>?;
          if (center == null) continue;
          lat = (center['lat'] as num?)?.toDouble();
          lon = (center['lon'] as num?)?.toDouble();
        } else {
          lat = (e['lat'] as num?)?.toDouble();
          lon = (e['lon'] as num?)?.toDouble();
        }
        if (lat == null || lon == null) continue;

        final id = e['id'];
        if (!vistosId.add(id)) continue;

        final ponto = LatLng(lat, lon);
        bool noTrajeto = false;
        for (final rp in amostras) {
          if (distCalc(ponto, rp) <= thresholdM) {
            noTrajeto = true;
            break;
          }
        }
        if (!noTrajeto) continue;

        final tags = e['tags'] as Map<String, dynamic>? ?? {};
        final nome = tags['name'] as String? ??
            tags['operator'] as String? ??
            'Carregador Elétrico';
        final capacidade = tags['capacity'] as String? ?? '';
        final voltagem = tags['voltage'] as String? ?? '';
        final potencia = tags['maxpower'] as String? ??
            tags['socket:type2:output'] as String? ?? '';
        final network = tags['network'] as String? ?? '';

        carregadores.add({
          'lat': lat,
          'lon': lon,
          'nome': nome,
          'network': network,
          'capacidade': capacidade,
          'voltagem': voltagem,
          'potencia': potencia,
        });
      }

      if (!mounted) return;
      setState(() {
        _carregadoresEletricos = carregadores;
        _mostrarCarregadores = carregadores.isNotEmpty;
        _buscandoCarregadores = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _buscandoCarregadores = false);
    }
  }

  // ── Cálculo ───────────────────────────────────────────────────────────────

  void _calcular() {
    final distancia = double.tryParse(
      _distanciaController.text.replaceAll(',', '.'),
    );
    final consumo = double.tryParse(
      _consumoController.text.replaceAll(',', '.'),
    );
    final preco = double.tryParse(
      _precoController.text.replaceAll(',', '.'),
    );

    if (distancia == null || consumo == null || preco == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Campos obrigatórios'),
          content: const Text('Por favor, preencha todos os campos.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    if (consumo == 0) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Valor inválido'),
          content: const Text('O consumo não pode ser zero.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final distanciaFinal = _idaEVolta ? distancia * 2 : distancia;
    final litros = distanciaFinal / consumo;
    final resultado = litros * preco;
    setState(() {
      _litrosUsados = litros;
      _resultado = resultado;
    });

    // Salvar no histórico
    final viagem = Viagem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      origem: _origemController.text.trim(),
      destino: _destinoController.text.trim(),
      distancia: distanciaFinal,
      custo: resultado,
      litros: litros,
      combustivel: _combustivel,
      idaEVolta: _idaEVolta,
      pedagios: _pedagios,
      data: DateTime.now(),
      veiculo: _veiculoSelecionado,
      rotaPontos: _rotaPontos.isNotEmpty
          ? _rotaPontos.map((p) => [p.latitude, p.longitude]).toList()
          : null,
    );
    HistoricoService.adicionarViagem(viagem);
    _salvarUltimosValores();
    _atualizarWidget();
  }

  // ── Salvar / carregar últimos valores ────────────────────────────────────

  Future<void> _carregarUltimosValores() async {
    final prefs = await SharedPreferences.getInstance();
    final dist = prefs.getString('ultimo_distancia');
    final cons = prefs.getString('ultimo_consumo');
    final preco = prefs.getString('ultimo_preco');
    final comb = prefs.getString('ultimo_combustivel');
    final idaVolta = prefs.getBool('ultimo_ida_e_volta');
    if (dist != null) _distanciaController.text = dist;
    if (cons != null) _consumoController.text = cons;
    if (preco != null) _precoController.text = preco;
    if (comb != null) setState(() => _combustivel = comb);
    if (idaVolta != null) setState(() => _idaEVolta = idaVolta);
  }

  Future<void> _salvarUltimosValores() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ultimo_distancia', _distanciaController.text);
    await prefs.setString('ultimo_consumo', _consumoController.text);
    await prefs.setString('ultimo_preco', _precoController.text);
    await prefs.setString('ultimo_combustivel', _combustivel);
    await prefs.setBool('ultimo_ida_e_volta', _idaEVolta);
  }

  // ── Comparador Gasolina vs Etanol ─────────────────────────────────────────

  void _calcularComparador() {
    final gas = double.tryParse(
        _precoGasolinaCompController.text.replaceAll(',', '.'));
    final eta = double.tryParse(
        _precoEtanolCompController.text.replaceAll(',', '.'));
    if (gas == null || eta == null || gas == 0) {
      setState(() => _comparadorMsg = null);
      return;
    }
    final ratio = eta / gas;
    final compensa = ratio < 0.70;
    setState(() {
      _etanolCompensa = compensa;
      if (compensa) {
        final pct = ((1 - ratio) * 100).toStringAsFixed(1);
        _comparadorMsg =
            'Etanol compensa! ${pct}% mais barato (índice: ${ratio.toStringAsFixed(2)})';
      } else {
        _comparadorMsg =
            'Gasolina compensa! Use gasolina (índice: ${ratio.toStringAsFixed(2)})';
      }
    });
  }

  // ── Compartilhar no WhatsApp ──────────────────────────────────────────────

  Future<void> _compartilharWhatsApp() async {
    if (_resultado == null || _litrosUsados == null) return;
    final dist = _distanciaController.text;
    final origem = _origemController.text.trim();
    final destino = _destinoController.text.trim();
    final pedagioTxt =
        _pedagios > 0 ? '🛣️ Pedágios detectados: $_pedagios\n' : '';
    final rotaTxt = (origem.isNotEmpty && destino.isNotEmpty)
        ? '🔵 Origem: $origem\n🔴 Destino: $destino\n'
        : '';
    final texto = Uri.encodeComponent(
      '🚗 *Cálculo de Combustível*\n\n'
      '$rotaTxt'
      '📍 Distância: $dist km${_idaEVolta ? ' (ida e volta)' : ''}\n'
      '⛽ Combustível: $_combustivel\n'
      '💧 Litros necessários: ${_litrosUsados!.toStringAsFixed(2)} L\n'
      '💰 Custo estimado: R\$ ${_resultado!.toStringAsFixed(2)}\n'
      '$pedagioTxt'
      '\nCalculado com *Abast Smart* 📱',
    );
    final url = Uri.parse('https://wa.me/?text=$texto');
    if (await canLaunchUrl(url)) launchUrl(url);
  }

  // ── Widget Android ────────────────────────────────────────────────────────

  Future<void> _atualizarWidget() async {
    if (_resultado == null || _litrosUsados == null) return;
    await HomeWidget.saveWidgetData<String>(
        'custo', 'R\$ ${_resultado!.toStringAsFixed(2)}');
    await HomeWidget.saveWidgetData<String>(
        'distancia', '${_distanciaController.text} km');
    await HomeWidget.saveWidgetData<String>('combustivel', _combustivel);
    await HomeWidget.updateWidget(androidName: 'CombustivelWidgetProvider');
  }

  Future<void> _checarAtualizacao() async {
    final info = await UpdateService.verificar();
    if (info == null || !mounted) return;
    _mostrarDialogAtualizacao(info);
  }

  void _mostrarDialogAtualizacao(UpdateInfo info) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.system_update, color: Color(0xFF2563EB)),
            const SizedBox(width: 10),
            Text('Versão ${info.versao} disponível',
                style: const TextStyle(fontSize: 16)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Uma nova versão do app está disponível. Atualize para ter as últimas melhorias e correções.',
              style: TextStyle(fontSize: 14),
            ),
            if (info.notas.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB).withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  info.notas,
                  style: const TextStyle(fontSize: 12),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Agora não'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              launchUrl(
                Uri.parse(info.downloadUrl),
                mode: LaunchMode.externalApplication,
              );
              Navigator.pop(ctx);
            },
            icon: const Icon(Icons.download, size: 18),
            label: const Text('Baixar atualização'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _distanciaController.dispose();
    _consumoController.dispose();
    _precoController.dispose();
    _origemController.dispose();
    _destinoController.dispose();
    _precoGasolinaCompController.dispose();
    _precoEtanolCompController.dispose();
    _origemFocus.dispose();
    _destinoFocus.dispose();
    _debounceOrigem?.cancel();
    _debounceDestino?.cancel();
    super.dispose();
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = Theme.of(context).cardColor;
    final inputFill = isDark ? const Color(0xFF0f172a) : const Color(0xFFf0f4ff);
    final borderColor =
        isDark ? const Color(0xFF334155) : const Color(0xFFdddddd);
    final secondaryText =
        isDark ? Colors.white60 : Colors.black54;

    final distanciaDigitada =
        double.tryParse(_distanciaController.text.replaceAll(',', '.'));
    final distanciaEfetiva =
        (_idaEVolta && distanciaDigitada != null)
            ? distanciaDigitada * 2
            : distanciaDigitada;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Título + botões ───────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '⛽ Abast Smart',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: _azulPrimario,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.gps_fixed, color: _azulPrimario, size: 22),
                    tooltip: 'Abrir GPS',
                    padding: const EdgeInsets.all(6),
                    constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GpsScreen(
                          destino: _pontoDestino,
                          waypoints: List.of(_waypoints),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.history, color: _azulPrimario, size: 22),
                    tooltip: 'Histórico de viagens',
                    padding: const EdgeInsets.all(6),
                    constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const HistoricoScreen()),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.directions_car, color: _azulPrimario, size: 22),
                    tooltip: 'Tabela de consumo',
                    padding: const EdgeInsets.all(6),
                    constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const TabelaConsumoScreen()),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                      color: _azulPrimario,
                      size: 22,
                    ),
                    tooltip: isDark ? 'Modo claro' : 'Modo escuro',
                    padding: const EdgeInsets.all(6),
                    constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                    onPressed: () => CombustivelApp.of(context).toggleTheme(),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // ── Seletor de combustível ────────────────────────────
              Container(
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
                      child: Text(
                        'Tipo de Combustível',
                        style: TextStyle(
                          fontSize: 13,
                          color: secondaryText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        _buildCombustivelBtn('Gasolina', isDark),
                        _buildCombustivelBtn('Etanol', isDark),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // ── Comparador Gasolina vs Etanol ─────────────────────
              Container(
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.compare_arrows,
                            color: _azulPrimario, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          'Comparador Gasolina vs Etanol',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _azulPrimario,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _buildCampo(
                            controller: _precoGasolinaCompController,
                            label: 'Gasolina (R\$/L)',
                            placeholder: 'Ex: 5.89',
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            surfaceColor: inputFill,
                            borderColor: borderColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildCampo(
                            controller: _precoEtanolCompController,
                            label: 'Etanol (R\$/L)',
                            placeholder: 'Ex: 3.99',
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            surfaceColor: inputFill,
                            borderColor: borderColor,
                          ),
                        ),
                      ],
                    ),
                    if (_comparadorMsg != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: _etanolCompensa
                              ? Colors.green.withAlpha(30)
                              : Colors.orange.withAlpha(30),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: _etanolCompensa
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _etanolCompensa
                                  ? Icons.eco
                                  : Icons.local_gas_station,
                              size: 16,
                              color: _etanolCompensa
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                _comparadorMsg!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _etanolCompensa
                                      ? Colors.green.shade700
                                      : Colors.orange.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // ── Mapa ─────────────────────────────────────────────
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: (MediaQuery.of(context).size.height * 0.25).clamp(160.0, 260.0),
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: _brasilCenter,
                      initialZoom: 4,
                      onTap: _modoEdicaoRota
                          ? (_, latLng) => _adicionarWaypoint(latLng)
                          : null,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://api.mapbox.com/styles/v1/mapbox/'
                            '${isDark ? 'dark-v11' : 'streets-v12'}'
                            '/tiles/{z}/{x}/{y}?access_token=$mapboxToken',
                        userAgentPackageName: 'com.combustivel.app',
                        tileSize: 512,
                        zoomOffset: -1,
                      ),
                      if (_rotaPontos.isNotEmpty)
                        PolylineLayer(
                          polylines: [
                            Polyline(
                              points: _rotaPontos,
                              color: _azulPrimario,
                              strokeWidth: 5,
                            ),
                          ],
                        ),
                      if (_pontoOrigem != null && _pontoDestino != null)
                        MarkerLayer(
                          markers: [
                            _marcador(_pontoOrigem!, Colors.green, 'A'),
                            _marcador(_pontoDestino!, Colors.red, 'B'),
                          ],
                        ),
                      if (_waypoints.isNotEmpty)
                        MarkerLayer(
                          markers: List.generate(
                            _waypoints.length,
                            (i) => _waypointMarcador(_waypoints[i], i),
                          ),
                        ),
                      if (_pedagiosPontos.isNotEmpty)
                        MarkerLayer(
                          markers: _pedagiosPontos
                              .map((p) => Marker(
                                    point: p,
                                    width: 36,
                                    height: 36,
                                    child: _pedagioMarcador(),
                                  ))
                              .toList(),
                        ),
                      if (_mostrarPostos && _postosProximos.isNotEmpty)
                        MarkerLayer(
                          markers: _postosProximos
                              .map((p) => _postoMarcador(p))
                              .toList(),
                        ),
                      if (_mostrarCarregadores &&
                          _carregadoresEletricos.isNotEmpty)
                        MarkerLayer(
                          markers: _carregadoresEletricos
                              .map((c) => _carregadorMarcador(c))
                              .toList(),
                        ),
                      const RichAttributionWidget(
                        attributions: [
                          TextSourceAttribution('Mapbox'),
                          TextSourceAttribution('OpenStreetMap contributors'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // ── Botões de edição de rota ──────────────────────────
              if (_rotaPontos.isNotEmpty) ...[
                const SizedBox(height: 8),
                // Botão postos
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: (_buscandoPostos || _postosProximos.isEmpty)
                        ? null
                        : () => setState(
                            () => _mostrarPostos = !_mostrarPostos),
                    icon: _buscandoPostos
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.local_gas_station, size: 16),
                    label: Text(
                      _buscandoPostos
                          ? 'Buscando postos no trajeto...'
                          : _postosProximos.isEmpty
                              ? 'Nenhum posto encontrado no trajeto'
                              : _mostrarPostos
                                  ? 'Ocultar postos (${_postosProximos.length})'
                                  : 'Mostrar postos (${_postosProximos.length})',
                      style: const TextStyle(fontSize: 13),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.orange.shade700,
                      side: BorderSide(color: Colors.orange.shade700),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                // Botão carregadores elétricos
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed:
                        (_buscandoCarregadores || _carregadoresEletricos.isEmpty)
                            ? null
                            : () => setState(
                                () => _mostrarCarregadores = !_mostrarCarregadores),
                    icon: _buscandoCarregadores
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.ev_station, size: 16),
                    label: Text(
                      _buscandoCarregadores
                          ? 'Buscando carregadores elétricos...'
                          : _carregadoresEletricos.isEmpty
                              ? 'Nenhum carregador elétrico no trajeto'
                              : _mostrarCarregadores
                                  ? 'Ocultar carregadores (${_carregadoresEletricos.length})'
                                  : 'Mostrar carregadores (${_carregadoresEletricos.length})',
                      style: const TextStyle(fontSize: 13),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.green.shade700,
                      side: BorderSide(color: Colors.green.shade700),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => setState(
                            () => _modoEdicaoRota = !_modoEdicaoRota),
                        icon: Icon(
                          _modoEdicaoRota ? Icons.check : Icons.edit_road,
                          size: 16,
                        ),
                        label: Text(
                          _modoEdicaoRota
                              ? 'Concluir edição'
                              : 'Editar rota',
                          style: const TextStyle(fontSize: 13),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor:
                              _modoEdicaoRota ? Colors.orange : _azulPrimario,
                          side: BorderSide(
                            color: _modoEdicaoRota
                                ? Colors.orange
                                : _azulPrimario,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    if (_waypoints.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() => _waypoints = []);
                          _recalcularComWaypoints();
                        },
                        icon: const Icon(Icons.clear_all,
                            size: 16, color: Colors.red),
                        label: Text(
                          '${_waypoints.length} parada${_waypoints.length > 1 ? 's' : ''}',
                          style: const TextStyle(
                              fontSize: 13, color: Colors.red),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ],
                  ],
                ),
                if (_modoEdicaoRota) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Toque no mapa para adicionar paradas. Toque em uma parada para removê-la.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.orange.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
              const SizedBox(height: 12),

              // ── Buscador de distância (abaixo do mapa) ───────────
              Container(
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.route, color: _azulPrimario, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          'Calcular distância pelo Mapbox',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _azulPrimario,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Campo Origem com autocomplete
                    _buildCampoAutoComplete(
                      controller: _origemController,
                      focusNode: _origemFocus,
                      label: 'Origem',
                      hint: 'Ex: São Paulo, SP',
                      icon: Icons.location_on_outlined,
                      iconColor: Colors.green,
                      sugestoes: _sugestoesOrigem,
                      onChanged: _onOrigemChanged,
                      onSelect: (n, lat, lon) => _selecionarOrigem(n, lat, lon),
                      inputFill: inputFill,
                      borderColor: borderColor,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 8),

                    // Campo Destino com autocomplete
                    _buildCampoAutoComplete(
                      controller: _destinoController,
                      focusNode: _destinoFocus,
                      label: 'Destino',
                      hint: 'Ex: Rio de Janeiro, RJ',
                      icon: Icons.flag_outlined,
                      iconColor: Colors.red,
                      sugestoes: _sugestoesDestino,
                      onChanged: _onDestinoChanged,
                      onSelect: (n, lat, lon) => _selecionarDestino(n, lat, lon),
                      onSubmitted: (_) => _buscarDistanciaMapbox(),
                      inputFill: inputFill,
                      borderColor: borderColor,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 10),

                    // Botão buscar
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed:
                            _buscandoDistancia ? null : _buscarDistanciaMapbox,
                        icon: _buscandoDistancia
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.search, size: 18),
                        label: Text(
                          _buscandoDistancia ? 'Buscando...' : 'Buscar distância',
                          style: const TextStyle(fontSize: 14),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _azulPrimario,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: _azulPrimario.withAlpha(150),
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),

                    // Erro
                    if (_erroDistancia != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.error_outline,
                              color: Colors.red, size: 14),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(_erroDistancia!,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 12)),
                          ),
                        ],
                      ),
                    ],

                    // Sucesso
                    if (!_buscandoDistancia &&
                        _erroDistancia == null &&
                        _rotaPontos.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.check_circle_outline,
                              color: _verde, size: 14),
                          const SizedBox(width: 5),
                          Text(
                            '${_distanciaController.text} km',
                            style: const TextStyle(
                                color: _verde, fontSize: 12),
                          ),
                          if (_tempoViagem != null) ...[
                            const SizedBox(width: 10),
                            const Icon(Icons.access_time,
                                color: _azulPrimario, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              _tempoViagem!,
                              style: const TextStyle(
                                  color: _azulPrimario, fontSize: 12),
                            ),
                          ],
                          if (_pedagios > 0) ...[
                            const SizedBox(width: 10),
                            const Icon(Icons.toll,
                                color: Colors.orange, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              '$_pedagios pedágio${_pedagios > 1 ? 's' : ''}',
                              style: const TextStyle(
                                  color: Colors.orange, fontSize: 12),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // ── Distância ─────────────────────────────────────────
              _buildCampo(
                controller: _distanciaController,
                label: 'Distância (km)',
                placeholder: 'Ex: 150',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                surfaceColor: surfaceColor,
                borderColor: borderColor,
                onChanged: (_) =>
                    setState(() => _resultado = null),
              ),

              // Ida e volta
              InkWell(
                onTap: () => setState(() {
                  _idaEVolta = !_idaEVolta;
                  _resultado = null;
                }),
                borderRadius: BorderRadius.circular(6),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _idaEVolta,
                        onChanged: (v) => setState(() {
                          _idaEVolta = v ?? false;
                          _resultado = null;
                        }),
                        activeColor: _azulPrimario,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      const Text('Ida e volta',
                          style: TextStyle(fontSize: 14)),
                      const SizedBox(width: 6),
                      if (_idaEVolta && distanciaEfetiva != null)
                        Text(
                          '→ ${distanciaEfetiva.toStringAsFixed(1)} km',
                          style: const TextStyle(
                            fontSize: 13,
                            color: _azulPrimario,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      else
                        Text('(dobra a distância)',
                            style: TextStyle(
                                fontSize: 12, color: secondaryText)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 6),

              // ── Consumo ───────────────────────────────────────────
              _buildCampo(
                controller: _consumoController,
                label: 'Consumo (km/L)',
                placeholder: 'Ex: 12',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                surfaceColor: surfaceColor,
                borderColor: borderColor,
                onChanged: (_) => setState(() => _veiculoSelecionado = null),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  icon: const Icon(Icons.directions_car_outlined, size: 15),
                  label: const Text('Buscar veículo',
                      style: TextStyle(fontSize: 12)),
                  style: TextButton.styleFrom(
                    foregroundColor: _azulPrimario,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: _abrirTabelaConsumo,
                ),
              ),
              const SizedBox(height: 6),

              // ── Preço ─────────────────────────────────────────────
              _buildCampo(
                controller: _precoController,
                label: 'Preço por Litro (R\$)',
                placeholder: 'Ex: 5.89',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                surfaceColor: surfaceColor,
                borderColor: borderColor,
              ),
              const SizedBox(height: 20),

              // ── Botão Calcular ────────────────────────────────────
              ElevatedButton(
                onPressed: _calcular,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _azulPrimario,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Calcular',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ),

              // ── Resultado ─────────────────────────────────────────
              if (_resultado != null && _litrosUsados != null) ...[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _verde,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const Text('Custo estimado',
                          style:
                              TextStyle(color: Colors.white, fontSize: 14)),
                      const SizedBox(height: 4),
                      Text(
                        'R\$ ${_resultado!.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(height: 1, color: Colors.white24),
                      const SizedBox(height: 12),

                      // Litros | Combustível
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _resultItem(
                            icon: Icons.local_gas_station,
                            valor: '${_litrosUsados!.toStringAsFixed(2)} L',
                            label: 'Litros',
                          ),
                          Container(
                              width: 1, height: 44, color: Colors.white24),
                          _resultItem(
                            icon: Icons.directions_car,
                            valor: _combustivel,
                            label: _idaEVolta ? 'Ida e volta' : 'Somente ida',
                          ),
                        ],
                      ),

                      // Pedágios (só mostra se encontrou)
                      if (_pedagios > 0) ...[
                        const SizedBox(height: 10),
                        Container(height: 1, color: Colors.white24),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.toll,
                                color: Colors.white70, size: 18),
                            const SizedBox(width: 6),
                            Text(
                              '$_pedagios pedágio${_pedagios > 1 ? 's' : ''} detectado${_pedagios > 1 ? 's' : ''} na rota',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _compartilharWhatsApp,
                    icon: const Icon(Icons.share, size: 18),
                    label: const Text('Compartilhar no WhatsApp',
                        style: TextStyle(fontSize: 14)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25D366),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),

              // ── Rodapé / Sobre ────────────────────────────────────────
              Center(
                child: TextButton(
                  onPressed: () => _mostrarSobre(context),
                  child: Text(
                    'Sobre o app',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white38 : Colors.black38,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarSobre(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final corTexto = isDark ? Colors.white70 : Colors.black87;
    final corSub = isDark ? Colors.white38 : Colors.black45;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Alça
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            // Ícone + nome
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset('assets/icon.png', width: 64, height: 64),
            ),
            const SizedBox(height: 12),
            Text(
              'Abast Smart',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: corTexto,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Versão $_versaoApp',
              style: TextStyle(fontSize: 13, color: corSub),
            ),
            const SizedBox(height: 20),
            Divider(color: Colors.grey.shade300),
            const SizedBox(height: 12),

            // Sugestões e erros
            _sobreItem(
              icon: Icons.email_outlined,
              texto:
                  'Sugestões e relatórios de erro são importantes para nós.\nEntre em contato: paulobruno159@gmail.com',
              corTexto: corTexto,
              corSub: corSub,
            ),
            const SizedBox(height: 14),

            // Privacidade
            _sobreItem(
              icon: Icons.shield_outlined,
              texto:
                  'Esta aplicação não coleta dados pessoais.\nConsulte nossa política de privacidade para mais informações.',
              corTexto: corTexto,
              corSub: corSub,
            ),
            const SizedBox(height: 14),

            // Direitos autorais
            _sobreItem(
              icon: Icons.copyright_outlined,
              texto:
                  'Direitos autorais © 2024 – Todos os direitos reservados ao desenvolvedor.',
              corTexto: corTexto,
              corSub: corSub,
            ),
            const SizedBox(height: 14),

            // Ícones e imagens
            _sobreItem(
              icon: Icons.image_outlined,
              texto:
                  'Ícones e imagens reservados pelo desenvolvedor do aplicativo.',
              corTexto: corTexto,
              corSub: corSub,
            ),
            const SizedBox(height: 20),

            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                'Fechar',
                style: TextStyle(color: corSub),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sobreItem({
    required IconData icon,
    required String texto,
    required Color corTexto,
    required Color corSub,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: corSub),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            texto,
            style: TextStyle(fontSize: 13, color: corTexto, height: 1.5),
          ),
        ),
      ],
    );
  }

  // ── Widgets auxiliares ────────────────────────────────────────────────────

  Widget _buildCampoAutoComplete({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required IconData icon,
    required Color iconColor,
    required List<Map<String, dynamic>> sugestoes,
    required ValueChanged<String> onChanged,
    required Function(String nome, double lat, double lon) onSelect,
    ValueChanged<String>? onSubmitted,
    required Color inputFill,
    required Color borderColor,
    required bool isDark,
  }) {
    final textColor = isDark ? Colors.white : Colors.black87;
    final suggestionBg = isDark ? const Color(0xFF1e293b) : Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          textInputAction:
              onSubmitted != null ? TextInputAction.done : TextInputAction.next,
          style: TextStyle(fontSize: 14, color: textColor),
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            labelStyle: const TextStyle(fontSize: 13),
            prefixIcon: Icon(icon, color: iconColor, size: 20),
            filled: true,
            fillColor: inputFill,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: _azulPrimario, width: 2),
            ),
          ),
        ),
        if (sugestoes.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: suggestionBg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(30),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sugestoes.length,
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: borderColor),
              itemBuilder: (_, i) {
                final nome = sugestoes[i]['name'] as String;
                return InkWell(
                  onTap: () => onSelect(
                    nome,
                    sugestoes[i]['lat'] as double,
                    sugestoes[i]['lon'] as double,
                  ),
                  borderRadius: i == sugestoes.length - 1
                      ? const BorderRadius.vertical(
                          bottom: Radius.circular(8))
                      : BorderRadius.zero,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                            size: 16,
                            color: isDark
                                ? Colors.white54
                                : Colors.black45),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            nome,
                            style: TextStyle(
                              fontSize: 13,
                              color: textColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildCombustivelBtn(String tipo, bool isDark) {
    final selecionado = _combustivel == tipo;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _combustivel = tipo),
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selecionado ? _azulPrimario : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            tipo,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selecionado
                  ? Colors.white
                  : (isDark ? Colors.white70 : Colors.black87),
              fontWeight:
                  selecionado ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCampo({
    required TextEditingController controller,
    required String label,
    required String placeholder,
    required Color surfaceColor,
    required Color borderColor,
    TextInputType keyboardType = TextInputType.text,
    ValueChanged<String>? onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: placeholder,
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _azulPrimario, width: 2),
        ),
      ),
    );
  }

  Widget _resultItem({
    required IconData icon,
    required String valor,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(height: 4),
        Text(valor,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 11)),
      ],
    );
  }

  Marker _marcador(LatLng ponto, Color cor, String label) {
    return Marker(
      point: ponto,
      width: 32,
      height: 42,
      child: Column(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: cor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Center(
              child: Text(label,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Icon(Icons.location_on, color: cor, size: 22),
        ],
      ),
    );
  }

  Marker _postoMarcador(Map<String, dynamic> posto) {
    final lat = posto['lat'] as double;
    final lon = posto['lon'] as double;
    final nome = posto['nome'] as String;
    return Marker(
      point: LatLng(lat, lon),
      width: 32,
      height: 32,
      child: GestureDetector(
        onTap: () => _abrirModalPosto(posto),
        child: Tooltip(
          message: '$nome\nToque para avaliar',
          child: Container(
            decoration: BoxDecoration(
              color: Colors.orange.shade700,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(60),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.local_gas_station,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _pedagioMarcador() => Tooltip(
        message: 'Pedágio',
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF10b981),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
          ),
          child: const Icon(Icons.toll, size: 18, color: Colors.white),
        ),
      );

  Marker _carregadorMarcador(Map<String, dynamic> c) {
    final lat = c['lat'] as double;
    final lon = c['lon'] as double;
    final nome = c['nome'] as String;
    final network = c['network'] as String? ?? '';
    final potencia = c['potencia'] as String? ?? '';
    final capacidade = c['capacidade'] as String? ?? '';
    final tooltip = [
      nome,
      if (network.isNotEmpty) 'Rede: $network',
      if (potencia.isNotEmpty) 'Potência: ${potencia}kW',
      if (capacidade.isNotEmpty) '$capacidade pontos',
    ].join('\n');

    return Marker(
      point: LatLng(lat, lon),
      width: 32,
      height: 32,
      child: Tooltip(
        message: tooltip,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green.shade600,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(60),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.ev_station,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }

  Marker _waypointMarcador(LatLng ponto, int index) {
    return Marker(
      point: ponto,
      width: 30,
      height: 30,
      child: GestureDetector(
        onTap: () => _removerWaypoint(index),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFf97316),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(60),
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
