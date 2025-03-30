class UsuariosSistemaResponseModel {
  int id;
  int idPersonalEmpresa;
  String idPersonaNatural;
  String email;
  bool estado;
  String nombre;
  String apellidos;
  DateTime fechaNacimiento;
  String celular;
  String? direccion;
  String numeroDocumento;
  int idPersonaTipoDocumento;
  List<String> roles = [];

  UsuariosSistemaResponseModel({
    required this.id,
    this.idPersonalEmpresa = 0,
    this.idPersonaNatural = "",
    this.email = "",
    this.estado = false,
    required this.nombre,
    required this.apellidos,
    required this.fechaNacimiento,
    required this.celular,
    this.direccion,
    required this.numeroDocumento,
    required this.idPersonaTipoDocumento,
    required this.roles,
  });

  String get estadoDescripcion => estado ? "Activo" : "Inactivo";

  factory UsuariosSistemaResponseModel.fromJson(Map<String, dynamic> json) {
    return UsuariosSistemaResponseModel(
      id: json['id'],
      idPersonalEmpresa: json['idPersonalEmpresa'] ?? 0,
      idPersonaNatural: json['idPersonaNatural'] ?? "",
      email: json['email'] ?? "",
      estado: json['estado'] ?? false,
      nombre: json['nombre'],
      apellidos: json['apellidos'],
      fechaNacimiento: DateTime.parse(json['fechaNacimiento']),
      celular: json['celular'],
      direccion: json['direccion'],
      numeroDocumento: json['numeroDocumento'],
      idPersonaTipoDocumento: json['idPersonaTipoDocumento'],
      roles: List<String>.from(json['roles'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idPersonalEmpresa': idPersonalEmpresa,
      'idPersonaNatural': idPersonaNatural,
      'email': email,
      'estado': estado,
      'nombre': nombre,
      'apellidos': apellidos,
      'fechaNacimiento': fechaNacimiento.toIso8601String(),
      'celular': celular,
      'direccion': direccion,
      'numeroDocumento': numeroDocumento,
      'idPersonaTipoDocumento': idPersonaTipoDocumento,
      'roles': roles,
    };
  }
}
