import 'package:riccos/models/pedido_a_agregar_model.dart';

class PedidoProvider {
  static final PedidoProvider _instance = PedidoProvider._internal();
  factory PedidoProvider() => _instance;

  PedidoProvider._internal();

  List<PedidoAAgregarModel> pedidos = [];

  // Getter para obtener el total de todos los pedidos
  double get totalPedidos {
    return pedidos.fold(0.0, (total, pedido) => total + pedido.precioXCant);
  }
}

final pedidoProvider = PedidoProvider();
