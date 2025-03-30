import 'package:riccos/core/api_constants.dart';
import 'package:riccos/models/en_tienda_request_model.dart';
import 'package:riccos/models/en_tienda_response_model.dart';
import 'package:riccos/models/pedido_mesa_model.dart';
import 'package:dio/dio.dart';
import 'package:riccos/services/auth_service.dart';

class EnTiendaService {
  final AuthService authService;
  final Dio _dio = Dio();

  EnTiendaService(this.authService);

  Future<List<PedidoMesaModel>> getPedidoMesa() async {
    final token = await authService.getToken();

    try {
      final response = await _dio.get(
        '${ApiConstants.enTienda}pedido-mesa',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List data = response.data;
        return data
            .map((pedidoMesa) => PedidoMesaModel.fromJson(pedidoMesa))
            .toList();
      } else {
        throw Exception(
            'Error al obtener el pedido mesa: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }

  Future<EnTiendaResponseModel> finalizarPedido(int id) async {
    final token = await authService.getToken();

    try {
      final response = await _dio.patch(
        '${ApiConstants.enTienda}finalizar/$id',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
        data: {}, // Puedes agregar datos aquí si es necesario
      );

      if (response.statusCode == 200) {
        return EnTiendaResponseModel.fromJson(response.data);
      } else {
        throw Exception('Error al finalizar el pedido: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }

  Future<EnTiendaResponseModel> create(EnTiendaRequestModel request) async {
    final idUser = await authService.getIdUsuario();
    final token = await authService.getToken();

    try {
      final response = await _dio.post(
        "${ApiConstants.enTienda}?idUser=$idUser",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
        data: request.toJson(), // Convierte EnTiendaRequestModel a JSON
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
}
