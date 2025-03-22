import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

const Color primaryColor = Color(0xFF321E00);
const Color secondaryColor = Color.fromARGB(255, 255, 190, 68);
const Color tertiaryColor = Color(0xFFFF6432);
/**************** */
const Color primaryColorS = Color.fromARGB(255, 223, 174, 111);
const Color secondaryColorS = Color.fromARGB(255, 255, 243, 220);
const Color tertiaryColorS = Color.fromARGB(255, 255, 181, 156);

const double defaultPadding = 16.0;
const double defaultBorderRadious = 10.0;
const Duration defaultDuration = Duration(milliseconds: 300);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Contraseña es requerido'),
  MinLengthValidator(8,
      errorText: 'La contraseña debe tener al menos 8 dígitos'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'passwords must have at least one special character')
]);

final emaildValidator = MultiValidator([
  RequiredValidator(errorText: 'Email es obligatorio'),
  EmailValidator(errorText: "Ingresa un email válido"),
]);

const pasNotMatchErrorText = "passwords do not match";
