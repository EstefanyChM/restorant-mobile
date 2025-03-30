import 'package:riccos/core/api_constants.dart';
import 'package:riccos/models/categoria_model.dart';
import 'package:dio/dio.dart';
import 'package:riccos/services/auth_service.dart';

class CategoriaService {
  final AuthService authService;
  final Dio _dio = Dio();
  List<CategoriaModel> _cachedList = [];

  CategoriaService(this.authService);

  Future<List<CategoriaModel>> getAllActive(
      {bool? activo, bool? disponible}) async {
    // Si ya tenemos datos cacheados, devolvemos los cacheados
    if (_cachedList.isNotEmpty) {
      return _cachedList;
    }

    final token = await authService.getToken();

    try {
      final response = await _dio.get(
        ApiConstants.categoria,
        queryParameters: {
          if (activo != null) 'activo': activo.toString(),
          if (disponible != null) 'disponible': disponible.toString(),
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        _cachedList = data
            .map((categoria) => CategoriaModel.fromJson(categoria))
            .toList();
        return _cachedList;
      } else {
        throw Exception(
            'Error al obtener categorías activas: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }
}
