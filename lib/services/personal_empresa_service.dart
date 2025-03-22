import 'dart:convert';

import 'package:riccos/core/api_constants.dart';
import 'package:riccos/models/personal_empresa_response_model.dart';
import 'package:riccos/services/auth_service.dart';
import 'package:http/http.dart' as http;

class PersonalEmpresaService {
  final AuthService authService;

  PersonalEmpresaService(this.authService);

  Future<PersonalEmpresaResponseModel> getUsuarioSistema() async {
    final idUsuario = await authService.getIdUsuario();
    final url =
        Uri.parse('${ApiConstants.personalEmpresa}SystemUser/$idUsuario');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return PersonalEmpresaResponseModel.fromJson(data);

        //return jsonDecode(response.body); // Parse the JSON response
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
