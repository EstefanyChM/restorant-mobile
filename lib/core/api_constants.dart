// lib/core/constants/api_constants.dart

class ApiConstants {
  // Definir el dominio base
  //static const String dominio = "https://riccos.somee.com/";
  static const String dominio = "https://192.168.100.115:45455/";
  //static const String dominio = "https://localhost:7063/";

  // Definir las rutas de los endpoints

  static const String categoria = "${dominio}api/categoria/";
  static const String producto = "${dominio}api/producto/";
  static const String cliente = "${dominio}api/Cliente/";
  static const String pedido = "${dominio}api/pedido/";
  static const String authUser = "${dominio}api/AuthUser/";
  static const String venta = "${dominio}api/venta/";
  static const String mesa = "${dominio}api/mesa/";
  static const String enTienda = "${dominio}api/EnTienda/";
  static const String promocion = "${dominio}api/Promocion/";
  static const String personalEmpresa = "${dominio}api/PersonalEmpresa/";
}
