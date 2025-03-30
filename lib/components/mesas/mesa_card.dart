import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riccos/entry_point.dart';
import 'package:riccos/route/screen_export.dart';
import 'package:riccos/services/en_tienda_service.dart';
import 'package:riccos/services/websocket-service.dart';
import '../../constants.dart';
import '../../models/pedido_mesa_model.dart';
import 'package:riccos/route/route_constants.dart';

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
    final Color colorContenido = tienePedido ? secondaryColor : secondaryLight;

    return ClipRRect(
      borderRadius: BorderRadius.circular(defaultBorderRadious),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: Container(
                color: primaryColor,
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: defaultPadding * 2,
                      height: defaultPadding * 2,
                      decoration: const BoxDecoration(
                        color: secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${pedidoMesa.nroMesa}',
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: defaultPadding * 3,
                    ),
                    if (pedidoMesa.total != null) ...[
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'S./ ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: secondaryColor,
                                  ),
                            ),
                            TextSpan(
                              text: (pedidoMesa.total ?? 0.00)
                                  .toStringAsFixed(2), // Valor por defecto
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: superColor,
                                  ),
                            ),
                          ],
                        ),
                      )
                    ] else ...[
                      const Text(
                        'Libre',
                        style: TextStyle(
                            color: successColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ],
                  ],
                )),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: colorContenido,
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: defaultPadding / 4),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        menuPedidoooScreenRoute,
                        arguments: pedidoMesa,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(
                          vertical: defaultPadding / 1.5,
                        ),
                        backgroundColor: successColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                defaultBorderRadious * 4))),
                    child: Text(
                      tienePedido ? 'Agregar Pedido' : 'Iniciar Pedido',
                      textAlign: TextAlign.center,
                      softWrap: true,
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: superColor),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  ElevatedButton(
                      onPressed:
                          tienePedido ? () => _finalizarPedido(context) : null,
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding / 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  defaultBorderRadious * 3.5)),
                          backgroundColor: errorColor),
                      child: Text(
                        'Finalizar',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: superColor),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _finalizarPedido(BuildContext context) async {
    final enTiendaService =
        Provider.of<EnTiendaService>(context, listen: false);
    final websocketService =
        Provider.of<WebsocketService>(context, listen: false);

    if (pedidoMesa.idPedido != null) {
      try {
        await enTiendaService.finalizarPedido(pedidoMesa.idEnTienda!);
        websocketService.emit("pedido-finalizado");

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context).pop();
            });

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: const Text(
                "¡Pedido Finalizado!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 50),
                  SizedBox(height: 10),
                  Text("Pedido enviado con éxito", textAlign: TextAlign.center),
                ],
              ),
            );
          },
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const EntryPoint(initialIndex: 1), // Ir a MesasScreen
          ),
          (route) => false,
        );

        onFinalizar?.call();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al finalizar el pedido: $e')),
        );
      }
    }
  }
}
