import 'package:flutter/material.dart';
import 'package:riccos/constants.dart';
import 'package:riccos/models/category_model.dart';
import 'components/expansion_category.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
                vertical: defaultPadding / 2,
              ),
              child: Text(
                "Mis Pedidos",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            // Mientras se carga, usa un esqueleto o placeholder
            // const Expanded(
            //   child: DiscoverCategoriesSkelton(),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: demoCategories.length,
                itemBuilder: (context, index) {
                  final category = demoCategories[index];
                  return ExpansionCategory(
                    title: 'Los Pedidos Que Realicé',
                    icon: category.icon,
                    subCategory: category.subCategories ?? [],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
