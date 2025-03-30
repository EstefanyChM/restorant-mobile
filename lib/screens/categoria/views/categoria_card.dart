import 'package:flutter/material.dart';
import 'package:riccos/constants.dart';
import 'package:riccos/models/categoria_model.dart';

class CategoriaCard extends StatelessWidget {
  const CategoriaCard({
    super.key,
    required this.categoria,
    required this.press,
  });
  final CategoriaModel categoria;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),

        color: secondaryColor,
        shadowColor: tertiaryLight,
        elevation: 7, // Añadir sombra para resaltar la tarjeta
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(defaultPadding * 3), // Bordes redondeados
        ),
        // Márgenes
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 8), // Margen interno,
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround, // Alineación de los elementos
            children: [
              ClipOval(
                child: Image.network(
                  categoria.urlImagen,
                  height: 70,
                  width: 70, // Tamaño de la imagen
                  fit: BoxFit.cover, // Ajustar la imagen dentro de la caja
                ),
              ),
              Text(
                categoria.nombre.toUpperCase(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios, // Icono de flecha ">"
                size: 40,
                color: tertiaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
