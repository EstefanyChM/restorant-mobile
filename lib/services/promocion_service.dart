import 'dart:convert';

import 'package:riccos/core/api_constants.dart';
import 'package:riccos/models/promocion_model.dart';
import 'package:http/http.dart' as http;

class PromocionService {
  List<PromocionModel> _cachedListPromotion = [];

  Future<List<PromocionModel>> getAllPromotions({
    bool? activo,
    bool? disponible,
    int? idCategoria,
  }) async {
    if (_cachedListPromotion.isNotEmpty) return _cachedListPromotion;

    final uri = Uri.parse(ApiConstants.promocion).replace(
      queryParameters: {
        if (activo != null) 'activo': activo.toString(),
        if (disponible != null) 'disponible': disponible.toString(),
        if (idCategoria != null) 'idCategoria': idCategoria.toString(),
      },
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return _cachedListPromotion =
            data.map((json) => PromocionModel.fromJson(json)).toList();
      } else {
        throw Exception('Error al obtener promociones: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }
}
