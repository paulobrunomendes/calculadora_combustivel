import 'package:flutter/material.dart';
import '../services/posto_avaliacao_service.dart';

class PostoDetalheSheet extends StatefulWidget {
  final Map<String, dynamic> posto;

  const PostoDetalheSheet({super.key, required this.posto});

  @override
  State<PostoDetalheSheet> createState() => _PostoDetalheSheetState();
}

class _PostoDetalheSheetState extends State<PostoDetalheSheet> {
  List<PostoAvaliacao> _avaliacoes = [];
  bool _carregando = true;
  bool _mostrarFormulario = false;

  // Formulário
  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();
  final _comentarioController = TextEditingController();
  double _notaSelecionada = 5;
  bool _enviando = false;

  static const _azulPrimario = Color(0xFF2563EB);
  static const _laranja = Color(0xFFf97316);
  static const _verde = Color(0xFF16a34a);

  @override
  void initState() {
    super.initState();
    _carregarAvaliacoes();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    _comentarioController.dispose();
    super.dispose();
  }

  Future<void> _carregarAvaliacoes() async {
    final lat = widget.posto['lat'] as double;
    final lon = widget.posto['lon'] as double;
    final lista = await PostoAvaliacaoService.getAvaliacoes(lat, lon);
    if (!mounted) return;
    setState(() {
      _avaliacoes = lista;
      _carregando = false;
    });
  }

  Future<void> _enviarAvaliacao() async {
    if (_notaSelecionada == 0) return;
    setState(() => _enviando = true);

    final lat = widget.posto['lat'] as double;
    final lon = widget.posto['lon'] as double;
    final nome = _nomeController.text.trim().isEmpty
        ? 'Anônimo'
        : _nomeController.text.trim();

    final precoTexto = _precoController.text.trim().replaceAll(',', '.');
    final preco = double.tryParse(precoTexto);

    final avaliacao = PostoAvaliacao(
      autorNome: nome,
      nota: _notaSelecionada,
      precoGasolina: preco,
      comentario: _comentarioController.text.trim(),
      data: DateTime.now(),
    );

    await PostoAvaliacaoService.adicionarAvaliacao(
      lat,
      lon,
      avaliacao,
      postoInfo: widget.posto,
    );
    await _carregarAvaliacoes();

    if (!mounted) return;
    setState(() {
      _enviando = false;
      _mostrarFormulario = false;
      _nomeController.clear();
      _precoController.clear();
      _comentarioController.clear();
      _notaSelecionada = 5;
    });
  }

  double get _mediaNotas {
    if (_avaliacoes.isEmpty) return 0;
    final soma = _avaliacoes.fold(0.0, (acc, a) => acc + a.nota);
    return soma / _avaliacoes.length;
  }

  // Último preço informado (avaliação mais recente com preço)
  double? get _ultimoPreco {
    for (final a in _avaliacoes) {
      if (a.precoGasolina != null) return a.precoGasolina;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final nome = widget.posto['nome'] as String;
    final brand = widget.posto['brand'] as String? ?? '';
    final address = widget.posto['address'] as String? ?? '';
    final phone = widget.posto['phone'] as String? ?? '';

    return DraggableScrollableSheet(
      initialChildSize: 0.60,
      minChildSize: 0.35,
      maxChildSize: 0.92,
      expand: false,
      builder: (_, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              // Handle + botão fechar
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 8, 4),
                child: Row(
                  children: [
                    const Spacer(),
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black54),
                      tooltip: 'Fechar',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  children: [
                    // Cabeçalho
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.local_gas_station,
                            color: Colors.orange.shade700,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                brand.isNotEmpty ? brand : nome,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              if (brand.isNotEmpty && brand != nome)
                                Text(
                                  nome,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                  ),
                                ),
                              if (address.isNotEmpty)
                                Text(
                                  address,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black45,
                                  ),
                                ),
                              if (phone.isNotEmpty)
                                Text(
                                  phone,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue.shade700,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Painel: média + último preço
                    if (!_carregando)
                      Row(
                        children: [
                          // Média de estrelas
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.orange.shade100),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildStars(_mediaNotas, size: 18),
                                  const SizedBox(height: 2),
                                  Text(
                                    _avaliacoes.isEmpty
                                        ? 'Sem avaliações'
                                        : '${_mediaNotas.toStringAsFixed(1)} / 5',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.orange.shade900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Último preço informado
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.green.shade100),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.local_gas_station,
                                          size: 14,
                                          color: Colors.green.shade700),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Gasolina',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.green.shade800,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    _ultimoPreco != null
                                        ? 'R\$ ${_ultimoPreco!.toStringAsFixed(2)}/L'
                                        : 'Preço não informado',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: _ultimoPreco != null
                                          ? Colors.green.shade800
                                          : Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 14),

                    // Botões: avaliar e fechar
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => setState(() =>
                                _mostrarFormulario = !_mostrarFormulario),
                            icon: Icon(
                              _mostrarFormulario
                                  ? Icons.close
                                  : Icons.edit_note,
                            ),
                            label: Text(
                              _mostrarFormulario ? 'Cancelar' : 'Informar preço',
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _mostrarFormulario
                                  ? Colors.grey.shade600
                                  : _azulPrimario,
                              foregroundColor: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close),
                            label: const Text('Fechar'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black87,
                              side: BorderSide(color: Colors.grey.shade400),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Formulário colaborativo
                    if (_mostrarFormulario) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue.shade100),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Título colaborativo
                            Row(
                              children: [
                                Icon(Icons.people,
                                    size: 18, color: Colors.blue.shade700),
                                const SizedBox(width: 8),
                                const Expanded(
                                  child: Text(
                                    'Contribua com a comunidade',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Informe o preço atual da gasolina neste posto e ajude outros motoristas a economizar!',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 14),

                            // ── Preço da gasolina (campo principal) ──────
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.green.shade300, width: 1.5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.local_gas_station,
                                          size: 16,
                                          color: Colors.green.shade700),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Preço da Gasolina',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green.shade800,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.green.shade100,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'RECOMENDADO',
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green.shade800,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: _precoController,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: InputDecoration(
                                      prefixText: 'R\$  ',
                                      prefixStyle: TextStyle(
                                        color: Colors.green.shade700,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      suffixText: '/ litro',
                                      suffixStyle: const TextStyle(
                                        color: Colors.black45,
                                        fontSize: 13,
                                      ),
                                      hintText: '0,00',
                                      hintStyle: const TextStyle(
                                          color: Colors.black26, fontSize: 20),
                                      filled: true,
                                      fillColor: Colors.white,
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 0),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Estrelas
                            const Text(
                              'Avaliação geral do posto:',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: List.generate(5, (i) {
                                final nota = (i + 1).toDouble();
                                return GestureDetector(
                                  onTap: () => setState(
                                      () => _notaSelecionada = nota),
                                  child: Icon(
                                    nota <= _notaSelecionada
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.orange.shade600,
                                    size: 34,
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 12),

                            // Nome
                            TextField(
                              controller: _nomeController,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Seu nome (opcional)',
                                labelStyle:
                                    const TextStyle(color: Colors.black54),
                                hintText: 'Anônimo',
                                hintStyle:
                                    const TextStyle(color: Colors.black38),
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade400),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade400),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Comentário
                            TextField(
                              controller: _comentarioController,
                              maxLines: 3,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Observações (opcional)',
                                labelStyle:
                                    const TextStyle(color: Colors.black54),
                                hintText:
                                    'Ex: Fila rápida, banheiro limpo, aceita PIX...',
                                hintStyle:
                                    const TextStyle(color: Colors.black38),
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade400),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade400),
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),

                            // Botão enviar
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed:
                                    _enviando ? null : _enviarAvaliacao,
                                icon: _enviando
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Icon(Icons.send),
                                label: Text(_enviando
                                    ? 'Enviando...'
                                    : 'Publicar informação'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _laranja,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 20),

                    // Lista de avaliações
                    if (_carregando)
                      const Center(child: CircularProgressIndicator())
                    else if (_avaliacoes.isEmpty)
                      Center(
                        child: Column(
                          children: [
                            Icon(Icons.rate_review_outlined,
                                size: 48, color: Colors.grey.shade400),
                            const SizedBox(height: 8),
                            Text(
                              'Nenhuma informação ainda.\nSeja o primeiro a contribuir!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      )
                    else ...[
                      Row(
                        children: [
                          const Icon(Icons.history, size: 16, color: Colors.black54),
                          const SizedBox(width: 6),
                          Text(
                            'Histórico de preços e avaliações (${_avaliacoes.length})',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ..._avaliacoes.map((a) => _buildAvaliacaoCard(a)),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStars(double nota, {double size = 16}) {
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
        return Icon(icon, color: Colors.orange.shade600, size: size);
      }),
    );
  }

  Widget _buildAvaliacaoCard(PostoAvaliacao avaliacao) {
    final dia = avaliacao.data.day.toString().padLeft(2, '0');
    final mes = avaliacao.data.month.toString().padLeft(2, '0');
    final ano = avaliacao.data.year;
    final hora = avaliacao.data.hour.toString().padLeft(2, '0');
    final min = avaliacao.data.minute.toString().padLeft(2, '0');
    final dataFormatada = '$dia/$mes/$ano às $hora:$min';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Preço em destaque (quando informado)
          if (avaliacao.precoGasolina != null)
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: _verde.withAlpha(15),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                border: Border(
                    bottom: BorderSide(color: Colors.green.shade100)),
              ),
              child: Row(
                children: [
                  Icon(Icons.local_gas_station,
                      size: 18, color: Colors.green.shade700),
                  const SizedBox(width: 8),
                  Text(
                    'Gasolina: ',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.green.shade800,
                    ),
                  ),
                  Text(
                    'R\$ ${avaliacao.precoGasolina!.toStringAsFixed(2)}/L',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
            ),

          // Corpo do card
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: _azulPrimario.withAlpha(20),
                      child: Text(
                        avaliacao.autorNome[0].toUpperCase(),
                        style: const TextStyle(
                          color: _azulPrimario,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            avaliacao.autorNome,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                          // Data + hora fixada e sempre visível
                          Row(
                            children: [
                              Icon(Icons.access_time,
                                  size: 11, color: Colors.grey.shade500),
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
                    _buildStars(avaliacao.nota),
                  ],
                ),
                if (avaliacao.comentario.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    avaliacao.comentario,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
