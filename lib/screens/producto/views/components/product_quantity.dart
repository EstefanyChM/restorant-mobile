import 'package:flutter/material.dart';
import '../../../../constants.dart';

class ProductQuantity extends StatefulWidget {
  const ProductQuantity({
    super.key,
    required this.stock,
    required this.onQuantityChanged, // Función que se llamará cuando cambie la cantidad
  });

  final int stock;
  final ValueChanged<int>
      onQuantityChanged; // Callback para la cantidad seleccionada

  @override
  _ProductQuantityState createState() => _ProductQuantityState();
}

class _ProductQuantityState extends State<ProductQuantity> {
  int numOfItem = 1; // Estado que guarda la cantidad de artículos

  // Función para incrementar el número de artículos
  void onIncrement() {
    setState(() {
      if (numOfItem < widget.stock) {
        numOfItem++;
        widget.onQuantityChanged(numOfItem); // Llamamos al callback
      }
    });
  }

  // Función para decrementar el número de artículos
  void onDecrement() {
    setState(() {
      if (numOfItem > 1) {
        numOfItem--;
        widget.onQuantityChanged(numOfItem); // Llamamos al callback
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Cantidad",
          style: TextStyle(
            color: tertiaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: defaultPadding,
        ),
        Row(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: OutlinedButton(
                onPressed: onDecrement, // Llamada a la función de decremento
                style: OutlinedButton.styleFrom(
                    shape: const OvalBorder(),
                    padding: const EdgeInsets.all(defaultPadding / 2),
                    side: BorderSide.none,
                    backgroundColor: errorColor),
                child: const Icon(
                  Icons.remove,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text(
                  numOfItem.toString(),
                  style: const TextStyle(
                    fontSize: 40,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: 60,
              child: OutlinedButton(
                onPressed: onIncrement, // Llamada a la función de incremento
                style: OutlinedButton.styleFrom(
                    shape: const OvalBorder(),
                    padding: const EdgeInsets.all(defaultPadding / 2),
                    side: BorderSide.none,
                    backgroundColor: successColor),

                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
