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
                SizedBox(height: 70),
                // Mostrar la lista de productos
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => tertiaryColor), // Color de encabezado
                      dataRowColor: MaterialStateColor.resolveWith(
                          (states) => secondaryColorS), // Color de filas
                      columnSpacing: 20, // Espaciado entre columnas
                      border: TableBorder.all(
                        color: Colors.white, // Color del borde
                        width: 1.5, // Grosor del borde
                        borderRadius:
                            BorderRadius.circular(20), // Bordes redondeados
                      ),
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Producto',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Cantidad',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Subtotal',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
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
                ),

                // Mostrar el total
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Total a Pagar: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
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
