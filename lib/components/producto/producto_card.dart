import 'package:flutter/material.dart';
import 'package:riccos/constants.dart';
import 'package:riccos/models/producto_model.dart';

class ProductoCard extends StatelessWidget {
  const ProductoCard({
    super.key,
    required this.producto,
    required this.press,
  });
  final ProductoModel producto;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Card(
        color: primaryColor,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  producto.urlImagen,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                producto.nombre.toUpperCase(),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: tertiaryColor),
              ),
              const SizedBox(height: 5),
              Text(
                's./ ${producto.precio.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: secondaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
