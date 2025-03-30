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
        shadowColor: secondaryColor,
        elevation: 5,
        color: secondaryLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ajusta según contenido
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.network(
                producto.urlImagen,
                height: 90,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: secondaryColor, // Bordes redondeados
              ),
              child: Text(
                producto.nombre.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
            ),
            const SizedBox(
              height: defaultPadding / 2,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                decoration: BoxDecoration(
                  color: secondaryColor, // Color de fondo
                  borderRadius: BorderRadius.circular(
                      defaultBorderRadious * 2), // Bordes redondeados
                ),
                padding: const EdgeInsets.all(8),
                child: Text(
                  (producto.stock).toString(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: primaryColor, // Color de fondo
                  borderRadius: BorderRadius.circular(
                      defaultBorderRadious * 2), // Bordes redondeados
                ),
                padding: const EdgeInsets.all(8),
                child: Text(
                  's./ ${producto.precio.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: secondaryColor),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
