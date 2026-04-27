import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../config.dart';

class GpsScreen extends StatefulWidget {
  /// Destino da rota traçada no app (opcional)
  final LatLng? destino;

  /// Paradas intermediárias da rota (opcional)
  final List<LatLng> waypoints;

  const GpsScreen({
    super.key,
    this.destino,
    this.waypoints = const [],
  });

  @override
  State<GpsScreen> createState() => _GpsScreenState();
}

class _GpsScreenState extends State<GpsScreen> {
  final _mapController = MapController();
  LatLng? _posicaoAtual;
  bool _carregando = true;
  String? _erro;
  bool _seguindoLocalizacao = true;
  StreamSubscription<Position>? _positionStream;
  double _precisao = 0;
  bool _dialogMostrado = false;

  // Rota traçada no mapa
  List<LatLng> _rotaPontos = [];
  bool _buscandoRota = false;

  static const _azulPrimario = Color(0xFF2563EB);
  static const _wazeCor = Color(0xFF33CCFF);
  static const _brasilCenter = LatLng(-15.7801, -47.9292);

  bool get _temRota => widget.destino != null;

  @override
  void initState() {
    super.initState();
    _iniciarGPS();
  }

  Future<void> _iniciarGPS() async {
    setState(() {
      _carregando = true;
      _erro = null;
      _dialogMostrado = false;
      _rotaPontos = [];
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _erro =
              'GPS desativado. Ative a localização nas configurações do dispositivo.';
          _carregando = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _erro = 'Permissão de localização negada.';
            _carregando = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _erro =
              'Permissão negada permanentemente.\nAcesse Configurações > Aplicativos para habilitar a localização.';
          _carregando = false;
        });
        return;
      }

      // Tenta última posição conhecida para resposta imediata
      final ultimaPosicao = await Geolocator.getLastKnownPosition();
      if (ultimaPosicao != null && mounted) {
        final latLngRapida =
            LatLng(ultimaPosicao.latitude, ultimaPosicao.longitude);
        setState(() {
          _posicaoAtual = latLngRapida;
          _precisao = ultimaPosicao.accuracy;
          _carregando = false;
        });
        _mapController.move(latLngRapida, 15);
        await _buscarRota();
        if (!_dialogMostrado) {
          _dialogMostrado = true;
          _mostrarDialogNavegacao();
        }
      }

      // Posição atual com alta precisão
      final posicao = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      if (!mounted) return;

      final latLng = LatLng(posicao.latitude, posicao.longitude);
      setState(() {
        _posicaoAtual = latLng;
        _precisao = posicao.accuracy;
        _carregando = false;
      });

      // Re-busca rota com posição precisa
      await _buscarRota();

      if (!_dialogMostrado) {
        _dialogMostrado = true;
        _mostrarDialogNavegacao();
      }

      // Stream de atualizações contínuas
      _positionStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 5,
        ),
      ).listen((pos) {
        if (!mounted) return;
        final novaPos = LatLng(pos.latitude, pos.longitude);
        setState(() {
          _posicaoAtual = novaPos;
          _precisao = pos.accuracy;
        });
        if (_seguindoLocalizacao) {
          _mapController.move(novaPos, _mapController.camera.zoom);
        }
      });
    } catch (e) {
      if (!mounted) return;
      if (_posicaoAtual == null) {
        setState(() {
          _erro =
              'Erro ao obter localização.\nVerifique se o GPS está ativo.\n\n($e)';
          _carregando = false;
        });
      }
    }
  }

  /// Busca a rota no Mapbox da posição atual → waypoints → destino
  Future<void> _buscarRota() async {
    if (!_temRota || _posicaoAtual == null || _buscandoRota) return;
    setState(() => _buscandoRota = true);
    try {
      final allPoints = [_posicaoAtual!, ...widget.waypoints, widget.destino!];
      final coordStr =
          allPoints.map((p) => '${p.longitude},${p.latitude}').join(';');
      final url = Uri.parse(
        'https://api.mapbox.com/directions/v5/mapbox/driving/$coordStr'
        '?geometries=geojson&access_token=$mapboxToken',
      );
      final resp = await http.get(url);
      if (resp.statusCode == 200 && mounted) {
        final data = jsonDecode(resp.body) as Map<String, dynamic>;
        final routes = data['routes'] as List;
        if (routes.isNotEmpty) {
          final coords = routes[0]['geometry']['coordinates'] as List;
          final pontos = coords
              .map((c) =>
                  LatLng((c[1] as num).toDouble(), (c[0] as num).toDouble()))
              .toList();
          setState(() => _rotaPontos = pontos);
          // Ajusta câmera para mostrar a rota completa
          _mapController.fitCamera(
            CameraFit.bounds(
              bounds: LatLngBounds.fromPoints(allPoints),
              padding: const EdgeInsets.fromLTRB(40, 80, 40, 100),
            ),
          );
          setState(() => _seguindoLocalizacao = false);
        }
      }
    } catch (_) {} finally {
      if (mounted) setState(() => _buscandoRota = false);
    }
  }

  void _mostrarDialogNavegacao() {
    if (!mounted) return;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Como deseja navegar?',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            if (_temRota) ...[
              const SizedBox(height: 6),
              Text(
                'Rota do app será usada como destino',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
            const SizedBox(height: 20),
            // Waze — padrão
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  _abrirWaze();
                },
                icon: const Icon(Icons.navigation, color: Colors.white),
                label: Text(
                  _temRota ? 'Waze — navegar até o destino' : 'Waze',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _wazeCor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Google Maps — alternativa
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  _abrirGoogleMaps();
                },
                icon: Icon(Icons.map, color: Colors.green.shade700, size: 18),
                label: Text(
                  _temRota
                      ? 'Google Maps — navegar até o destino'
                      : 'Google Maps',
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(color: Colors.green.shade600, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text(
                'Ficar no app',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Waze: origem (posição atual) → waypoints (se houver) → destino
  /// O Waze não suporta waypoints por URL; passa destino final com navigate=yes
  Future<void> _abrirWaze() async {
    if (_posicaoAtual == null) return;
    final destino = widget.destino;
    final Uri wazeUri;

    if (destino != null) {
      // navigate=yes: Waze inicia navegação automaticamente ao destino.
      // Waze usa o GPS do aparelho como origem e calcula a própria rota.
      // (Waze não aceita waypoints via URL scheme — limitação do app)
      wazeUri = Uri.parse(
        'waze://ul?ll=${destino.latitude},${destino.longitude}&navigate=yes',
      );
    } else {
      wazeUri = Uri.parse(
        'waze://ul?ll=${_posicaoAtual!.latitude},${_posicaoAtual!.longitude}&z=15',
      );
    }

    try {
      await launchUrl(wazeUri, mode: LaunchMode.externalNonBrowserApplication);
    } catch (_) {
      await launchUrl(
        Uri.parse('https://play.google.com/store/apps/details?id=com.waze'),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  /// Google Maps: origem atual → waypoints → destino (rota completa)
  Future<void> _abrirGoogleMaps() async {
    if (_posicaoAtual == null) return;
    final destino = widget.destino;

    if (destino != null) {
      final waypointsStr = widget.waypoints
          .map((wp) => '${wp.latitude},${wp.longitude}')
          .join('|');
      var url = 'https://www.google.com/maps/dir/?api=1'
          '&origin=${_posicaoAtual!.latitude},${_posicaoAtual!.longitude}'
          '&destination=${destino.latitude},${destino.longitude}'
          '&travelmode=driving';
      if (waypointsStr.isNotEmpty) {
        url += '&waypoints=${Uri.encodeComponent(waypointsStr)}';
      }
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      final geoUri = Uri.parse(
        'geo:${_posicaoAtual!.latitude},${_posicaoAtual!.longitude}'
        '?q=${_posicaoAtual!.latitude},${_posicaoAtual!.longitude}',
      );
      if (await canLaunchUrl(geoUri)) {
        await launchUrl(geoUri);
      } else {
        await launchUrl(
          Uri.parse(
            'https://maps.google.com/?q=${_posicaoAtual!.latitude},${_posicaoAtual!.longitude}',
          ),
          mode: LaunchMode.externalApplication,
        );
      }
    }
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _temRota ? 'GPS — Navegando com rota' : 'GPS — Minha Localização',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: _azulPrimario,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          if (_posicaoAtual != null)
            IconButton(
              icon: Icon(
                _seguindoLocalizacao
                    ? Icons.gps_fixed
                    : Icons.gps_not_fixed,
                color: Colors.white,
              ),
              tooltip: _seguindoLocalizacao
                  ? 'Seguindo localização'
                  : 'Centralizar na minha posição',
              onPressed: () {
                setState(() => _seguindoLocalizacao = !_seguindoLocalizacao);
                if (_seguindoLocalizacao && _posicaoAtual != null) {
                  _mapController.move(
                      _posicaoAtual!, _mapController.camera.zoom);
                }
              },
            ),
        ],
      ),
      body: _carregando
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Obtendo localização...',
                      style: TextStyle(fontSize: 15)),
                ],
              ),
            )
          : _erro != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_off,
                            size: 72, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          _erro!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: _iniciarGPS,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Tentar novamente'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _azulPrimario,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Stack(
                  children: [
                    FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        initialCenter: _posicaoAtual ?? _brasilCenter,
                        initialZoom: _posicaoAtual != null ? 15.0 : 4.0,
                        onMapEvent: (event) {
                          if (event is MapEventMove &&
                              event.source !=
                                  MapEventSource.mapController) {
                            if (_seguindoLocalizacao) {
                              setState(() => _seguindoLocalizacao = false);
                            }
                          }
                        },
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
                        // Rota traçada
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
                        // Marcadores
                        MarkerLayer(
                          markers: [
                            // Posição atual
                            if (_posicaoAtual != null) ...[
                              Marker(
                                point: _posicaoAtual!,
                                width: 100,
                                height: 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _azulPrimario.withAlpha(25),
                                    border: Border.all(
                                      color: _azulPrimario.withAlpha(70),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                              Marker(
                                point: _posicaoAtual!,
                                width: 24,
                                height: 24,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _azulPrimario,
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            // Destino
                            if (_temRota)
                              Marker(
                                point: widget.destino!,
                                width: 36,
                                height: 44,
                                child: const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 36,
                                ),
                              ),
                            // Waypoints
                            ...List.generate(
                              widget.waypoints.length,
                              (i) => Marker(
                                point: widget.waypoints[i],
                                width: 28,
                                height: 28,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFf97316),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${i + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const RichAttributionWidget(
                          attributions: [
                            TextSourceAttribution('Mapbox'),
                            TextSourceAttribution(
                                'OpenStreetMap contributors'),
                          ],
                        ),
                      ],
                    ),

                    // Indicador de carregamento de rota
                    if (_buscandoRota)
                      Positioned(
                        top: 12,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(230),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(30),
                                  blurRadius: 6,
                                ),
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
                                    color: _azulPrimario,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text('Traçando rota...',
                                    style: TextStyle(fontSize: 13)),
                              ],
                            ),
                          ),
                        ),
                      ),

                    // Painel de coordenadas
                    if (_posicaoAtual != null && !_buscandoRota)
                      Positioned(
                        top: 12,
                        left: 12,
                        right: 12,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(230),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(30),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.my_location,
                                    size: 15, color: _azulPrimario),
                                const SizedBox(width: 6),
                                Text(
                                  '${_posicaoAtual!.latitude.toStringAsFixed(5)}, '
                                  '${_posicaoAtual!.longitude.toStringAsFixed(5)}',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '±${_precisao.toStringAsFixed(0)}m',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    // Botões de ação
                    if (_posicaoAtual != null)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _abrirGoogleMaps,
                                icon: const Icon(Icons.map,
                                    color: Colors.white, size: 18),
                                label: const Text(
                                  'Google Maps',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green.shade600,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _abrirWaze,
                                icon: const Icon(Icons.navigation,
                                    color: Colors.white, size: 18),
                                label: const Text(
                                  'Waze',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _wazeCor,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
    );
  }
}
