import 'dart:convert';
import 'dart:math' show min, max;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import 'gps_screen.dart';

class RotaScreen extends StatefulWidget {
  const RotaScreen({super.key});

  @override
  State<RotaScreen> createState() => _RotaScreenState();
}

class _RotaScreenState extends State<RotaScreen> {
  final _origemController = TextEditingController();
  final _destinoController = TextEditingController();
  final _mapController = MapController();

  bool _carregando = false;
  String? _erro;
  LatLng? _pontoOrigem;
  LatLng? _pontoDestino;
  List<LatLng> _rotaPontos = [];
  String? _tempoViagem;
  double? _distanciaKm;

  // Edição de rota
  List<LatLng> _waypoints = [];
  bool _modoEdicao = false;

  // Postos e carregadores
  List<LatLng> _postosGasolina = [];
  List<LatLng> _postosCarga = [];
  bool _mostrarPostos = false;
  bool _buscandoPostos = false;

  static const _azulPrimario = Color(0xFF2563EB);
  static const _fundo = Color(0xFFf0f4ff);
  static const _laranja = Color(0xFFf97316);

  static const _brasilCenter = LatLng(-15.7801, -47.9292);

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

  String _formatarTempo(double segundos) {
    final total = segundos.round();
    final horas = total ~/ 3600;
    final minutos = (total % 3600) ~/ 60;
    if (horas > 0) {
      return '${horas}h ${minutos.toString().padLeft(2, '0')}min';
    }
    return '${minutos}min';
  }

  // Retorna (pontos, distanciaKm, duracaoSegundos)
  Future<(List<LatLng>, double, double)> _buscarDirecoes(
    LatLng origem,
    LatLng destino, {
    List<LatLng> waypoints = const [],
  }) async {
    final allPoints = [origem, ...waypoints, destino];
    final coordStr =
        allPoints.map((p) => '${p.longitude},${p.latitude}').join(';');
    final url = Uri.parse(
      'https://api.mapbox.com/directions/v5/mapbox/driving/$coordStr'
      '?geometries=geojson&alternatives=true&access_token=$mapboxToken',
    );
    final resp = await http.get(url);
    if (resp.statusCode != 200) return (<LatLng>[], 0.0, 0.0);
    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    final routes = data['routes'] as List;
    if (routes.isEmpty) return (<LatLng>[], 0.0, 0.0);
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
    return (pontos, km, duracao);
  }

  Future<void> _tracarRota() async {
    final origem = _origemController.text.trim();
    final destino = _destinoController.text.trim();

    if (origem.isEmpty || destino.isEmpty) {
      setState(() => _erro = 'Preencha a origem e o destino.');
      return;
    }

    setState(() {
      _carregando = true;
      _erro = null;
      _rotaPontos = [];
      _pontoOrigem = null;
      _pontoDestino = null;
      _waypoints = [];
      _modoEdicao = false;
      _tempoViagem = null;
      _distanciaKm = null;
    });

    try {
      final pontoOrigem = await _geocodificar(origem);
      if (pontoOrigem == null) {
        setState(() {
          _erro = 'Origem não encontrada. Tente ser mais específico.';
          _carregando = false;
        });
        return;
      }

      final pontoDestino = await _geocodificar(destino);
      if (pontoDestino == null) {
        setState(() {
          _erro = 'Destino não encontrado. Tente ser mais específico.';
          _carregando = false;
        });
        return;
      }

      final (pontos, km, duracao) =
          await _buscarDirecoes(pontoOrigem, pontoDestino);

      setState(() {
        _pontoOrigem = pontoOrigem;
        _pontoDestino = pontoDestino;
        _rotaPontos = pontos;
        _distanciaKm = km;
        _tempoViagem = _formatarTempo(duracao);
        _carregando = false;
      });

      _mapController.fitCamera(
        CameraFit.bounds(
          bounds: LatLngBounds.fromPoints([pontoOrigem, pontoDestino]),
          padding: const EdgeInsets.all(70),
        ),
      );
    } catch (e) {
      setState(() {
        _erro = 'Erro ao buscar rota. Verifique sua conexão.';
        _carregando = false;
      });
    }
  }

  Future<void> _adicionarWaypoint(LatLng ponto) async {
    setState(() {
      _waypoints.add(ponto);
      _carregando = true;
    });
    await _recalcularRota();
  }

  Future<void> _removerWaypoint(int index) async {
    setState(() {
      _waypoints.removeAt(index);
      _carregando = true;
    });
    await _recalcularRota();
  }

  Future<void> _recalcularRota() async {
    if (_pontoOrigem == null || _pontoDestino == null) return;
    try {
      final (pontos, km, duracao) = await _buscarDirecoes(
        _pontoOrigem!,
        _pontoDestino!,
        waypoints: _waypoints,
      );
      setState(() {
        _rotaPontos = pontos;
        _distanciaKm = km;
        _tempoViagem = _formatarTempo(duracao);
        _carregando = false;
        _erro = null;
      });
      final allPoints = [_pontoOrigem!, ..._waypoints, _pontoDestino!];
      _mapController.fitCamera(
        CameraFit.bounds(
          bounds: LatLngBounds.fromPoints(allPoints),
          padding: const EdgeInsets.all(70),
        ),
      );
    } catch (_) {
      setState(() {
        _erro = 'Erro ao recalcular rota.';
        _carregando = false;
      });
    }
  }

  Future<void> _buscarPostosNaRota() async {
    if (_rotaPontos.isEmpty) return;
    setState(() => _buscandoPostos = true);

    // Calcula bounding box da rota com buffer de ~0.5 graus
    double minLat = _rotaPontos.map((p) => p.latitude).reduce(min);
    double maxLat = _rotaPontos.map((p) => p.latitude).reduce(max);
    double minLon = _rotaPontos.map((p) => p.longitude).reduce(min);
    double maxLon = _rotaPontos.map((p) => p.longitude).reduce(max);
    const buf = 0.1;
    final bbox = '${minLat - buf},${minLon - buf},${maxLat + buf},${maxLon + buf}';

    final query = '''
[out:json][timeout:25];
(
  node["amenity"="fuel"]($bbox);
  way["amenity"="fuel"]($bbox);
  node["amenity"="charging_station"]($bbox);
  way["amenity"="charging_station"]($bbox);
);
out center;
''';

    try {
      final resp = await http
          .post(
            Uri.parse('https://overpass-api.de/api/interpreter'),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'data=${Uri.encodeComponent(query)}',
          )
          .timeout(const Duration(seconds: 30));

      if (resp.statusCode != 200) {
        if (mounted) {
          setState(() => _buscandoPostos = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao buscar postos (servidor indisponível)')),
          );
        }
        return;
      }

      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      final elementos = (data['elements'] as List).cast<Map<String, dynamic>>();

      final gasolina = <LatLng>[];
      final carga = <LatLng>[];

      for (final el in elementos) {
        double lat, lon;
        if (el.containsKey('center')) {
          final c = el['center'] as Map<String, dynamic>;
          lat = (c['lat'] as num).toDouble();
          lon = (c['lon'] as num).toDouble();
        } else if (el.containsKey('lat') && el.containsKey('lon')) {
          lat = (el['lat'] as num).toDouble();
          lon = (el['lon'] as num).toDouble();
        } else {
          continue;
        }
        final ponto = LatLng(lat, lon);
        // Filtra apenas pontos próximos à rota (~8 km)
        if (_ptoProximoDaRota(ponto, limiteKm: 8)) {
          if (el['tags']?['amenity'] == 'fuel') {
            gasolina.add(ponto);
          } else {
            carga.add(ponto);
          }
        }
      }

      setState(() {
        _postosGasolina = gasolina;
        _postosCarga = carga;
        _buscandoPostos = false;
        _mostrarPostos = true;
      });
      if (gasolina.isEmpty && carga.isEmpty && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nenhum posto encontrado próximo à rota')),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _buscandoPostos = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha ao buscar postos: $e')),
        );
      }
    }
  }

  bool _ptoProximoDaRota(LatLng ponto, {required double limiteKm}) {
    const distCalc = Distance();
    for (final rotaPonto in _rotaPontos) {
      if (distCalc(ponto, rotaPonto) / 1000 <= limiteKm) return true;
    }
    return false;
  }

  @override
  void dispose() {
    _origemController.dispose();
    _destinoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final temRota = _rotaPontos.isNotEmpty;

    return Scaffold(
      backgroundColor: _fundo,
      appBar: AppBar(
        title: const Text(
          '🗺️ Rota da Viagem',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: _azulPrimario,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          if (_rotaPontos.isNotEmpty)
            _buscandoPostos
                ? const Padding(
                    padding: EdgeInsets.all(14),
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    ),
                  )
                : IconButton(
                    icon: Icon(
                      Icons.local_gas_station,
                      color: _mostrarPostos
                          ? Colors.yellowAccent
                          : Colors.white,
                    ),
                    tooltip: _mostrarPostos
                        ? 'Ocultar postos'
                        : 'Mostrar postos e carregadores',
                    onPressed: () {
                      if (_mostrarPostos) {
                        setState(() => _mostrarPostos = false);
                      } else if (_postosGasolina.isEmpty &&
                          _postosCarga.isEmpty) {
                        _buscarPostosNaRota();
                      } else {
                        setState(() => _mostrarPostos = true);
                      }
                    },
                  ),
          if (_pontoDestino != null)
            IconButton(
              icon: const Icon(Icons.navigation, color: Colors.white),
              tooltip: 'Navegar com GPS',
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
        ],
      ),
      floatingActionButton: temRota
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_waypoints.isNotEmpty) ...[
                  FloatingActionButton.small(
                    heroTag: 'limpar_paradas',
                    onPressed: () {
                      setState(() => _waypoints = []);
                      _recalcularRota();
                    },
                    backgroundColor: Colors.red.shade400,
                    tooltip: 'Remover todas as paradas',
                    child: const Icon(Icons.clear_all, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                ],
                FloatingActionButton(
                  heroTag: 'editar_rota',
                  onPressed: () =>
                      setState(() => _modoEdicao = !_modoEdicao),
                  backgroundColor:
                      _modoEdicao ? _laranja : _azulPrimario,
                  tooltip:
                      _modoEdicao ? 'Concluir edição' : 'Editar rota',
                  child: Icon(
                    _modoEdicao ? Icons.check : Icons.edit_road,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          : null,
      body: Column(
        children: [
          // Formulário
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _origemController,
                  textInputAction: TextInputAction.next,
                  decoration: _inputDecoration(
                    label: 'Origem',
                    hint: 'Ex: São Paulo, SP',
                    icon: Icons.location_on_outlined,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _destinoController,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _tracarRota(),
                  decoration: _inputDecoration(
                    label: 'Destino',
                    hint: 'Ex: Rio de Janeiro, RJ',
                    icon: Icons.flag_outlined,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _carregando ? null : _tracarRota,
                    icon: _carregando
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.directions),
                    label: Text(
                      _carregando ? 'Buscando rota...' : 'Traçar Rota',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _azulPrimario,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                          _azulPrimario.withAlpha(150),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                if (_erro != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.error_outline,
                          color: Colors.red, size: 16),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          _erro!,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ],
                // Info da rota (distância + tempo)
                if (_rotaPontos.isNotEmpty &&
                    _distanciaKm != null &&
                    _tempoViagem != null) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2563EB).withAlpha(15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: const Color(0xFF2563EB).withAlpha(60)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.straighten,
                                color: Color(0xFF2563EB), size: 16),
                            const SizedBox(width: 5),
                            Text(
                              '${_distanciaKm!.toStringAsFixed(1)} km',
                              style: const TextStyle(
                                color: Color(0xFF2563EB),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Container(
                            width: 1,
                            height: 20,
                            color: const Color(0xFF2563EB).withAlpha(60)),
                        Row(
                          children: [
                            const Icon(Icons.access_time,
                                color: Color(0xFF2563EB), size: 16),
                            const SizedBox(width: 5),
                            Text(
                              _tempoViagem!,
                              style: const TextStyle(
                                color: Color(0xFF2563EB),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Banner de edição de rota
          if (_modoEdicao)
            Container(
              color: _laranja.withAlpha(30),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.touch_app, color: _laranja, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Toque no mapa para adicionar uma parada. Toque em uma parada para removê-la.',
                      style: TextStyle(color: _laranja, fontSize: 12),
                    ),
                  ),
                  if (_waypoints.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _laranja,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${_waypoints.length}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ],
              ),
            ),

          // Mapa
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _brasilCenter,
                    initialZoom: 4,
                    onTap: _modoEdicao
                        ? (_, latLng) => _adicionarWaypoint(latLng)
                        : null,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://api.mapbox.com/styles/v1/mapbox/streets-v12/tiles/{z}/{x}/{y}'
                          '?access_token=$mapboxToken',
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
                          _buildMarcador(_pontoOrigem!, Colors.green, 'Origem'),
                          _buildMarcador(_pontoDestino!, Colors.red, 'Destino'),
                        ],
                      ),
                    if (_waypoints.isNotEmpty)
                      MarkerLayer(
                        markers: List.generate(
                          _waypoints.length,
                          (i) => _buildWaypointMarker(_waypoints[i], i),
                        ),
                      ),
                    if (_mostrarPostos && _postosGasolina.isNotEmpty)
                      MarkerLayer(
                        markers: _postosGasolina
                            .map((p) => _buildPostoMarker(p, tipo: 'gasolina'))
                            .toList(),
                      ),
                    if (_mostrarPostos && _postosCarga.isNotEmpty)
                      MarkerLayer(
                        markers: _postosCarga
                            .map((p) => _buildPostoMarker(p, tipo: 'carga'))
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
                // Legenda de postos
                if (_mostrarPostos &&
                    (_postosGasolina.isNotEmpty || _postosCarga.isNotEmpty))
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(230),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withAlpha(30),
                              blurRadius: 4),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_postosGasolina.isNotEmpty)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: const BoxDecoration(
                                      color: Colors.orange,
                                      shape: BoxShape.circle),
                                  child: const Icon(Icons.local_gas_station,
                                      size: 9, color: Colors.white),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${_postosGasolina.length} posto${_postosGasolina.length > 1 ? 's' : ''}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          if (_postosGasolina.isNotEmpty &&
                              _postosCarga.isNotEmpty)
                            const SizedBox(height: 4),
                          if (_postosCarga.isNotEmpty)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: const BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle),
                                  child: const Icon(Icons.ev_station,
                                      size: 9, color: Colors.white),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${_postosCarga.length} carregador${_postosCarga.length > 1 ? 'es' : ''}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                // Loading overlay
                if (_carregando)
                  Positioned(
                    top: 12,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(230),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withAlpha(30),
                                blurRadius: 6),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xFF2563EB)),
                            ),
                            SizedBox(width: 8),
                            Text('Recalculando rota...',
                                style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Marker _buildPostoMarker(LatLng ponto, {required String tipo}) {
    final isGasolina = tipo == 'gasolina';
    return Marker(
      point: ponto,
      width: 28,
      height: 28,
      child: Tooltip(
        message: isGasolina ? 'Posto de combustível' : 'Carregador elétrico',
        child: Container(
          decoration: BoxDecoration(
            color: isGasolina ? Colors.orange : Colors.green,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.5),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withAlpha(60),
                  blurRadius: 3,
                  offset: const Offset(0, 1)),
            ],
          ),
          child: Icon(
            isGasolina ? Icons.local_gas_station : Icons.ev_station,
            color: Colors.white,
            size: 15,
          ),
        ),
      ),
    );
  }

  Marker _buildMarcador(LatLng ponto, Color cor, String label) {
    return Marker(
      point: ponto,
      width: 48,
      height: 56,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: cor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              label,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Icon(Icons.location_on, color: cor, size: 28),
        ],
      ),
    );
  }

  Marker _buildWaypointMarker(LatLng ponto, int index) {
    return Marker(
      point: ponto,
      width: 36,
      height: 36,
      child: GestureDetector(
        onTap: () => _removerWaypoint(index),
        child: Container(
          decoration: BoxDecoration(
            color: _laranja,
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
          child: Center(
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: _azulPrimario),
      filled: true,
      fillColor: _fundo,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFdddddd)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFdddddd)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _azulPrimario, width: 2),
      ),
    );
  }
}
