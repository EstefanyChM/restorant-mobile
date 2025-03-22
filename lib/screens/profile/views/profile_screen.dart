import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riccos/constants.dart';
import 'package:riccos/models/personal_empresa_response_model.dart';
import 'package:riccos/route/screen_export.dart';
import 'package:riccos/services/personal_empresa_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/profile_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late PersonalEmpresaService _personalEmpresaService;

  @override
  void initState() {
    super.initState();
    _personalEmpresaService =
        Provider.of<PersonalEmpresaService>(context, listen: false);
  }

  Future<PersonalEmpresaResponseModel?> _fetchUserData() async {
    // Replace with your actual user ID retrieval logic
    try {
      final PersonalEmpresaResponseModel userData =
          await _personalEmpresaService.getUsuarioSistema();
      return userData;
    } catch (e) {
      print('Error fetching user data: $e');
      return null; // Handle errors gracefully (e.g., show a snackbar)
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwtToken');
    Navigator.pushNamedAndRemoveUntil(
      context,
      logInScreenRoute,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          FutureBuilder<PersonalEmpresaResponseModel?>(
            future: _fetchUserData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data!;
                return ProfileCard(
                  name: userData.nombre!,
                  email:
                      userData.email!, // Assuming 'email' exists in the model
                  imageSrc:
                      //"https://www.thefamouspeople.com/profiles/images/joe-alwyn-4.jpg",
                      "https://us.123rf.com/450wm/asmati/asmati1701/asmati170103397/70513388-ilustraci%C3%B3n-de-signo-de-usuario-icono-naranja-con-la-ruta-de-sombra-de-estilo-plano.jpg",
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              // Display a loading indicator while fetching data
              return const Center(child: CircularProgressIndicator());
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text(
              "Mi cuenta",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(height: defaultPadding / 2),

          // Log Out
          ListTile(
            onTap: () async {
              await logout();
            },
            minLeadingWidth: 24,
            leading: const Icon(Icons.logout,
                size: 24, color: Colors.red), // Ícono rojo
            title: const Text(
              "Cerrar Sesión",
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold), // Texto rojo y en negrita
            ),
          ),
        ],
      ),
    );
  }
}
