import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

// Colores principales
const Color primaryColor = Color(0xFF321E00); // Marrón oscuro
const Color secondaryColor = Color(0xFFFFC864); // Amarillo anaranjado
const Color tertiaryColor = Color(0xFFFF6432); // Naranja rojizo

// Tonos más claros
const Color primaryLight = Color(0xFF6E5537); // Marrón más claro
const Color secondaryLight = Color(0xFFFFDC96); // Amarillo pastel
const Color tertiaryLight = Color(0xFFFFA06E); // Naranja suave

// Color especial
const Color superColor = Color(0xFFFFF5E9); // Crema muy claro

// Tonos de negro y blanco adaptados
const Color blackColor = Color(0xFF161616);
const Color blackColor80 = Color(0xFF383838);
const Color blackColor60 = Color(0xFF5C5C5C);
const Color blackColor40 = Color(0xFF8A8A8A);
const Color blackColor20 = Color(0xFFB8B8B8);
const Color blackColor10 = Color(0xFFDCDCDC);
const Color blackColor5 = Color(0xFFEFEFEF);

const Color whiteColor = Colors.white;
const Color whiteColor80 = Color(0xFFDDDDDD);
const Color whiteColor60 = Color(0xFFBBBBBB);
const Color whiteColor40 = Color(0xFF999999);
const Color whiteColor20 = Color(0xFF777777);
const Color whiteColor10 = Color(0xFF555555);
const Color whiteColor5 = Color(0xFF333333);

// Tonos de gris adecuados a la paleta
const Color greyColor = Color(0xFFB8B5C3);
const Color lightGreyColor = Color(0xFFF2F2F2);
const Color darkGreyColor = Color(0xFF2A2A2A);

// Colores de estado
const Color successColor = Color.fromARGB(255, 112, 175, 40); // Verde éxito
const Color warningColor = Color(0xFFFFBE21); // Amarillo advertencia
const Color errorColor = Color.fromARGB(255, 228, 41, 17); // Rojo error

// MaterialColor para el color primario
const MaterialColor primaryMaterialColor =
    MaterialColor(0xFFFFD8A8, <int, Color>{
  50: Color(0xFFFFF5E9), // Color más claro
  100: Color(0xFFFFE5C4),
  200: Color(0xFFFFD39E),
  300: Color(0xFFFFBF78),
  400: Color(0xFFFFAB52),
  500: Color(0xFFFF972C), // Color principal
  600: Color(0xFFD67824),
  700: Color(0xFFAD5D1C),
  800: Color(0xFF854314),
  900: Color(0xFF321E00), // Color más oscuro
});

const double defaultPadding = 20.0;
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
