import 'package:dio/dio.dart';
import 'package:riccos/core/api_constants.dart';
import 'package:riccos/models/usuarios_sistema_request_model.dart';
import 'package:riccos/models/usuarios_sistema_response_model.dart';
import 'package:riccos/services/auth_service.dart';

class UsuarioSistemaService {
  final AuthService authService;
  final Dio _dio = Dio();

  UsuarioSistemaService(this.authService) {
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  Future<UsuariosSistemaResponseModel> obtenerUsuarioSistema() async {
    try {
      final token = await authService.getToken();
      final idUsuario = await authService.getIdUsuario();
      _dio.options.headers['Authorization'] = 'Bearer $token';
      Response response =
          await _dio.get('${ApiConstants.usuarioSistema}$idUsuario');
      return UsuariosSistemaResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Error al obtener el usuario del sistema: $e');
    }
  }

  Future<UsuariosSistemaRequestModel> actualizarUsuarioSistema(
      UsuariosSistemaResponseModel datos) async {
    try {
      final token = await authService.getToken();
      final idUsuario = await authService.getIdUsuario();
      _dio.options.headers['Authorization'] = 'Bearer $token';

      Response response = await _dio
          .put('${ApiConstants.usuarioSistema}$idUsuario', data: datos);
      return UsuariosSistemaRequestModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Error al actualizar el usuario del sistema: $e');
    }
  }
}
