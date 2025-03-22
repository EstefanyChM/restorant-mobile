import 'package:flutter/material.dart';
import 'package:riccos/route/screen_export.dart';

import '../../../../constants.dart';

class ExpansionCategory extends StatelessWidget {
  const ExpansionCategory({
    super.key,
    required this.title,
    required this.subCategory,
    this.icon, // Cambiado para aceptar un ícono de Material
  });

  final String title;
  final List subCategory;
  final IconData? icon; // Nuevo campo para íconos de Material

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: Theme.of(context).textTheme.bodyLarge!.color,
      collapsedIconColor: Theme.of(context).textTheme.bodyMedium!.color,
      leading: icon != null
          ? Icon(
              icon,
              size: 24,
              color: Theme.of(context).iconTheme.color,
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(fontSize: 14),
      ),
      textColor: Theme.of(context).textTheme.bodyLarge!.color,
      childrenPadding: const EdgeInsets.only(left: defaultPadding * 3.5),
      children: List.generate(
        subCategory.length,
        (index) => Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, pedidosDelPersonalScreenRoute);
              },
              title: Text(
                subCategory[index].title,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            if (index < subCategory.length - 1) const Divider(height: 1),
          ],
        ),
      ),
    );
  }
}
