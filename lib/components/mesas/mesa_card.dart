import 'package:flutter/material.dart';
import 'package:riccos/route/screen_export.dart';
import 'package:riccos/services/websocket-service.dart';
import '../../constants.dart';
import '../../models/pedido_mesa_model.dart';
import 'package:riccos/route/route_constants.dart';
import 'package:riccos/services/api_service.dart';

class MesaCard extends StatelessWidget {
  const MesaCard({
    super.key,
    required this.pedidoMesa,
    this.onFinalizar,
  });

  final PedidoMesaModel pedidoMesa;
  final VoidCallback? onFinalizar;

  @override
  Widget build(BuildContext context) {
    final bool tienePedido = pedidoMesa.idPedido != null;
    final Color colorContenido = tienePedido ? tertiaryColor : tertiaryColorS;

    return ClipRRect(
      borderRadius:
          BorderRadius.circular(20), // Asegura que los bordes sean redondeados
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: primaryColor,
              child: Center(
                child: Text(
                  'Mesa ${pedidoMesa.nroMesa}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: colorContenido, // Fondo del contenedor
              padding: EdgeInsets.all(10), // Espaciado interno
              child: Column(
                mainAxisSize: MainAxisSize.min, // Ajusta el tamaño al contenido
                children: [
                  if (pedidoMesa.total != null) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*const Text(
                          'Total: ',
                          style: TextStyle(
                              color: tertiaryColorS,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        ),*/
                        Text(
                          'S./ ${pedidoMesa.total!.toStringAsFixed(2)}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ] else ...[
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Libre',
                          style: TextStyle(
                              color: tertiaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 5),
                  // Botón para agregar o iniciar pedido
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        menuPedidoooScreenRoute,
                        arguments: pedidoMesa,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor),
                    child: Text(
                      tienePedido ? 'Agregar Pedido' : 'Iniciar Pedido',
                    ),
                  ),
                  const SizedBox(height: 5), // Espaciado entre elementos

                  // Botón para finalizar pedido
                  ElevatedButton(
                    onPressed:
                        tienePedido ? () => _finalizarPedido(context) : null,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColorS),
                    child: const Text('Finalizar'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _finalizarPedido(BuildContext context) async {
    final apiService = ApiService();
    final websocketService = WebsocketService();

    if (pedidoMesa.idPedido != null) {
      try {
        // await apiService.finalizarPedido(pedidoMesa.idEnTienda!);

        // Emitir el evento al WebSocket
        websocketService.emit(
            "pedido-finalizado"); //HAY ERROR CON EL FORMATO JSON DE RESPONSE

        // Mostrar mensaje de éxito
        showDialog(
          context: context,
          barrierDismissible:
              false, // Evita que el usuario lo cierre antes de tiempo
          builder: (BuildContext context) {
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context)
                  .pop(); // Cierra automáticamente después de 2 segundos
            });

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Bordes redondeados
              ),
              title: const Text(
                "¡Pedido Finalizado!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle,
                      color: Colors.green, size: 50), // Ícono de éxito
                  SizedBox(height: 10),
                  Text(
                    "Pedido enviado con éxito",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        );

        onFinalizar?.call(); //  callback que recarga la lista.
      } catch (e) {
        // Mostrar error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al finalizar el pedido: $e')),
        );
      }
    }
  }
}
