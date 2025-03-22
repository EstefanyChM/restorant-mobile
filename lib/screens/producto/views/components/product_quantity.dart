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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Cantidad",
          style: TextStyle(
            color: tertiaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: OutlinedButton(
                onPressed: onDecrement, // Llamada a la función de decremento
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(defaultPadding / 2),
                    side: BorderSide.none,
                    backgroundColor: Colors.red[300]),
                child: const Icon(
                  Icons.remove,
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
              height: 40,
              width: 40,
              child: OutlinedButton(
                onPressed: onIncrement, // Llamada a la función de incremento
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(defaultPadding / 2),
                    side: BorderSide.none,
                    backgroundColor: Colors.green[300]),

                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
