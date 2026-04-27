class Viagem {
  final String id;
  final String origem;
  final String destino;
  final double distancia;
  final double custo;
  final double litros;
  final String combustivel;
  final bool idaEVolta;
  final int pedagios;
  final DateTime data;
  final String? veiculo;
  // Lista de [lat, lng] da rota traçada no mapa
  final List<List<double>>? rotaPontos;

  const Viagem({
    required this.id,
    required this.origem,
    required this.destino,
    required this.distancia,
    required this.custo,
    required this.litros,
    required this.combustivel,
    required this.idaEVolta,
    required this.pedagios,
    required this.data,
    this.veiculo,
    this.rotaPontos,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'origem': origem,
        'destino': destino,
        'distancia': distancia,
        'custo': custo,
        'litros': litros,
        'combustivel': combustivel,
        'idaEVolta': idaEVolta,
        'pedagios': pedagios,
        'data': data.toIso8601String(),
        if (veiculo != null) 'veiculo': veiculo,
        if (rotaPontos != null) 'rotaPontos': rotaPontos,
      };

  factory Viagem.fromJson(Map<String, dynamic> json) => Viagem(
        id: json['id'] as String,
        origem: json['origem'] as String,
        destino: json['destino'] as String,
        distancia: (json['distancia'] as num).toDouble(),
        custo: (json['custo'] as num).toDouble(),
        litros: (json['litros'] as num).toDouble(),
        combustivel: json['combustivel'] as String,
        idaEVolta: json['idaEVolta'] as bool,
        pedagios: (json['pedagios'] as num).toInt(),
        data: DateTime.parse(json['data'] as String),
        veiculo: json['veiculo'] as String?,
        rotaPontos: (json['rotaPontos'] as List?)
            ?.map((p) =>
                (p as List).map((v) => (v as num).toDouble()).toList())
            .toList(),
      );
}
