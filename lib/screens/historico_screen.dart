import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../config.dart';
import '../models/viagem.dart';
import '../services/historico_service.dart';
import '../services/posto_avaliacao_service.dart';

class HistoricoScreen extends StatefulWidget {
  const HistoricoScreen({super.key});

  @override
  State<HistoricoScreen> createState() => _HistoricoScreenState();
}

class _HistoricoScreenState extends State<HistoricoScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // ── Viagens ──────────────────────────────────────────────
  List<Viagem> _viagens = [];
  bool _carregandoViagens = true;

  // ── Avaliações ───────────────────────────────────────────
  List<Map<String, dynamic>> _postos = [];
  bool _carregandoAvaliacoes = true;

  static const _azulPrimario = Color(0xFF2563EB);
  static const _verde = Color(0xFF10b981);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
    _carregarViagens();
    _carregarAvaliacoes();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ── Viagens ──────────────────────────────────────────────

  Future<void> _carregarViagens() async {
    final lista = await HistoricoService.carregar();
    if (mounted) {
      setState(() {
        _viagens = lista;
        _carregandoViagens = false;
      });
    }
  }

  Future<void> _removerViagem(String id) async {
    await HistoricoService.removerViagem(id);
    setState(() => _viagens.removeWhere((v) => v.id == id));
  }

  Future<void> _limparViagens() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Limpar histórico'),
        content: const Text('Deseja remover todas as viagens do histórico?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Limpar tudo'),
          ),
        ],
      ),
    );
    if (confirmar == true) {
      await HistoricoService.limparHistorico();
      setState(() => _viagens = []);
    }
  }

  // ── Avaliações ───────────────────────────────────────────

  Future<void> _carregarAvaliacoes() async {
    setState(() => _carregandoAvaliacoes = true);
    final lista = await PostoAvaliacaoService.getPostosComAvaliacoes();
    if (!mounted) return;
    setState(() {
      _postos = lista;
      _carregandoAvaliacoes = false;
    });
  }

  Future<void> _confirmarLimparPosto(Map<String, dynamic> posto) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Apagar avaliações?'),
        content: Text(
          'Todas as avaliações de "${posto['nome']}" serão removidas.\nEsta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child:
                const Text('Apagar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (ok == true) {
      await PostoAvaliacaoService.limparAvaliacoes(
        posto['lat'] as double,
        posto['lon'] as double,
      );
      _carregarAvaliacoes();
    }
  }

  // ── Helpers ──────────────────────────────────────────────

  String _formatarData(DateTime data) {
    final d = data.day.toString().padLeft(2, '0');
    final m = data.month.toString().padLeft(2, '0');
    final y = data.year;
    final h = data.hour.toString().padLeft(2, '0');
    final min = data.minute.toString().padLeft(2, '0');
    return '$d/$m/$y $h:$min';
  }

  String _formatarDataHora(DateTime d) {
    final dia = d.day.toString().padLeft(2, '0');
    final mes = d.month.toString().padLeft(2, '0');
    final h = d.hour.toString().padLeft(2, '0');
    final m = d.minute.toString().padLeft(2, '0');
    return '$dia/$mes/${d.year} às $h:$m';
  }

  Widget _buildStars(double nota, {double size = 14}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final estrela = (i + 1).toDouble();
        IconData icon;
        if (nota >= estrela) {
          icon = Icons.star;
        } else if (nota >= estrela - 0.5) {
          icon = Icons.star_half;
        } else {
          icon = Icons.star_border;
        }
        return Icon(icon, color: Colors.orange.shade500, size: size);
      }),
    );
  }

  // ── Build ─────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isViagens = _tabController.index == 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Histórico',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: _azulPrimario,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          if (isViagens && _viagens.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined),
              tooltip: 'Limpar viagens',
              onPressed: _limparViagens,
            ),
          if (!isViagens)
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.white),
              tooltip: 'Atualizar',
              onPressed: _carregarAvaliacoes,
            ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: const [
            Tab(icon: Icon(Icons.directions_car, size: 18), text: 'Viagens'),
            Tab(
                icon: Icon(Icons.star_outline, size: 18),
                text: 'Avaliações de Postos'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildViagensTab(isDark),
          _buildAvaliacoesTab(),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════
  // ABA: VIAGENS
  // ══════════════════════════════════════════════════════════

  Widget _buildViagensTab(bool isDark) {
    final cardColor = Theme.of(context).cardColor;
    final secondaryText = isDark ? Colors.white60 : Colors.black54;

    if (_carregandoViagens) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_viagens.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: isDark ? Colors.white24 : Colors.black12,
            ),
            const SizedBox(height: 16),
            Text(
              'Nenhuma viagem registrada ainda.',
              style: TextStyle(color: secondaryText, fontSize: 15),
            ),
            const SizedBox(height: 8),
            Text(
              'Calcule um custo para salvar aqui.',
              style: TextStyle(
                  color: secondaryText,
                  fontSize: 13,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _carregarViagens,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _viagens.length,
        itemBuilder: (context, i) {
          final v = _viagens[i];
          final origemLabel =
              v.origem.isNotEmpty ? v.origem : 'Entrada manual';
          final destinoLabel = v.destino.isNotEmpty ? v.destino : '—';

          return Dismissible(
            key: Key(v.id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.red.shade400,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.delete_outline,
                  color: Colors.white, size: 26),
            ),
            onDismissed: (_) => _removerViagem(v.id),
            child: InkWell(
              onTap: () => _abrirDetalhesViagem(v, isDark, secondaryText),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(18),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.directions_car,
                              color: _azulPrimario, size: 18),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              '$origemLabel → $destinoLabel',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: isDark
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(Icons.chevron_right,
                              color: secondaryText, size: 20),
                          IconButton(
                            icon: const Icon(Icons.delete_outline,
                                color: Colors.red, size: 20),
                            onPressed: () => _removerViagem(v.id),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            tooltip: 'Excluir',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: _verde.withAlpha(25),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'R\$ ${v.custo.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: _verde,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${v.litros.toStringAsFixed(2)} L • ${v.combustivel}',
                                  style: TextStyle(
                                      color: secondaryText, fontSize: 12),
                                ),
                                if (v.veiculo != null)
                                  Text(
                                    v.veiculo!,
                                    style: TextStyle(
                                        color: secondaryText,
                                        fontSize: 11),
                                  ),
                                Text(
                                  v.idaEVolta
                                      ? 'Ida e volta'
                                      : 'Somente ida',
                                  style: TextStyle(
                                      color: secondaryText, fontSize: 11),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.straighten,
                              size: 14, color: secondaryText),
                          const SizedBox(width: 4),
                          Text(
                            '${v.distancia.toStringAsFixed(1)} km',
                            style: TextStyle(
                                color: secondaryText, fontSize: 12),
                          ),
                          if (v.pedagios > 0) ...[
                            const SizedBox(width: 12),
                            const Icon(Icons.toll,
                                size: 14, color: Colors.orange),
                            const SizedBox(width: 4),
                            Text(
                              '${v.pedagios} pedágio${v.pedagios > 1 ? 's' : ''}',
                              style: const TextStyle(
                                  color: Colors.orange, fontSize: 12),
                            ),
                          ],
                          if (v.rotaPontos != null) ...[
                            const SizedBox(width: 12),
                            const Icon(Icons.map_outlined,
                                size: 14, color: _azulPrimario),
                          ],
                          const Spacer(),
                          Icon(Icons.access_time,
                              size: 13, color: secondaryText),
                          const SizedBox(width: 4),
                          Text(
                            _formatarData(v.data),
                            style: TextStyle(
                                color: secondaryText, fontSize: 11),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _abrirDetalhesViagem(
      Viagem v, bool isDark, Color secondaryText) {
    final rotaLatLng =
        v.rotaPontos?.map((p) => LatLng(p[0], p[1])).toList();
    final temMapa = rotaLatLng != null && rotaLatLng.length >= 2;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: temMapa ? 0.85 : 0.55,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (_, scrollCtrl) {
            final surfaceBg =
                isDark ? const Color(0xFF1e293b) : Colors.white;

            return Container(
              decoration: BoxDecoration(
                color: surfaceBg,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: Row(
                      children: [
                        const Icon(Icons.directions_car,
                            color: _azulPrimario, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${v.origem.isNotEmpty ? v.origem : 'Entrada manual'} → ${v.destino.isNotEmpty ? v.destino : '—'}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color:
                                  isDark ? Colors.white : Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(ctx),
                          color: secondaryText,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      controller: scrollCtrl,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      children: [
                        if (temMapa) ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: SizedBox(
                              height: 240,
                              child: FlutterMap(
                                options: MapOptions(
                                  initialCameraFit: CameraFit.bounds(
                                    bounds: LatLngBounds.fromPoints(
                                        rotaLatLng),
                                    padding: const EdgeInsets.all(30),
                                  ),
                                  interactionOptions:
                                      const InteractionOptions(
                                    flags: InteractiveFlag.pinchZoom |
                                        InteractiveFlag.drag,
                                  ),
                                ),
                                children: [
                                  TileLayer(
                                    urlTemplate:
                                        'https://api.mapbox.com/styles/v1/mapbox/streets-v12/tiles/{z}/{x}/{y}'
                                        '?access_token=$mapboxToken',
                                    userAgentPackageName:
                                        'com.combustivel.app',
                                    tileSize: 512,
                                    zoomOffset: -1,
                                  ),
                                  PolylineLayer(
                                    polylines: [
                                      Polyline(
                                        points: rotaLatLng,
                                        color: _azulPrimario,
                                        strokeWidth: 4,
                                      ),
                                    ],
                                  ),
                                  MarkerLayer(
                                    markers: [
                                      _marcador(rotaLatLng.first,
                                          Colors.green),
                                      _marcador(
                                          rotaLatLng.last, Colors.red),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                        ],
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: _verde.withAlpha(25),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text('Custo estimado',
                                      style: TextStyle(
                                          color: secondaryText,
                                          fontSize: 12)),
                                  Text(
                                    'R\$ ${v.custo.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: _verde,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  _infoChip(
                                      Icons.local_gas_station,
                                      '${v.litros.toStringAsFixed(2)} L',
                                      secondaryText),
                                  const SizedBox(height: 4),
                                  _infoChip(
                                      Icons.straighten,
                                      '${v.distancia.toStringAsFixed(1)} km',
                                      secondaryText),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        _detalheRow(
                          isDark: isDark,
                          items: [
                            _DetalheItem(
                              icon: Icons.local_gas_station,
                              label: 'Combustível',
                              valor: v.combustivel,
                            ),
                            _DetalheItem(
                              icon: Icons.swap_horiz,
                              label: 'Trajeto',
                              valor: v.idaEVolta
                                  ? 'Ida e volta'
                                  : 'Somente ida',
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _detalheRow(
                          isDark: isDark,
                          items: [
                            if (v.veiculo != null)
                              _DetalheItem(
                                icon: Icons.directions_car,
                                label: 'Veículo',
                                valor: v.veiculo!,
                              ),
                            if (v.pedagios > 0)
                              _DetalheItem(
                                icon: Icons.toll,
                                label: 'Pedágios',
                                valor:
                                    '${v.pedagios} detectado${v.pedagios > 1 ? 's' : ''}',
                                cor: Colors.orange,
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.access_time,
                                size: 14, color: secondaryText),
                            const SizedBox(width: 6),
                            Text(
                              _formatarData(v.data),
                              style: TextStyle(
                                  color: secondaryText, fontSize: 13),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(ctx);
                            _removerViagem(v.id);
                          },
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.red, size: 18),
                          label: const Text('Excluir viagem',
                              style: TextStyle(color: Colors.red)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Marker _marcador(LatLng p, Color cor) => Marker(
        point: p,
        width: 24,
        height: 24,
        child: Icon(Icons.location_on, color: cor, size: 24),
      );

  Widget _infoChip(IconData icon, String text, Color color) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(color: color, fontSize: 12)),
        ],
      );

  Widget _detalheRow(
      {required bool isDark, required List<_DetalheItem> items}) {
    if (items.isEmpty) return const SizedBox.shrink();
    final bg = isDark ? const Color(0xFF0f172a) : const Color(0xFFf0f4ff);
    final textColor = isDark ? Colors.white : Colors.black87;
    final subColor = isDark ? Colors.white54 : Colors.black45;
    return Row(
      children: items
          .map(
            (item) => Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(item.icon,
                        size: 16, color: item.cor ?? _azulPrimario),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.label,
                              style: TextStyle(
                                  color: subColor, fontSize: 10)),
                          Text(item.valor,
                              style: TextStyle(
                                  color: item.cor ?? textColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  // ══════════════════════════════════════════════════════════
  // ABA: AVALIAÇÕES DE POSTOS
  // ══════════════════════════════════════════════════════════

  Widget _buildAvaliacoesTab() {
    if (_carregandoAvaliacoes) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_postos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.rate_review_outlined,
                size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'Nenhuma avaliação registrada ainda.',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 8),
            Text(
              'Toque em um posto no mapa para avaliar.',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _carregarAvaliacoes,
      child: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: _postos.length,
        itemBuilder: (_, i) => _buildPostoCard(_postos[i]),
      ),
    );
  }

  Widget _buildPostoCard(Map<String, dynamic> posto) {
    final nome = posto['nome'] as String? ?? 'Posto';
    final brand = posto['brand'] as String? ?? '';
    final address = posto['address'] as String? ?? '';
    final total = posto['totalAvaliacoes'] as int? ?? 0;
    final media = (posto['mediaNotas'] as num?)?.toDouble() ?? 0.0;
    final ultimoPreco = (posto['ultimoPreco'] as num?)?.toDouble();
    final ultimaAvaliacao = posto['ultimaAvaliacao'] != null
        ? DateTime.tryParse(posto['ultimaAvaliacao'] as String)
        : null;
    final lat = posto['lat'] as double;
    final lon = posto['lon'] as double;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.hardEdge,
      child: ExpansionTile(
        tilePadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        childrenPadding: EdgeInsets.zero,
        shape: const Border(),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.local_gas_station,
              color: Colors.orange.shade700, size: 22),
        ),
        title: Text(
          brand.isNotEmpty ? brand : nome,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black87),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (address.isNotEmpty)
              Text(
                address,
                style: const TextStyle(fontSize: 11, color: Colors.black45),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 4),
            Row(
              children: [
                _buildStars(media, size: 13),
                const SizedBox(width: 4),
                Text(
                  media > 0 ? media.toStringAsFixed(1) : '—',
                  style:
                      const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(width: 10),
                Icon(Icons.comment_outlined,
                    size: 12, color: Colors.grey.shade500),
                const SizedBox(width: 3),
                Text(
                  '$total avaliação${total != 1 ? 'ões' : ''}',
                  style:
                      const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                if (ultimoPreco != null) ...[
                  const SizedBox(width: 10),
                  Icon(Icons.local_gas_station,
                      size: 12, color: Colors.green.shade600),
                  const SizedBox(width: 3),
                  Text(
                    'R\$ ${ultimoPreco.toStringAsFixed(2)}/L',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
            if (ultimaAvaliacao != null) ...[
              const SizedBox(height: 2),
              Row(
                children: [
                  Icon(Icons.access_time,
                      size: 11, color: Colors.grey.shade400),
                  const SizedBox(width: 3),
                  Text(
                    _formatarDataHora(ultimaAvaliacao),
                    style:
                        TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ],
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          tooltip: 'Apagar avaliações',
          onPressed: () => _confirmarLimparPosto(posto),
        ),
        children: [
          _PostoAvaliacoesList(lat: lat, lon: lon),
        ],
      ),
    );
  }
}

// ── Lista de avaliações carregada ao expandir ──────────────────────────────

class _PostoAvaliacoesList extends StatefulWidget {
  final double lat;
  final double lon;

  const _PostoAvaliacoesList({required this.lat, required this.lon});

  @override
  State<_PostoAvaliacoesList> createState() => _PostoAvaliacoesListState();
}

class _PostoAvaliacoesListState extends State<_PostoAvaliacoesList> {
  List<PostoAvaliacao>? _avaliacoes;

  static const _azulPrimario = Color(0xFF2563EB);

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    final lista =
        await PostoAvaliacaoService.getAvaliacoes(widget.lat, widget.lon);
    if (!mounted) return;
    setState(() => _avaliacoes = lista);
  }

  @override
  Widget build(BuildContext context) {
    if (_avaliacoes == null) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (_avaliacoes!.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Nenhuma avaliação encontrada.',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
        ),
      );
    }

    return Column(
      children: [
        const Divider(height: 1),
        ..._avaliacoes!.map((a) => _buildCard(a)),
      ],
    );
  }

  Widget _buildCard(PostoAvaliacao a) {
    final dia = a.data.day.toString().padLeft(2, '0');
    final mes = a.data.month.toString().padLeft(2, '0');
    final h = a.data.hour.toString().padLeft(2, '0');
    final m = a.data.minute.toString().padLeft(2, '0');
    final dataFormatada = '$dia/$mes/${a.data.year} às $h:$m';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (a.precoGasolina != null)
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: const Color(0xFF16a34a).withAlpha(12),
              child: Row(
                children: [
                  Icon(Icons.local_gas_station,
                      size: 15, color: Colors.green.shade700),
                  const SizedBox(width: 6),
                  Text('Gasolina: ',
                      style: TextStyle(
                          fontSize: 13, color: Colors.green.shade800)),
                  Text(
                    'R\$ ${a.precoGasolina!.toStringAsFixed(2)}/L',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: _azulPrimario.withAlpha(18),
                      child: Text(
                        a.autorNome[0].toUpperCase(),
                        style: const TextStyle(
                          color: _azulPrimario,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            a.autorNome,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.access_time,
                                  size: 11,
                                  color: Colors.grey.shade500),
                              const SizedBox(width: 3),
                              Text(
                                dataFormatada,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _buildStars(a.nota),
                  ],
                ),
                if (a.comentario.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    a.comentario,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.black87),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStars(double nota, {double size = 14}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final estrela = (i + 1).toDouble();
        IconData icon;
        if (nota >= estrela) {
          icon = Icons.star;
        } else if (nota >= estrela - 0.5) {
          icon = Icons.star_half;
        } else {
          icon = Icons.star_border;
        }
        return Icon(icon, color: Colors.orange.shade500, size: size);
      }),
    );
  }
}

class _DetalheItem {
  final IconData icon;
  final String label;
  final String valor;
  final Color? cor;

  const _DetalheItem({
    required this.icon,
    required this.label,
    required this.valor,
    this.cor,
  });
}
