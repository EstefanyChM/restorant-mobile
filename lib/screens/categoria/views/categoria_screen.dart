import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riccos/components/categoria/categoria_card.dart';
import 'package:riccos/models/categoria_model.dart';
import 'package:riccos/models/pedido_mesa_model.dart';
import 'package:riccos/route/route_constants.dart';
import 'package:riccos/services/categoria_service.dart';

import '../../../constants.dart';

class CategoriaScreen extends StatefulWidget {
  final PedidoMesaModel pedidoMesa;

  const CategoriaScreen({
    Key? key,
    required this.pedidoMesa,
  }) : super(key: key);

  @override
  _CategoriaScreenState createState() => _CategoriaScreenState();
}

class _CategoriaScreenState extends State<CategoriaScreen> {
  late CategoriaService _apiService;
  List<CategoriaModel> categorias = [];

  @override
  void initState() {
    super.initState();
    _apiService = Provider.of<CategoriaService>(context, listen: false);
    //obtenerCategorias();
  }

  Future<List<CategoriaModel>> obtenerCategorias() async {
    try {
      // Llamada a la API para obtener categorías activas y disponibles
      return await _apiService.getAllActive(activo: true, disponible: true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener categorías: $e')),
      );
      return []; // Retorna una lista vacía en caso de error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CategoriaModel>>(
        future: obtenerCategorias(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay categorias disponibles.'));
          } else {
            final categorias = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.only(
                  top: 50,
                  left: defaultPadding,
                  right: defaultPadding,
                  bottom: defaultPadding),
              child: Column(
                children: [
                  /****************************** */
                  // ListView.builder para las categorías
                  Expanded(
                    child: ListView.builder(
                      itemCount: categorias.length +
                          1, // Se suma 1 para incluir el estático al final
                      itemBuilder: (context, index) {
                        if (index < categorias.length) {
                          // Renderiza las categorías dinámicas
                          final categoria = categorias[index];
                          return CategoriaCard(
                            categoria: categoria,
                            press: () {
                              Navigator.pushNamed(
                                context,
                                productoScreenRoute,
                                arguments: ProductoScreenArguments(
                                  pedidoMesa: widget.pedidoMesa,
                                  idCategoria: categoria.id,
                                ),
                              );
                            },
                          );
                        } else {
                          // Último elemento: categoría estática
                          return CategoriaCard(
                            categoria: CategoriaModel(
                              id: 0,
                              nombre: "Promociones",
                              cantidadDeProductos: 0,
                              precioMaximo: 0.0,
                              precioMinimo: 0.0,
                              descripcion: "",
                              disponibilidad: true,
                              disponibilidadDescripcion: "",
                              estado: true,
                              estadoDescripcion: "",
                              urlImagen:
                                  "https://img.freepik.com/premium-vector/percent-sign-percentage-discount-sale-promotion-concept-business-economy-symbol-vector-illustration-stock-image_213497-32.jpg",
                            ),
                            press: () {
                              Navigator.pushNamed(
                                context,
                                productoScreenRoute,
                                arguments: ProductoScreenArguments(
                                  pedidoMesa: widget.pedidoMesa,
                                  idCategoria: 0,
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),

                  /*const SizedBox(height: 20),
                  // Widget estático aquí, por ejemplo, un texto o una imagen
                  const Text(
                    'Categorías Disponibles',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),*/
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class ProductoScreenArguments {
  final PedidoMesaModel pedidoMesa;
  final int idCategoria;

  ProductoScreenArguments(
      {required this.pedidoMesa, required this.idCategoria});
}
