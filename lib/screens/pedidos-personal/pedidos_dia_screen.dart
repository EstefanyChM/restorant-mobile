import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as http;
import 'package:provider/provider.dart';
import 'package:riccos/models/pedido_del_usuario_response.dart';
import 'package:riccos/services/api_service.dart';
import 'package:riccos/services/auth_service.dart';
import 'package:riccos/services/pedido_service.dart';
import '../../../constants.dart';

class PedidosDiaScreen extends StatefulWidget {
  const PedidosDiaScreen({super.key});

  @override
  PedidosDiaScreenState createState() => PedidosDiaScreenState();
}

class PedidosDiaScreenState extends State<PedidosDiaScreen> {
  Future<List<PedidoDelUsuarioResponse>> traerPedidosMozoFiltrado() async {
    try {
      final pedidoService = Provider.of<PedidoService>(context, listen: false);
      return await pedidoService.getPedidosMozoFiltrado();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener pedidos: $e')),
      );
      return Future.value([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis pedidos del día'),
        backgroundColor: tertiaryColor,
      ),
      body: FutureBuilder<List<PedidoDelUsuarioResponse>>(
        future: traerPedidosMozoFiltrado(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: \${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay pedidos disponibles.'));
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Agrega margen alrededor
              child: SingleChildScrollView(
                scrollDirection: Axis
                    .horizontal, // Permite desplazamiento horizontal si es necesario
                child: DataTable(
                  columnSpacing: 30.0,
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Colors.grey[300]!),
                  columns: const [
                    DataColumn(
                        label: Center(
                            child: Text('Producto',
                                style:
                                    TextStyle(fontWeight: FontWeight.bold)))),
                    DataColumn(
                        label: Center(
                            child: Text('Cantidad',
                                style:
                                    TextStyle(fontWeight: FontWeight.bold)))),
                    DataColumn(
                        label: Center(
                            child: Text('Fecha',
                                style:
                                    TextStyle(fontWeight: FontWeight.bold)))),
                  ],
                  rows: snapshot.data!.map<DataRow>((pedido) {
                    return DataRow(cells: [
                      DataCell(Center(child: Text(pedido.nombreProducto))),
                      DataCell(Center(child: Text(pedido.cantidad.toString()))),
                      DataCell(Center(
                          child: Text(pedido.fecha
                              .toLocal()
                              .toString()
                              .split(' ')[0]))),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
