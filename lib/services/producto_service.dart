import 'dart:convert';

import 'package:riccos/core/api_constants.dart';
import 'package:riccos/models/generic_filter_model.dart';
import 'package:riccos/models/producto_model.dart';
import 'package:http/http.dart' as http;

class ProductoService {
  List<ProductoModel> _cachedListProduct = [];

  Future<List<ProductoModel>> getAll({idCategoria}) async {
    /* 
    TODO: la lista cambia dependiendo del la categoría 
     */
    //if (_cachedListProduct.isNotEmpty) {
    //  return _cachedListProduct;
    //}

    // Construir la URL con los parámetros opcionales
    final url = Uri.parse(ApiConstants.producto).replace(
      queryParameters: {
        'activo': 'true',
        'disponible': 'true',
        'idCategoria': idCategoria.toString(),
      },
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        final List<dynamic> data = jsonDecode(response.body);
        _cachedListProduct =
            data.map((producto) => ProductoModel.fromJson(producto)).toList();
        return _cachedListProduct;
      } catch (e) {
        throw Exception('Error al procesar la respuesta: $e');
      }
    } else {
      throw Exception(
          'Error al obtener los productos de la categoria: ${response.statusCode}');
    }
  }

  Future<GenericFilterResponse<ProductoModel>> genericFilter(
      GenericFilterRequest request) async {
    final url = Uri.parse(
        '${ApiConstants.producto}filter'); // Construcción de la URL con la ruta 'filter'

    // Realizamos la solicitud HTTP POST
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()), // Convertimos la solicitud a JSON
    );

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Deserializamos la respuesta usando GenericFilterResponse
        return GenericFilterResponse<ProductoModel>.fromJson(
          data,
          (json) => ProductoModel.fromJson(
              json), // Función para convertir cada item a ProductoModel
        );
      } catch (e) {
        throw Exception('Error al procesar la respuesta: $e');
      }
    } else {
      throw Exception(
          'Error al realizar la solicitud de filtro: ${response.statusCode}');
    }
  }
}
