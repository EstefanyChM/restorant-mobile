import 'dart:convert';
import 'dart:io';
import 'package:riccos/core/api_constants.dart';
import 'package:riccos/models/personal_empresa_response_model.dart';
import 'package:riccos/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class PersonalEmpresaService {
  final AuthService authService;

  PersonalEmpresaService(this.authService);

  Future<PersonalEmpresaResponseModel> getUsuarioSistema() async {
    final token = await authService.getToken();
    final url = Uri.parse(
        'https://192.168.100.115:45455/api/PersonalEmpresa/SystemUser/2');

    var client = http.Client();
    var response = await client.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");
    print("Headers enviados: ${response.request?.headers}");
    print("Token en Flutter: Bearer $token");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return PersonalEmpresaResponseModel.fromJson(data);
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }
}

/*class PersonalEmpresaService {
  final AuthService authService;

  PersonalEmpresaService(this.authService);

  Future<PersonalEmpresaResponseModel> getUsuarioSistema() async {
    final idUsuario = await authService.getIdUsuario();
    final url =
        Uri.parse('${ApiConstants.personalEmpresa}SystemUser/$idUsuario');
    final token = await authService.getToken();

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json', // <-- Asegura que acepta JSON
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

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
}*/
