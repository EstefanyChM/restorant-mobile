import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riccos/models/en_tienda_request_model.dart';
import 'package:riccos/models/en_tienda_response_model.dart';
import 'package:riccos/models/pedido_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:riccos/core/api_constants.dart';

class ApiService {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwtToken');
  }

  Future<int?> getIdUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    var a = prefs.getInt('idUsuario');
    return a;
  }

  // Método para enviar el objeto EnTiendaModel al servidor
  Future<EnTiendaResponseModel> create(EnTiendaRequestModel request) async {
    final idUser = await getIdUsuario(); // Obtiene el ID del usuario
    final url = Uri.parse(
        "${ApiConstants.enTienda}?idUser=$idUser"); // Agrega el ID a la URL
    final token = await getToken();

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(
            request.toJson()), // Convertir EnTiendaRequestModel a JSON
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return EnTiendaResponseModel.fromJson(data);
      } else {
        throw Exception('Error al crear el pedido: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }

  Future<PedidoModel> update(PedidoModel request) async {
    final idUser = await getIdUsuario(); // Obtiene el ID del usuario
    final url = Uri.parse("${ApiConstants.pedido}?idUser=$idUser");
    final token = await getToken();
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(request.toJson()),
      );

      // Manejar la respuesta
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return PedidoModel.fromJson(
            data); // Convertir la respuesta en PedidoModel
      } else {
        throw Exception(
            'Error al actualizar el pedido: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al realizar la solicitud: $e');
    }
  }

/*********************** */
}
