import 'dart:convert';

import 'package:riccos/core/api_constants.dart';
import 'package:riccos/models/promocion_model.dart';
import 'package:http/http.dart' as http;

class PromocionService {
  List<PromocionModel> _cachedListPromotion = [];

  Future<List<PromocionModel>> getAllPromotions(
      {bool? activo, bool? disponible, int? idCategoria}) async {
    // Si ya tenemos datos cacheados, devolvemos los cacheados
    if (_cachedListPromotion.isNotEmpty) {
      return _cachedListPromotion;
    }

    // Construir la URL con los parámetros opcionales
    Uri url = Uri.parse(ApiConstants.promocion);
    final queryParams = <String, String>{};

    if (activo != null) queryParams['activo'] = activo.toString();
    if (disponible != null) queryParams['disponible'] = disponible.toString();
    if (queryParams.isNotEmpty) {
      url = url.replace(queryParameters: queryParams);
    }

    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        final List<dynamic> data = jsonDecode(response.body);
        _cachedListPromotion = data
            .map((promocion) => PromocionModel.fromJson(promocion))
            .toList();
        return _cachedListPromotion;
      } catch (e) {
        throw Exception('Error al procesar la respuesta: $e');
      }
    } else {
      throw Exception(
          'Error al obtener los productos de la categoria: ${response.statusCode}');
    }
  }
}
