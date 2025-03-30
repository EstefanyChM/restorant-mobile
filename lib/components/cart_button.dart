import 'package:flutter/material.dart';

import '../constants.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    super.key,
    required this.price,
    this.title = "Buy Now",
    this.subTitle = "Unit price",
    required this.press,
  });

  final double price;
  final String title, subTitle;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultBorderRadious / 2),
        child: SizedBox(
          height: 100,
          child: Material(
            color: secondaryLight,
            clipBehavior: Clip.hardEdge,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(defaultBorderRadious * 5),
              ),
            ),
            child: InkWell(
              onTap: press,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'S./ ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: primaryLight,
                                      ),
                                ),
                                TextSpan(
                                  text: price
                                      .toStringAsFixed(2), // Valor por defecto
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            subTitle,
                            style: const TextStyle(
                                color: primaryColor, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      color: secondaryColor,
                      child: Row(
                        mainAxisSize:
                            MainAxisSize.min, // Ajusta el tamaño al contenido
                        children: [
                          const Icon(
                            Icons.add_shopping_cart,
                            color: primaryColor,
                            size: 50,
                          ),
                          const SizedBox(
                              width: 8), // Espaciado entre el icono y el texto
                          Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
