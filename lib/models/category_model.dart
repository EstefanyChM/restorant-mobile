import 'package:flutter/material.dart';

class CategoryModel {
  final String title;
  final String? image;
  final IconData? icon;
  final List<CategoryModel>? subCategories;

  CategoryModel({
    required this.title,
    this.image,
    this.icon,
    this.subCategories,
  });
}

// Ejemplo de categorías con íconos de Material
final List<CategoryModel> demoCategories = [
  CategoryModel(
    title: "Promociones",
    //icon: Icons.local_offer, // Usa un icono de Material en lugar de un SVG
    icon: Icons.receipt_long,
    subCategories: [
      CategoryModel(title: "Ver Todos mis Pedidos", icon: Icons.star),
    ],
  ),
];
