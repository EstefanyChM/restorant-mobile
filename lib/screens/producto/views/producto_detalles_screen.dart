import 'package:flutter/material.dart';
import 'package:riccos/components/cart_button.dart';
import 'package:riccos/menu_pedidooo.dart';
import 'package:riccos/models/pedido_a_agregar_model.dart';
import 'package:riccos/models/pedido_mesa_model.dart';
import 'package:riccos/models/producto_model.dart';
import 'package:riccos/providers/pedido_provider.dart';
import '../../../constants.dart';
import 'components/product_quantity.dart';
import 'components/unit_price.dart';

class ProductoDetallesScreen extends StatefulWidget {
  const ProductoDetallesScreen(
      {super.key,
      required this.producto,
      required this.pedidoMesa,
      required this.esPromocion});

  final ProductoModel producto;
  final PedidoMesaModel pedidoMesa;
  final bool esPromocion;

  @override
  _ProductoDetallesScreenState createState() => _ProductoDetallesScreenState();
}

class _ProductoDetallesScreenState extends State<ProductoDetallesScreen> {
  int numOfItems = 1; // Almacenamos la cantidad seleccionada
  List<PedidoAAgregarModel> pedidos = []; // Lista para almacenar los pedidos

  // Función que actualiza la cantidad
  void updateQuantity(int newQuantity) {
    setState(() {
      numOfItems = newQuantity;
    });
  }

  void addToCart() {
    PedidoAAgregarModel nuevoPedido = PedidoAAgregarModel(
      producto: widget.producto,
      cantidad: numOfItems,
      precioXCant: widget.producto.precio * numOfItems,
      precioUnitario: widget.producto.precio,
    );

    setState(() {
      pedidoProvider.pedidos
          .add(nuevoPedido); // Agrega el pedido a la lista global
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${widget.producto.nombre} agregado al carrito',
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[300],
        behavior: SnackBarBehavior.floating, // Lo hace flotar en la pantalla
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Bordes redondeados
        ),
        margin: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 10), // Margen alrededor
        duration: const Duration(seconds: 2), // Duración más corta
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice =
        widget.producto.precio * numOfItems; // Cálculo del precio total

    return Scaffold(
      bottomNavigationBar: CartButton(
        price: totalPrice,
        title: "Agregar",
        subTitle: "Subtotal",
        press: () {
          addToCart();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MenuPedidooo(pedidoMesa: widget.pedidoMesa)),
          );
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(
                  color: tertiaryColor,
                  style: ButtonStyle(
                    iconSize: MaterialStateProperty.all(
                        50), // Cambiar el tamaño del icono
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ), // Espaciado interno
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    widget.producto.nombre,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    // Imagen del producto con tamaño ajustado
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.producto.urlImagen,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Fila con precio y cantidad
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: UnitPrice(
                            price: widget.producto.precio,
                          ),
                        ),
                        ProductQuantity(
                          stock: widget.producto.stock,
                          onQuantityChanged:
                              updateQuantity, // Pasamos la función
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
