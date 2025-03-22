class ProductoModel {
  int id;
  int stock;
  String nombre;
  String descripcion;
  bool disponibilidad;
  bool estado;
  double precio;
  int idCategoria;
  String categoriaNombre;
  String urlImagen;
  String disponibilidadDescripcion;
  int stockAuxiliar;

  ProductoModel({
    this.id = 0,
    this.stock = 0,
    this.nombre = "",
    this.descripcion = "",
    this.disponibilidad = true,
    this.estado = false,
    this.precio = 0.0,
    this.idCategoria = 0,
    this.categoriaNombre = "",
    this.urlImagen = "",
    this.disponibilidadDescripcion = "",
    this.stockAuxiliar = 0,
  });

  // Método de deserialización
  factory ProductoModel.fromJson(Map<String, dynamic> json) {
    return ProductoModel(
      id: json['id'] ?? 0,
      stock: json['stock'] ?? 0,
      nombre: json['nombre'] ?? "",
      descripcion: json['descripcion'] ?? "",
      disponibilidad: json['disponibilidad'] ?? true,
      estado: json['estado'] ?? false,
      precio: json['precio']?.toDouble() ?? 0.0,
      idCategoria: json['idCategoria'] ?? 0,
      categoriaNombre: json['categoriaNombre'] ?? "",
      urlImagen: json['urlImagen'] ?? "",
      disponibilidadDescripcion: json['disponibilidadDescripcion'] ?? "",
      stockAuxiliar: json['stockAuxiliar'] ?? 0,
    );
  }

  // Método de serialización
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stock': stock,
      'nombre': nombre,
      'descripcion': descripcion,
      'disponibilidad': disponibilidad,
      'estado': estado,
      'precio': precio,
      'idCategoria': idCategoria,
      'categoriaNombre': categoriaNombre,
      'urlImagen': urlImagen,
      'disponibilidadDescripcion': disponibilidadDescripcion,
      'stockAuxiliar': stockAuxiliar,
    };
  }
}
