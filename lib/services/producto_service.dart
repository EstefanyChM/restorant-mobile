import 'package:riccos/core/api_constants.dart';
import 'package:riccos/models/generic_filter_model.dart';
import 'package:riccos/models/producto_model.dart';
import 'package:dio/dio.dart';

class ProductoService {
  final Dio _dio = Dio();
  List<ProductoModel> _cachedListProduct = [];

  Future<List<ProductoModel>> getAll({int? idCategoria}) async {
    try {
      final response = await _dio.get(
        ApiConstants.producto,
        queryParameters: {
          'activo': 'true',
          'disponible': 'true',
          if (idCategoria != null) 'idCategoria': idCategoria.toString(),
        },
      );

      if (response.statusCode == 200) {
        final List data = response.data;
        _cachedListProduct =
            data.map((producto) => ProductoModel.fromJson(producto)).toList();
        return _cachedListProduct;
      } else {
        throw Exception(
            'Error al obtener los productos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }

  Future<GenericFilterResponse<ProductoModel>> genericFilter(
      GenericFilterRequest request) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.producto}filter',
        data: request.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return GenericFilterResponse<ProductoModel>.fromJson(
          data,
          (json) => ProductoModel.fromJson(json),
        );
      } else {
        throw Exception('Error al filtrar productos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }
}
