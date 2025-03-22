// For demo only

class PedidoMesaModel {
  int? idEnTienda;
  int idMesa;
  int nroMesa;
  bool disponible;
  bool? finalizado;
  int? idPedido; // Opcional, puede ser null
  double? total; // Opcional, puede ser null

  PedidoMesaModel({
    this.idEnTienda = 0,
    this.idMesa = 0,
    this.nroMesa = 0,
    this.disponible = false,
    this.finalizado = false,
    this.idPedido,
    this.total,
  });

  // Método estático toJson para convertir un objeto a JSON
  factory PedidoMesaModel.fromJson(Map<String, dynamic> json) {
    return PedidoMesaModel(
      idEnTienda: json['idEnTienda'],
      idMesa: json['idMesa'],
      nroMesa: json['nroMesa'],
      disponible: json['disponible'],
      finalizado: json['finalizado'],
      idPedido: json['idPedido'],
      total: json['total']?.toDouble(),
    );
  }

  // Si deseas tener también un método para convertir a JSON desde un objeto
  Map<String, dynamic> toJson() {
    return {
      'idEnTienda': idEnTienda,
      'idMesa': idMesa,
      'nroMesa': nroMesa,
      'disponible': disponible,
      'finalizado': finalizado,
      'idPedido': idPedido,
      'total': total,
    };
  }
}

List<PedidoMesaModel> demoPopularProducts = [
  PedidoMesaModel(
    idEnTienda: 1,
    idMesa: 101,
    nroMesa: 1,
    disponible: true,
    finalizado: false,
    idPedido: null,
    total: null,
  ),
];

List<PedidoMesaModel> demoFlashSaleProducts = [
  PedidoMesaModel(
    idEnTienda: 2,
    idMesa: 102,
    nroMesa: 2,
    disponible: false,
    finalizado: true,
    idPedido: 5001,
    total: 98.76,
  ),
];

List<PedidoMesaModel> demoBestSellersProducts = [
  PedidoMesaModel(
    idEnTienda: 3,
    idMesa: 103,
    nroMesa: 3,
    disponible: true,
    finalizado: false,
    idPedido: 5002,
    total: 45.50,
  ),
];
