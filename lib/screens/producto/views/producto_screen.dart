import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riccos/components/custom_modal_bottom_sheet.dart';
import 'package:riccos/components/producto/producto_card.dart';
import 'package:riccos/models/pedido_mesa_model.dart';
import 'package:riccos/models/producto_model.dart';
import 'package:riccos/models/promocion_model.dart';
import 'package:riccos/screens/producto/views/producto_detalles_screen.dart';
import 'package:riccos/services/producto_service.dart';
import 'package:riccos/services/promocion_service.dart';

import '../../../constants.dart';

class ProductoScreen extends StatefulWidget {
  final int idCategoria;
  final String nombreCategoria;
  final PedidoMesaModel pedidoMesa;

  const ProductoScreen(
      {super.key,
      required this.idCategoria,
      required this.nombreCategoria,
      required this.pedidoMesa});

  @override
  ProductoScreenState createState() => ProductoScreenState();
}

class ProductoScreenState extends State<ProductoScreen> {
  late ProductoService _productoService;
  late PromocionService _promocionService;
  List<ProductoModel> productos = [];

  @override
  void initState() {
    super.initState();
    _productoService = Provider.of<ProductoService>(context, listen: false);
    _promocionService = Provider.of<PromocionService>(context, listen: false);
  }

  Future<List<ProductoModel>> obtenerproductosDeLaCategoria() async {
    try {
      return await _productoService.getAll(idCategoria: widget.idCategoria);
    } catch (e) {
      // Manejo de errores en caso de que algo falle
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener los productos: $e')),
      );
      return []; // Retorna una lista vacía en caso de error
    }
  }

  Future<List<ProductoModel>> obtenerPromocionesConvertidosAProductos() async {
    try {
      // Obtener las promociones
      List<PromocionModel> promociones =
          await _promocionService.getAllPromotions(
              activo: true, disponible: true, idCategoria: widget.idCategoria);

      // Convertir las promociones en productos
      List<ProductoModel> productos = promociones.map((promocion) {
        return ProductoModel(
          id: promocion.id,
          stock: promocion.stock,
          nombre: promocion.nombre,
          descripcion: promocion.descripcion,
          disponibilidad: true,
          estado: true,
          precio: promocion
              .total, // calcular el precio de alguna manera si es necesario
          idCategoria: widget
              .idCategoria, // Puede ser el mismo que el de la categoría de la promoción
          categoriaNombre:
              '', // Aquí puedes asignar el nombre de la categoría si lo tienes
          urlImagen: promocion.urlImagen,
          disponibilidadDescripcion:
              'Disponible', // Ajusta según lo que consideres
          stockAuxiliar: promocion
              .stock, // Si necesitas el stock auxiliar también puedes mapearlo
        );
      }).toList();

      return productos;
    } catch (e) {
      // Manejo de errores en caso de que algo falle
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener los productos: $e')),
      );
      return []; // Retorna una lista vacía en caso de error
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: tertiaryLight,
          title: const Text(
            'Volver a mesas',
            style: TextStyle(color: primaryColor, fontSize: 30),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(defaultPadding / 2),
              child: Center(
                child: Text(
                  widget.nombreCategoria,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<ProductoModel>>(
                future: widget.idCategoria != 0
                    ? obtenerproductosDeLaCategoria()
                    : obtenerPromocionesConvertidosAProductos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No hay productos disponibles.'));
                  } else {
                    final productos = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        children: List.generate(
                          productos.length,
                          (index) {
                            final producto = productos[index];
                            return ProductoCard(
                              producto: producto,
                              press: () {
                                customModalBottomSheet(
                                  context,
                                  child: ProductoDetallesScreen(
                                    producto: producto,
                                    pedidoMesa: widget.pedidoMesa,
                                    esPromocion: widget.idCategoria == 0,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
