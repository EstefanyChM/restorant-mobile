import 'package:flutter/material.dart';

import '../../../../constants.dart';

class LogInForm extends StatelessWidget {
  const LogInForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            /*********************** */
            //validator: emaildValidator.call,
            /*********************** */
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Email",
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: Icon(
                  Icons.mail,
                  size: 24,
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: passwordController,
            /*********************** */
            //validator: passwordValidator.call,
            /*********************** */
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "Contraseña",
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: Icon(
                  Icons.lock, // Ícono del campo
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
