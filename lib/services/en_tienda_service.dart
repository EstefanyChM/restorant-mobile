import 'dart:convert';

import 'package:riccos/core/api_constants.dart';
import 'package:riccos/models/en_tienda_request_model.dart';
import 'package:riccos/models/en_tienda_response_model.dart';
import 'package:riccos/models/pedido_mesa_model.dart';
import 'package:http/http.dart' as http;
import 'package:riccos/services/auth_service.dart';

class EnTiendaService {
  final AuthService authService;

  EnTiendaService(this.authService);

  Future<List<PedidoMesaModel>> getPedidoMesa() async {
    final url = Uri.parse('${ApiConstants.enTienda}pedido-mesa');
    final token = await authService.getToken();

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      try {
        final List data = jsonDecode(response.body);
        return data
            .map((pedidoMesa) => PedidoMesaModel.fromJson(pedidoMesa))
            .toList();
      } catch (e) {
        throw Exception('Error al procesar la respuesta: $e');
      }
    } else {
      throw Exception(
          'Error al obtener el pedido mesa: ${response.statusCode}');
    }
  }

  Future<EnTiendaResponseModel> finalizarPedido(int id) async {
    final url = Uri.parse('${ApiConstants.enTienda}finalizar/$id');
    final token = await authService.getToken();

    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode({}), // Aquí puedes pasar cualquier dato si es necesario
    );

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> data = jsonDecode(response.body);

        return EnTiendaResponseModel.fromJson(data);
      } catch (e) {
        throw Exception('Error al procesar la respuesta: $e');
      }
    } else {
      throw Exception('Error al finalizar el pedido: ${response.statusCode}');
    }
  }

  Future<EnTiendaResponseModel> create(EnTiendaRequestModel request) async {
    final idUser = await authService.getIdUsuario();
    final url = Uri.parse(
        "${ApiConstants.enTienda}?idUser=$idUser"); // Agrega el ID a la URL
    final token = await authService.getToken();

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
}
