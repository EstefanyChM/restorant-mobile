import 'package:riccos/core/api_constants.dart';
import 'package:riccos/models/pedido_del_usuario_response.dart';
import 'package:riccos/models/pedido_model.dart';
import 'package:riccos/services/auth_service.dart';
import 'package:dio/dio.dart';

class PedidoService {
  final AuthService authService;
  final Dio _dio = Dio();

  PedidoService(this.authService);

  Future<List<PedidoDelUsuarioResponse>> getPedidosMozoFiltrado({
    int? idProducto,
    DateTime? fechaInicio,
    DateTime? fechaFin,
  }) async {
    final idUser = await authService.getIdUsuario();
    final queryParams = {
      'idUser': idUser.toString(),
      if (idProducto != null) 'idProducto': idProducto.toString(),
      if (fechaInicio != null) 'fechaInicio': fechaInicio.toIso8601String(),
      if (fechaFin != null) 'fechaFin': fechaFin.toIso8601String(),
    };

    try {
      final response = await _dio.get(
        "${ApiConstants.pedido}pedidos-filtrado",
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List data = response.data;
        return data
            .map((json) => PedidoDelUsuarioResponse.fromJson(json))
            .toList();
      } else {
        throw Exception('Error al obtener pedidos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }

  Future<List<PedidoModel>> getPedido() async {
    try {
      final response = await _dio.get(ApiConstants.pedido);

      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((pedido) => PedidoModel.fromJson(pedido)).toList();
      } else {
        throw Exception('Error al obtener el pedido: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }

  Future<PedidoModel> getPedidoById(int idPedido) async {
    final token = await authService.getToken();

    try {
      final response = await _dio.get(
        '${ApiConstants.pedido}$idPedido',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return PedidoModel.fromJson(response.data);
      } else {
        throw Exception('Error al obtener el pedido: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }
}
