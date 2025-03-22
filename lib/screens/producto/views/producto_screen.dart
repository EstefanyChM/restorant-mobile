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
  final PedidoMesaModel pedidoMesa;

  const ProductoScreen(
      {super.key, required this.idCategoria, required this.pedidoMesa});

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
          disponibilidad:
              true, // Considera el valor apropiado para la disponibilidad
          estado: true, // Considera el valor apropiado para el estado
          precio: promocion
              .total, // Aquí puedes calcular el precio de alguna manera si es necesario
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccione un Producto'),
      ),
      body: FutureBuilder<List<ProductoModel>>(
        future: //obtenerproductosDeLaCategoria(),
            widget.idCategoria != 0
                ? obtenerproductosDeLaCategoria()
                : obtenerPromocionesConvertidosAProductos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay productos disponibles.'));
          } else {
            final productos = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: GridView.count(
                crossAxisCount: 2, // Número de columnas
                childAspectRatio: 0.85, // Relación de aspecto de las tarjetas
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
                              esPromocion:
                                  widget.idCategoria == 0 ? true : false),
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
    );
  }
}
