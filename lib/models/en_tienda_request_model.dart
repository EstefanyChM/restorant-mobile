import 'package:riccos/models/pedido_model.dart';

class EnTiendaRequestModel {
  int id;
  int idPedido;
  int idMesa;
  PedidoModel pedidoRequest;

  EnTiendaRequestModel({
    this.id = 0,
    this.idPedido = 0,
    this.idMesa = 0,
    required this.pedidoRequest, // Asegúrate de pasar un objeto PedidoRequest
  });

  // Convertir de JSON a objeto
  factory EnTiendaRequestModel.fromJson(Map<String, dynamic> json) {
    return EnTiendaRequestModel(
      id: json['id'] ?? 0,
      idPedido: json['idPedido'] ?? 0,
      idMesa: json['idMesa'] ?? 0,
      pedidoRequest: PedidoModel.fromJson(json['pedidoRequest'] ?? {}),
    );
  }

  // Convertir de objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idPedido': idPedido,
      'idMesa': idMesa,
      'pedidoRequest': pedidoRequest.toJson(),
    };
  }
}
