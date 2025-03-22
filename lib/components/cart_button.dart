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
          height: 64,
          child: Material(
            color: tertiaryColorS,
            clipBehavior: Clip.hardEdge,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(defaultBorderRadious),
              ),
            ),
            child: InkWell(
              onTap: press,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "S/. ${price.toStringAsFixed(2)}",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontSize: 28,
                                    fontWeight:
                                        FontWeight.bold, // Hacerlo más grueso
                                    color: tertiaryColor),
                          ),
                          Text(
                            subTitle,
                            style: const TextStyle(
                              color: primaryColor,
                            ),
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
                      color: tertiaryColor,
                      child: Row(
                        mainAxisSize:
                            MainAxisSize.min, // Ajusta el tamaño al contenido
                        children: [
                          const Icon(
                            Icons.add_shopping_cart,
                            color: secondaryColorS,
                            size: 40,
                          ),
                          const SizedBox(
                              width: 8), // Espaciado entre el icono y el texto
                          Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: secondaryColorS),
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
