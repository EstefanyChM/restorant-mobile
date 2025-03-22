class EnTiendaResponseModel {
  int id = 0;
  int idMesa = 0;
  int idPedido = 0;
  double total = 0;
  bool finalizado = false;

  EnTiendaResponseModel({
    required this.id,
    required this.idMesa,
    required this.idPedido,
    required this.total,
    required this.finalizado,
  });

  factory EnTiendaResponseModel.fromJson(Map<String, dynamic> json) {
    return EnTiendaResponseModel(
      id: json['id'],
      idMesa: json['idMesa'],
      idPedido: json['idPedido'],
      total: json['total']?.toDouble() ?? 0.0,
      finalizado: json['finalizado'],
    );
  }
}
