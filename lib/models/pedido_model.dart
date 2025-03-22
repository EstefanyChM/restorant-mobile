import 'package:riccos/models/detalle_pedido_model.dart';

class PedidoModel {
  int id;
  int idServicio;
  bool estado;
  bool finalizado;
  bool ventaFinalizada;
  double total;
  String horaEntrada;
  List<DetallePedidoModel> detallePedidosRequest;
  List<DetallePedidoModel> detallePedidoResp;

  PedidoModel({
    this.id = 0,
    this.idServicio = 0,
    this.estado = false,
    this.finalizado = false,
    this.ventaFinalizada = false,
    this.total = 0.0,
    this.horaEntrada = "00:00:00",
    this.detallePedidosRequest = const [],
    this.detallePedidoResp = const [],
  });

  factory PedidoModel.fromJson(Map<String, dynamic> json) {
    return PedidoModel(
      id: json['id'] ?? 0,
      idServicio: json['idServicio'] ?? 0,
      estado: json['estado'] ?? false,
      finalizado: json['finalizado'] ?? false,
      ventaFinalizada: json['ventaFinalizada'] ?? false,
      total: json['total']?.toDouble() ?? 0.0,
      horaEntrada: json['horaEntrada'] ?? "00:00:00",
      detallePedidosRequest: (json['detallePedidosRequest'] as List<dynamic>?)
              ?.map((item) => DetallePedidoModel.fromJson(item))
              .toList() ??
          [],
      detallePedidoResp: (json['detallePedidoResp'] as List<dynamic>?)
              ?.map((item) => DetallePedidoModel.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idServicio': idServicio,
      'estado': estado,
      'finalizado': finalizado,
      'ventaFinalizada': ventaFinalizada,
      'total': total,
      'horaEntrada': horaEntrada,
      'detallePedidosRequest':
          detallePedidosRequest.map((item) => item.toJson()).toList(),
      'detallePedidoResp':
          detallePedidoResp.map((item) => item.toJson()).toList(),
    };
  }
}
