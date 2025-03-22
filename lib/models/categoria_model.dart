class CategoriaModel {
  int id;
  int cantidadDeProductos;
  double precioMaximo;
  double precioMinimo;
  String nombre;
  String descripcion;
  bool disponibilidad;
  String disponibilidadDescripcion;
  bool estado;
  String estadoDescripcion;
  String urlImagen;

  CategoriaModel({
    this.id = 0,
    this.cantidadDeProductos = 0,
    this.precioMaximo = 0.0,
    this.precioMinimo = 0.0,
    this.nombre = "",
    this.descripcion = "",
    this.disponibilidad = true,
    this.disponibilidadDescripcion = "",
    this.estado = true,
    this.estadoDescripcion = "",
    this.urlImagen = "",
  });

  factory CategoriaModel.fromJson(Map<String, dynamic> json) {
    return CategoriaModel(
      id: json['id'] ?? 0,
      cantidadDeProductos: json['cantidadDeProductos'] ?? 0,
      precioMaximo: json['precioMaximo']?.toDouble() ?? 0.0,
      precioMinimo: json['precioMinimo']?.toDouble() ?? 0.0,
      nombre: json['nombre'] ?? "",
      descripcion: json['descripcion'] ?? "",
      disponibilidad: json['disponibilidad'] ?? true,
      disponibilidadDescripcion: json['disponibilidadDescripcion'] ?? "",
      estado: json['estado'] ?? true,
      estadoDescripcion: json['estadoDescripcion'] ?? "",
      urlImagen: json['urlImagen'] ?? "",
    );
  }
}
