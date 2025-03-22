import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:riccos/core/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
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
    final url =
        Uri.parse('${ApiConstants.authUser}login?esPersonal=$esPersonal');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        //body: jsonEncode({'email': email, 'password': password}),
        body: jsonEncode(
            {'email': 'mozo_juan@riccos.com', 'password': 'aA123456!'}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
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
