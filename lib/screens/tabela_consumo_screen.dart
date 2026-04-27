import 'package:flutter/material.dart';
import '../data/consumo_veiculos.dart';

class TabelaConsumoScreen extends StatefulWidget {
  const TabelaConsumoScreen({super.key});

  @override
  State<TabelaConsumoScreen> createState() => _TabelaConsumoScreenState();
}

class _TabelaConsumoScreenState extends State<TabelaConsumoScreen> {
  static const _azulPrimario = Color(0xFF2563EB);

  String _tipoFiltro = 'Carro';
  String _categoriaFiltro = 'Todos';
  String _busca = '';
  final _buscaController = TextEditingController();

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
  }

  List<String> get _categoriasDisponiveis {
    if (_tipoFiltro == 'Carro') {
      return ['Todos', 'Hatch', 'Sedan', 'SUV', 'Picape'];
    } else {
      return ['Todos', 'Urbana', 'Naked', 'Trail', 'Scooter', 'Esportiva', 'Custom'];
    }
  }

  List<VeiculoConsumo> get _veiculosFiltrados {
    return veiculosConsumo.where((v) {
      if (v.tipo != _tipoFiltro) return false;
      if (_categoriaFiltro != 'Todos' && v.categoria != _categoriaFiltro) {
        return false;
      }
      if (_busca.isNotEmpty) {
        final q = _busca.toLowerCase();
        return v.marca.toLowerCase().contains(q) ||
            v.modelo.toLowerCase().contains(q) ||
            v.motor.toLowerCase().contains(q);
      }
      return true;
    }).toList();
  }

  void _selecionarConsumo(VeiculoConsumo veiculo) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? const Color(0xFF1e293b) : Colors.white;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: surfaceColor,
        title: Text(
          '${veiculo.marca} ${veiculo.modelo}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(veiculo.motor,
                style: const TextStyle(fontSize: 13, color: Colors.grey)),
            const SizedBox(height: 12),
            const Text('Qual consumo deseja usar no cálculo?'),
            const SizedBox(height: 8),
            _opcaoConsumo(
              ctx: ctx,
              icone: Icons.location_city_outlined,
              titulo: 'Cidade',
              valor: veiculo.consumoCidade,
              veiculo: veiculo,
            ),
            _opcaoConsumo(
              ctx: ctx,
              icone: Icons.route_outlined,
              titulo: 'Estrada',
              valor: veiculo.consumoEstrada,
              veiculo: veiculo,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  Widget _opcaoConsumo({
    required BuildContext ctx,
    required IconData icone,
    required String titulo,
    required double valor,
    required VeiculoConsumo veiculo,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        Navigator.pop(ctx);
        Navigator.pop(context, (valor, '${veiculo.marca} ${veiculo.modelo}'));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: _azulPrimario.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icone, size: 20, color: _azulPrimario),
            const SizedBox(width: 8),
            Text(titulo, style: const TextStyle(fontWeight: FontWeight.w500)),
            const Spacer(),
            Text(
              '${valor.toStringAsFixed(1)} km/L',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: _azulPrimario,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tipoBtn(String label, IconData icon, String value, bool isDark,
      Color borderColor) {
    final selected = _tipoFiltro == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (_tipoFiltro == value) return;
          setState(() {
            _tipoFiltro = value;
            _categoriaFiltro = 'Todos';
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? _azulPrimario : Colors.transparent,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 18, color: selected ? Colors.white : Colors.grey),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? const Color(0xFF1e293b) : Colors.white;
    final borderColor =
        isDark ? const Color(0xFF334155) : const Color(0xFFDDDDDD);
    final secondaryText = isDark ? Colors.white60 : Colors.black54;
    final bgColor = isDark ? const Color(0xFF0f172a) : const Color(0xFFf0f4ff);

    final veiculos = _veiculosFiltrados;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Consumo Médio dos Veículos'),
        backgroundColor: _azulPrimario,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // ── Toggle Carro / Moto ───────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                children: [
                  _tipoBtn('Carros', Icons.directions_car, 'Carro', isDark,
                      borderColor),
                  _tipoBtn('Motos', Icons.two_wheeler, 'Moto', isDark,
                      borderColor),
                ],
              ),
            ),
          ),

          // ── Busca ─────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
            child: TextField(
              controller: _buscaController,
              decoration: InputDecoration(
                hintText: 'Buscar marca, modelo ou motor...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _busca.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(() {
                          _busca = '';
                          _buscaController.clear();
                        }),
                      )
                    : null,
                filled: true,
                fillColor: surfaceColor,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
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
              onChanged: (v) => setState(() => _busca = v),
            ),
          ),

          // ── Filtro de categoria ───────────────────────────────────────────
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              children: _categoriasDisponiveis.map((cat) {
                final selected = _categoriaFiltro == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cat),
                    selected: selected,
                    onSelected: (_) =>
                        setState(() => _categoriaFiltro = cat),
                    selectedColor: _azulPrimario,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : null,
                      fontWeight: selected ? FontWeight.w600 : null,
                    ),
                    checkmarkColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 4),

          // ── Nota ──────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _tipoFiltro == 'Carro'
                        ? '* km/L com gasolina (flex). Fonte: INMETRO/PBE 2024-2025. Toque para usar.'
                        : '* km/L com gasolina. Fonte: fabricantes/INMETRO. Toque para usar.',
                    style: TextStyle(fontSize: 11, color: secondaryText),
                  ),
                ),
                Text(
                  '${veiculos.length} modelos',
                  style: TextStyle(
                      fontSize: 11,
                      color: _azulPrimario,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),

          // ── Cabeçalho da tabela ───────────────────────────────────────────
          Container(
            color: _azulPrimario.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text('Veículo',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: _azulPrimario)),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                      _tipoFiltro == 'Carro' ? 'Motor' : 'Cilindrada',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: _azulPrimario)),
                ),
                Expanded(
                  flex: 2,
                  child: Text('Cidade',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: _azulPrimario)),
                ),
                Expanded(
                  flex: 2,
                  child: Text('Estrada',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: _azulPrimario)),
                ),
              ],
            ),
          ),

          // ── Lista ─────────────────────────────────────────────────────────
          Expanded(
            child: veiculos.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off, size: 48, color: secondaryText),
                        const SizedBox(height: 8),
                        Text('Nenhum veículo encontrado',
                            style: TextStyle(color: secondaryText)),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: veiculos.length,
                    separatorBuilder: (_, __) =>
                        Divider(height: 1, color: borderColor),
                    itemBuilder: (context, index) {
                      final v = veiculos[index];
                      return InkWell(
                        onTap: () => _selecionarConsumo(v),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(v.marca,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: secondaryText)),
                                    Text(v.modelo,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14)),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(v.motor,
                                    style: TextStyle(
                                        fontSize: 11, color: secondaryText)),
                              ),
                              Expanded(
                                flex: 2,
                                child: _consumoCell(v.consumoCidade),
                              ),
                              Expanded(
                                flex: 2,
                                child: _consumoCell(v.consumoEstrada),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _consumoCell(double valor) {
    Color cor;
    if (_tipoFiltro == 'Carro') {
      if (valor >= 13) cor = const Color(0xFF10b981);
      else if (valor >= 10) cor = const Color(0xFFF97316);
      else cor = const Color(0xFFEF4444);
    } else {
      if (valor >= 35) cor = const Color(0xFF10b981);
      else if (valor >= 18) cor = const Color(0xFFF97316);
      else cor = const Color(0xFFEF4444);
    }

    return Text(
      valor.toStringAsFixed(1),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: cor,
      ),
    );
  }
}
