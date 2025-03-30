import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:riccos/core/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dio/dio.dart';

class AuthService with ChangeNotifier {
  final Dio dio = Dio(); // Instancia de Dio

  Future<void> _saveToPrefs(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwtToken');
  }

  Future<int?> getIdUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('idUsuario');
  }

  Future<Map<String, dynamic>?> login(String email, String password,
      {bool esPersonal = true}) async {
    final url = '${ApiConstants.authUser}login?esPersonal=$esPersonal';

    try {
      final response = await dio.post(
        url,
        options: Options(headers: {"Content-Type": "application/json"}),
        data:
            jsonEncode({'email': 'mozo_1@riccos.com', 'password': 'aA123456!'}),
      );

      if (response.statusCode == 200) {
        final data = response.data; // Dio ya convierte automáticamente a JSON
        final token = data['token'];
        final idUsuario = data['idUsuario'];

        await _saveToPrefs('jwtToken', token);
        await _saveToPrefs('idUsuario', idUsuario);

        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("Error en la solicitud: $e");
      return null;
    }
  }
}
