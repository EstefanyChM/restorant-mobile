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
          Theme(
              data: Theme.of(context).copyWith(
                  textSelectionTheme: const TextSelectionThemeData(
                selectionColor: tertiaryLight,
                cursorColor: tertiaryColor,
                selectionHandleColor: tertiaryColor,
              )),
              child: TextFormField(
                controller: emailController,
                /*********************** */
                //validator: emaildValidator.call,
                /*********************** */
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                style: Theme.of(context).textTheme.titleLarge,

                decoration: InputDecoration(
                  filled: true,
                  fillColor: superColor,
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: secondaryLight, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: primaryLight, width: 3.0), // Borde al enfocar
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: "Email",
                  hintStyle:
                      const TextStyle(color: tertiaryLight, fontSize: 20),
                  prefixIcon: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                    child: Icon(
                      Icons.mail,
                      size: 30,
                      color: tertiaryLight,
                    ),
                  ),
                ),
              )),
          /**/
          const SizedBox(height: defaultPadding),
          Theme(
            data: Theme.of(context).copyWith(
                textSelectionTheme: const TextSelectionThemeData(
              selectionColor: tertiaryLight,
              cursorColor: tertiaryColor,
              selectionHandleColor: tertiaryColor,
            )),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              style: Theme.of(context).textTheme.titleLarge,
              cursorColor: tertiaryColor,
              //cur
              decoration: InputDecoration(
                filled: true,
                fillColor: superColor,
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: secondaryLight, width: 2),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: primaryLight, width: 3.0), // Borde al enfocar
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Contraseña",
                hintStyle: const TextStyle(color: tertiaryLight, fontSize: 20),
                prefixIcon: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                  child: Icon(
                    Icons.lock, // Ícono del campo
                    size: 30,
                    color: tertiaryLight,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
