import 'dart:convert';

import 'package:riccos/core/api_constants.dart';
import 'package:riccos/models/categoria_model.dart';
import 'package:http/http.dart' as http;
import 'package:riccos/services/auth_service.dart';

class CategoriaService {
  final AuthService authService;

  CategoriaService(this.authService);

  List<CategoriaModel> _cachedList = [];

  Future<List<CategoriaModel>> getAllActive(
      {bool? activo, bool? disponible}) async {
    // Si ya tenemos datos cacheados, devolvemos los cacheados
    if (_cachedList.isNotEmpty) {
      return _cachedList;
    }

    // Construir la URL con los parámetros opcionales
    final url = Uri.parse(ApiConstants.categoria);
    final queryParams = <String, String>{};

    if (activo != null) queryParams['activo'] = activo.toString();
    if (disponible != null) queryParams['disponible'] = disponible.toString();

    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        final List<dynamic> data = jsonDecode(response.body);
        _cachedList = data
            .map((categoria) => CategoriaModel.fromJson(categoria))
            .toList();
        return _cachedList;
      } catch (e) {
        throw Exception('Error al procesar la respuesta: $e');
      }
    } else {
      throw Exception(
          'Error al obtener categorías activas: ${response.statusCode}');
    }
  }
}
