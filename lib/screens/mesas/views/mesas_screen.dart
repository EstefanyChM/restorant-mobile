import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riccos/components/mesas/mesa_card.dart';
import 'package:riccos/models/pedido_mesa_model.dart';
import 'package:riccos/services/en_tienda_service.dart';

class MesasScreen extends StatefulWidget {
  const MesasScreen({super.key});

  @override
  _MesasScreenState createState() => _MesasScreenState();
}

class _MesasScreenState extends State<MesasScreen> {
  late Future<List<PedidoMesaModel>> _pedidoMesasFuture;

  @override
  void initState() {
    super.initState();
    final enTiendaService = context.read<EnTiendaService>();
    _pedidoMesasFuture = enTiendaService.getPedidoMesa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30.0, // Reduce la altura del AppBar
        title: const Center(
          child: Text(
            'Pedidos por Mesa',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<PedidoMesaModel>>(
        future: _pedidoMesasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay mesas disponibles.'));
          } else {
            final pedidoMesas = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  childAspectRatio: 0.75,
                  mainAxisSpacing: 20.0, // Espaciado vertical entre tarjetas
                  crossAxisSpacing: 20.0, // Espaciado horizontal entre tarjetas
                ),
                itemCount: pedidoMesas.length,
                itemBuilder: (BuildContext context, int index) {
                  final pedidoMesa = pedidoMesas[index];
                  return MesaCard(
                    pedidoMesa: pedidoMesa,
                    //onFinalizar: _refreshPedidoMesaList,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
