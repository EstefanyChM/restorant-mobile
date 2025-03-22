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
        elevation: 5, // Añadir sombra para resaltar la tarjeta
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Bordes redondeados
        ),
        margin:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 12), // Márgenes
        child: Container(
          padding: const EdgeInsets.all(5), // Espaciado interno
          decoration: BoxDecoration(
            color: secondaryColorS,
            borderRadius:
                BorderRadius.circular(12), // Bordes redondeados para el fondo
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Alineación de los elementos
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                    30), // Bordes redondeados para la imagen
                child: Image.network(
                  categoria.urlImagen,
                  height: 50,
                  width: 50, // Tamaño de la imagen
                  fit: BoxFit.cover, // Ajustar la imagen dentro de la caja
                ),
              ),
              const SizedBox(width: 12), // Espacio entre imagen y texto
              Expanded(
                child: Text(
                  categoria.nombre.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios, // Icono de flecha ">"
                size: 30,
                color: tertiaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
