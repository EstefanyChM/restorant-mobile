import 'package:flutter/material.dart';
import 'package:riccos/constants.dart';
import 'package:riccos/route/route_constants.dart';

class AgregarDetallePedidoMessageScreen extends StatelessWidget {
  const AgregarDetallePedidoMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, categoriaScreenRoute);
                },
                child: const Text(
                  "Agregar más productos",
                ),
              ),
              const SizedBox(height: defaultPadding),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Mandar Pedido",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
