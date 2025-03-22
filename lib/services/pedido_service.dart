import 'dart:convert';

import 'package:riccos/core/api_constants.dart';
import 'package:riccos/models/pedido_del_usuario_response.dart';
import 'package:riccos/models/pedido_model.dart';
import 'package:riccos/services/auth_service.dart';
import 'package:http/http.dart' as http;

class PedidoService {
  final AuthService authService;

  PedidoService(this.authService);

  Future<List<PedidoDelUsuarioResponse>> getPedidosMozoFiltrado({
    int? idProducto,
    DateTime? fechaInicio,
    DateTime? fechaFin,
  }) async {
    final idUser =
        await authService.getIdUsuario(); // Obtiene el ID del usuario
    final url = Uri.parse(
        "${ApiConstants.pedido}pedidos-filtrado?idUser=$idUser&idProducto=${idProducto ?? ''}&fechaInicio=${fechaInicio?.toIso8601String() ?? ''}&fechaFin=${fechaFin?.toIso8601String() ?? ''}");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((json) => PedidoDelUsuarioResponse.fromJson(json))
          .toList();
    } else {
      throw Exception('Error al obtener pedidos');
    }
  }

  Future<List<PedidoModel>> getPedido() async {
    final url = Uri.parse(ApiConstants.pedido);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        // Decodificamos la respuesta JSON y asumimos que es una lista
        final List data = jsonDecode(response.body);

        // Convertimos la lista JSON en una lista de objetos PedidoMesaModel
        return data.map((pedido) => PedidoModel.fromJson(pedido)).toList();
      } catch (e) {
        throw Exception('Error al procesar la respuesta: $e');
      }
    } else {
      throw Exception(
          'Error al obtener el pedido mesa: ${response.statusCode}');
    }
  }

  Future<PedidoModel> getPedidoById(int idPedido) async {
    final url = Uri.parse('${ApiConstants.pedido}$idPedido');
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
        // Decodificamos la respuesta JSON
        final data = jsonDecode(response.body);
        // Convertimos la respuesta JSON en un objeto PedidoModel
        return PedidoModel.fromJson(data);
      } catch (e) {
        throw Exception('Error al procesar la respuesta: $e');
      }
    } else {
      throw Exception('Error al obtener el pedido: ${response.statusCode}');
    }
  }
}
