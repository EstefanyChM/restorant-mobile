import 'package:riccos/models/producto_model.dart';

class PedidoAAgregarModel {
  ProductoModel producto;
  int cantidad;
  double precioXCant;
  double precioUnitario;

  PedidoAAgregarModel({
    required this.producto,
    required this.cantidad,
    required this.precioXCant,
    required this.precioUnitario,
  });
}
