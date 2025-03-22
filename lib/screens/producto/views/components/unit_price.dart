import 'package:flutter/material.dart';

import '../../../../constants.dart';

class UnitPrice extends StatelessWidget {
  const UnitPrice({
    super.key,
    required this.price,
  });

  final double price;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Precio Unitario",
          style: TextStyle(
            color: tertiaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 8), // Espaciado interno
          decoration: BoxDecoration(
            color: secondaryColorS,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            "S./ $price",
            style: const TextStyle(
              fontSize: 30,
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
