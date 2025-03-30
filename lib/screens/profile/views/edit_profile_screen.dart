import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riccos/models/usuarios_sistema_response_model.dart';
import 'package:riccos/services/usuario_sistema_service.dart';

class EditProfileScreen extends StatefulWidget {
  final UsuariosSistemaResponseModel userData;

  const EditProfileScreen({super.key, required this.userData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _apellidosController;
  late TextEditingController _emailController;
  late TextEditingController _celularController;
  late TextEditingController _direccionController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.userData.nombre);
    _apellidosController =
        TextEditingController(text: widget.userData.apellidos);
    _emailController = TextEditingController(text: widget.userData.email);
    _celularController = TextEditingController(text: widget.userData.celular);
    _direccionController =
        TextEditingController(text: widget.userData.direccion ?? '');
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidosController.dispose();
    _emailController.dispose();
    _celularController.dispose();
    _direccionController.dispose();
    super.dispose();
  }

  Future<void> _updateUserData() async {
    if (_formKey.currentState!.validate()) {
      final usuarioService =
          Provider.of<UsuarioSistemaService>(context, listen: false);
      try {
        await usuarioService.actualizarUsuarioSistema(
          UsuariosSistemaResponseModel(
              id: widget.userData.id,
              nombre: _nombreController.text,
              apellidos: _apellidosController.text,
              email: _emailController.text,
              celular: _celularController.text,
              direccion: _direccionController.text,
              numeroDocumento: widget.userData.numeroDocumento,
              idPersonaTipoDocumento: widget.userData.idPersonaTipoDocumento,
              fechaNacimiento: widget.userData.fechaNacimiento,
              roles: widget.userData.roles),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Datos actualizados correctamente")),
        );
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al actualizar: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Editar Perfil")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: "Nombre"),
                validator: (value) => value!.isEmpty ? "Campo requerido" : null,
              ),
              TextFormField(
                controller: _apellidosController,
                decoration: const InputDecoration(labelText: "Apellidos"),
                validator: (value) => value!.isEmpty ? "Campo requerido" : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value!.contains('@') ? null : "Email inválido",
              ),
              TextFormField(
                controller: _celularController,
                decoration: const InputDecoration(labelText: "Celular"),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? "Campo requerido" : null,
              ),
              TextFormField(
                controller: _direccionController,
                decoration: const InputDecoration(labelText: "Dirección"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateUserData,
                child: const Text("Guardar Cambios"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
