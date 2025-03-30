import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riccos/constants.dart';
import 'package:riccos/models/button_state.dart';
import 'package:riccos/route/route_constants.dart';
import 'package:riccos/screens/clipped_parts_widget.dart';
import 'package:riccos/services/auth_service.dart';
import 'components/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  ButtonState _buttonState = ButtonState.idle;

  Future<void> _login() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      setState(() => _buttonState = ButtonState.loading);
      final response = await authService.login(
        _emailController.text,
        _passwordController.text,
      );
      setState(() => _buttonState = ButtonState.idle);

      if (response != null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          entryPointScreenRoute,
          ModalRoute.withName(logInScreenRoute),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error de autenticación")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        ClippedPartsWidget(
          top: Container(
            color: secondaryColor,
          ),
          bottom: Container(
            color: primaryColor,
          ),
          splitFunction: (Size size, double x) {
            // normalizing x to make it exactly one wave
            final normalizedX = x / size.width * -1 * pi;
            final waveHeight = size.height / 20;
            final y = size.height / 4 - sin(normalizedX) * waveHeight;

            return y;
          },
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: defaultPadding * 5),
              Image.asset(
                "assets/icons/ic_riccos_1.png",
                height: 140, // Ajusta la altura según necesites
                fit: BoxFit.contain, // Ajuste de la imagen dentro del espacio
              ),
              const SizedBox(
                height: defaultPadding * 2,
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "¡Bienvenido!",
                      //style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    Text("Ingresa tus datos para continuar",
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: defaultPadding),
                    LogInForm(
                      formKey: _formKey,
                      emailController: _emailController,
                      passwordController: _passwordController,
                    ),
                    /*Align(
                    child: TextButton(
                      child: const Text("Me olvidé mi contraseña"),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, passwordRecoveryScreenRoute);
                      },
                    ),
                  ),*/
                    SizedBox(
                      height: size.height > 700
                          ? size.height * 0.07
                          : defaultPadding,
                    ),
                    ElevatedButton(
                      onPressed:
                          _buttonState == ButtonState.loading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        shadowColor: tertiaryLight,
                        backgroundColor: tertiaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              defaultBorderRadious * 3), // Bordes redondeados
                        ),
                        elevation: 5, // Efecto 3D
                        padding: const EdgeInsets.all(
                            10), // Margen similar a CustomButton
                      ),
                      child: _buttonState == ButtonState.loading
                          ? const CircularProgressIndicator(
                              backgroundColor: primaryColor,
                              color: secondaryColor)
                          : const Text(
                              "Log in",
                              style: TextStyle(color: superColor, fontSize: 25),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
