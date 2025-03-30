import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riccos/constants.dart';
import 'package:riccos/models/usuarios_sistema_response_model.dart';
import 'package:riccos/route/screen_export.dart';
import 'package:riccos/services/usuario_sistema_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UsuarioSistemaService _personalEmpresaService;

  @override
  void initState() {
    super.initState();
    _personalEmpresaService =
        Provider.of<UsuarioSistemaService>(context, listen: false);
  }

  Future<UsuariosSistemaResponseModel?> _fetchUserData() async {
    try {
      final UsuariosSistemaResponseModel userData =
          await _personalEmpresaService.obtenerUsuarioSistema();
      return userData;
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
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
      body: FutureBuilder<UsuariosSistemaResponseModel?>(
        future: _fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No se encontraron datos'));
          }

          final userData = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        // Quita "const" porque primaryMaterialColor no es constante
                        gradient: LinearGradient(
                          colors: [
                            primaryMaterialColor[
                                50]!, // Usa "!" para asegurar que no sea null
                            primaryMaterialColor[900]!,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          "https://us.123rf.com/450wm/asmati/asmati1701/asmati170103397/70513388-ilustraci%C3%B3n-de-signo-de-usuario-icono-naranja-con-la-ruta-de-sombra-de-estilo-plano.jpg",
                        ),
                        backgroundColor: Colors.transparent, // Opcional
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Text(
                  "${userData.nombre} ${userData.apellidos}",
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                Text(
                  userData.email,
                  style: const TextStyle(color: primaryColor, fontSize: 20),
                ),
                const SizedBox(height: 20),
                Card(
                  color: whiteColor,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildProfileInfo(
                            Icons.phone, "Celular", userData.celular),
                        _buildProfileInfo(
                            Icons.calendar_today,
                            "Fecha de Nacimiento",
                            "${userData.fechaNacimiento.toLocal()}"
                                .split(' ')[0]),
                        _buildProfileInfo(Icons.location_on, "Dirección",
                            userData.direccion ?? "No registrada"),
                        _buildProfileInfo(Icons.badge, "Documento",
                            "${userData.numeroDocumento} (${userData.idPersonaTipoDocumento})"),
                        _buildProfileInfo(Icons.verified_user, "Estado",
                            userData.estadoDescripcion),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, editProfileScreenRoute,
                              arguments: userData);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: warningColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Editar Datos",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          await logout();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: errorColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Cerrar Sesión",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileInfo(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: tertiaryColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
