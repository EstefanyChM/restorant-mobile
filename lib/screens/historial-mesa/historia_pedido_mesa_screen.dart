import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riccos/constants.dart';
import 'package:riccos/models/pedido_mesa_model.dart';
import 'package:riccos/models/pedido_model.dart';
import 'package:riccos/services/pedido_service.dart';

class HistorialPedidoMesaScreen extends StatefulWidget {
  final PedidoMesaModel pedidoMesa;
  const HistorialPedidoMesaScreen({super.key, required this.pedidoMesa});
  @override
  _HistorialPedidoMesaScreenState createState() =>
      _HistorialPedidoMesaScreenState();
}

class _HistorialPedidoMesaScreenState extends State<HistorialPedidoMesaScreen> {
  late Future<PedidoModel> _pedidoFuture;
  late PedidoService _pedidoService;

  @override
  Widget build(BuildContext context) {
    _pedidoService = Provider.of<PedidoService>(context, listen: false);

    _pedidoFuture = _pedidoService.getPedidoById(widget.pedidoMesa.idPedido!);

    return Scaffold(
      body: FutureBuilder<PedidoModel>(
        future: _pedidoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final pedido = snapshot.data!;
            return Column(
              children: [
                const SizedBox(height: defaultPadding),
                Expanded(
                  child: DataTable(
                    headingRowColor: WidgetStateColor.resolveWith(
                      (states) => primaryColor,
                    ),
                    dataRowColor: WidgetStateColor.resolveWith(
                        (states) => whiteColor), // Color de filas
                    columnSpacing: 20, // Espaciado entre columnas
                    border: TableBorder.all(
                      color: secondaryLight, // Color del borde
                      width: 1.5, // Grosor del borde
                      borderRadius: BorderRadius.circular(
                          defaultPadding / 1.5), // Bordes redondeados
                    ),
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Producto',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: secondaryColor),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Cant.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: secondaryColor),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Subtotal',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: secondaryColor),
                        ),
                      ),
                    ],
                    rows: pedido.detallePedidoResp.map((detalle) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              detalle.nombreProducto,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor),
                            ),
                          ),
                          DataCell(
                            Text(
                              detalle.cantidad.toString(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                          ),
                          DataCell(
                            Text(
                              'S./ ${detalle.subTotal.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: tertiaryColor),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),

                // Mostrar el total
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        color: tertiaryColor,
                        child: const Text(
                          'Total a Pagar: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text('S./ ${pedido.total}'),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No hay datos disponibles'));
          }
        },
      ),
    );
  }
}
