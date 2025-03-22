class PersonalEmpresaResponseModel {
  int? id;
  int? idPersonaNatural;
  String? nombre;
  String? apellidos;
  DateTime? fechaNacimiento;
  String? celular;
  String? direccion;
  String? numeroDocumento;
  int? idPersonaTipoDocumento;
  String? email;
  List<String>? rolesNombre;

  PersonalEmpresaResponseModel({
    this.id,
    this.idPersonaNatural,
    this.nombre,
    this.apellidos,
    this.fechaNacimiento,
    this.celular,
    this.direccion,
    this.numeroDocumento,
    this.idPersonaTipoDocumento,
    this.email,
    this.rolesNombre,
  });

  factory PersonalEmpresaResponseModel.fromJson(Map<String, dynamic> json) {
    return PersonalEmpresaResponseModel(
      id: json['id'] as int?,
      idPersonaNatural: json['idPersonaNatural'] as int?,
      nombre: json['nombre'] as String?,
      apellidos: json['apellidos'] as String?,
      fechaNacimiento: json['fechaNacimiento'] != null
          ? DateTime.parse(json['fechaNacimiento'])
          : null,
      celular: json['celular'] as String?,
      direccion: json['direccion'] as String?,
      numeroDocumento: json['numeroDocumento'] as String?,
      idPersonaTipoDocumento: json['idPersonaTipoDocumento'] as int?,
      email: json['email'] as String?,
      rolesNombre:
          (json['rolesNombre'] as List<dynamic>?)?.cast<String>().toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idPersonaNatural'] = idPersonaNatural;
    data['nombre'] = nombre;
    data['apellidos'] = apellidos;
    data['fechaNacimiento'] = fechaNacimiento?.toIso8601String();
    data['celular'] = celular;
    data['direccion'] = direccion;
    data['numeroDocumento'] = numeroDocumento;
    data['idPersonaTipoDocumento'] = idPersonaTipoDocumento;
    data['email'] = email;
    data['rolesNombre'] = rolesNombre;
    return data;
  }
}
