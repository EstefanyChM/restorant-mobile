import 'package:flutter/material.dart';
import 'package:riccos/components/cart_button.dart';
import 'package:riccos/constants.dart';
import 'package:riccos/entry_point.dart';
import 'package:riccos/models/detalle_pedido_model.dart';
import 'package:riccos/models/en_tienda_request_model.dart';
import 'package:riccos/models/pedido_a_agregar_model.dart';
import 'package:riccos/models/pedido_mesa_model.dart';
import 'package:riccos/models/pedido_model.dart';
import 'package:riccos/providers/pedido_provider.dart';
import 'package:riccos/services/api_service.dart';
import 'package:riccos/services/websocket-service.dart';

class ResumenPedidoScreen extends StatefulWidget {
  final PedidoMesaModel pedidoMesa;

  const ResumenPedidoScreen({
    Key? key,
    required this.pedidoMesa,
  }) : super(key: key);

  @override
  _ResumenPedidoScreenState createState() => _ResumenPedidoScreenState();
}

class _ResumenPedidoScreenState extends State<ResumenPedidoScreen> {
  final ApiService _apiService = ApiService();
  final websocketService = WebsocketService();

  List<PedidoAAgregarModel> get productosSeleccionados =>
      pedidoProvider.pedidos;

  void eliminarProducto(int index) {
    setState(() {
      productosSeleccionados.removeAt(index);
    });
  }

  List<DetallePedidoModel> convertirAPedidoDetalle(
      List<PedidoAAgregarModel> listaRecibida) {
    return listaRecibida.map((pedido) {
      return DetallePedidoModel(
        id: pedido.producto.idCategoria != 0 ? 0 : pedido.producto.id,
        cantidad: pedido.cantidad,
        idProducto: pedido.producto.id,
        idPedido: 0, // Inicialmente sin asignar
        subTotal: pedido.precioXCant,
        precioUnitario: pedido.precioUnitario,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Acceder al PedidoMesaProvider aquí sin modificar la función confirmarPedido

    final bool tienePedido = widget.pedidoMesa.idPedido != null;

    void confirmarPedido() {
      void nuevoPedidoEnTienda() async {
        final enviarEnTienda = EnTiendaRequestModel(
          idMesa: widget.pedidoMesa.idMesa,
          pedidoRequest: PedidoModel(
            idServicio: 1,
            detallePedidosRequest:
                convertirAPedidoDetalle(productosSeleccionados),
          ),
        );

        try {
          await _apiService.create(enviarEnTienda);
          websocketService.emit(
              "detalles-pedidos-enviado"); //HAY ERROR CON EL FORMATO JSON DE RESPONSE
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Pedido de la mesa: ${widget.pedidoMesa.idMesa} Enviado',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.green,
              behavior:
                  SnackBarBehavior.floating, // Lo hace flotar en la pantalla
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Bordes redondeados
              ),
              margin: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10), // Margen alrededor
              duration: const Duration(seconds: 2), // Duración más corta
            ),
          );
          pedidoProvider.pedidos.clear();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const EntryPoint(initialIndex: 1), // Ir a MesasScreen
            ),
            (route) => false,
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al crear el pedido: $e')),
          );
        }
      }

      void mandarMasPedidos(int idPedido) async {
        final enviarPedido = PedidoModel(
          id: idPedido,
          idServicio: 1,
          detallePedidosRequest:
              convertirAPedidoDetalle(productosSeleccionados),
        );

        try {
          await _apiService.update(enviarPedido);
          websocketService.emit(
              "detalles-pedidos-enviado"); //HAY ERROR CON EL FORMATO JSON DE RESPONSE

          setState(() {});

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Pedido de la mesa: ${widget.pedidoMesa.idMesa} Enviado',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),

              backgroundColor: successColor,
              behavior:
                  SnackBarBehavior.floating, // Lo hace flotar en la pantalla
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Bordes redondeados
              ),
              margin: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10), // Margen alrededor
              duration: const Duration(seconds: 2), // Duración más corta
            ),
          );

          pedidoProvider.pedidos.clear();

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const EntryPoint(initialIndex: 1), // Ir a MesasScreen
            ),
            (route) => false,
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al actualizar el pedido: $e')),
          );
        }
      }

      tienePedido
          ? mandarMasPedidos(widget.pedidoMesa.idPedido!)
          : nuevoPedidoEnTienda();
    }

    return Scaffold(
      bottomNavigationBar: pedidoProvider.pedidos.isEmpty
          ? null // Desactiva el botón si no hay productos
          : CartButton(
              price: pedidoProvider.totalPedidos,
              title: "Hacer Pedido",
              subTitle: "Total",
              press: () => confirmarPedido(),
            ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Text(
                "Mesa N° : ",
                style: TextStyle(
                  fontSize: 20, // Tamaño de fuente
                  fontWeight: FontWeight.bold, // Negrita
                  color: primaryColor, // Color del texto
                ),
              ),
              Container(
                width: defaultPadding * 2,
                height: defaultPadding * 2,
                decoration: const BoxDecoration(
                  color: secondaryColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${widget.pedidoMesa.idMesa}',
                  style: const TextStyle(
                    color: primaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: defaultPadding,
            ),
            Expanded(
              child: pedidoProvider.pedidos.isEmpty
                  ? const Center(
                      // Muestra mensaje si no hay productos
                      child: Text(
                        "No hay productos seleccionados",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.builder(
                      itemCount: pedidoProvider.pedidos.length,
                      itemBuilder: (context, index) {
                        final producto = pedidoProvider.pedidos[index];
                        return Padding(
                            padding: const EdgeInsets.all(defaultPadding / 2),
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(defaultBorderRadious),
                              ),
                              child: ListTile(
                                title: Text(
                                  producto.producto.nombre,
                                  style: TextStyle(fontSize: 20),
                                ),
                                subtitle: Text(
                                  'Cantidadx: ${producto.cantidad}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'S./ ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryLight,
                                                ),
                                          ),
                                          TextSpan(
                                            text: producto.precioXCant
                                                .toStringAsFixed(
                                                    2), // Valor por defecto
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: errorColor,
                                        size: 30,
                                      ),
                                      onPressed: () => eliminarProducto(index),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
