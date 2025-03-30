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
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 8), // Espaciado interno
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: secondaryColor,
              blurRadius: 8,
              offset: Offset(2, 4),
            ),
          ],
          color: superColor,
          borderRadius: BorderRadius.circular(defaultBorderRadious * 2),
        ),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'S./ ',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: primaryLight,
                    ),
              ),
              TextSpan(
                text: price.toStringAsFixed(2), // Valor por defecto
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
              ),
            ],
          ),
        ));
  }
}
