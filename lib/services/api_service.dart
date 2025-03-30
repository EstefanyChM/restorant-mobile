import 'dart:convert';
import 'package:riccos/models/en_tienda_request_model.dart';
import 'package:riccos/models/en_tienda_response_model.dart';
import 'package:riccos/models/pedido_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riccos/core/api_constants.dart';

import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwtToken');
  }

  Future<int?> getIdUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('idUsuario');
  }

  // Método para enviar el objeto EnTiendaModel al servidor
  Future<EnTiendaResponseModel> create(EnTiendaRequestModel request) async {
    final idUser = await getIdUsuario();
    final url = "${ApiConstants.enTienda}?idUser=$idUser";
    final token = await getToken();

    try {
      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
        data: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return EnTiendaResponseModel.fromJson(response.data);
      } else {
        throw Exception('Error al crear el pedido: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }

  Future<PedidoModel> update(PedidoModel request) async {
    final idUser = await getIdUsuario();
    final url = "${ApiConstants.pedido}?idUser=$idUser";
    final token = await getToken();

    try {
      final response = await _dio.put(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
        data: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return PedidoModel.fromJson(response.data);
      } else {
        throw Exception(
            'Error al actualizar el pedido: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al realizar la solicitud: $e');
    }
  }
}
