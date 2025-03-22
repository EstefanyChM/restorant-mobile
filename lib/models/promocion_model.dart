class PromocionModel {
  int id;
  String urlImagen;
  DateTime fechaInicio;
  DateTime fechaFin;
  String descripcion;
  String nombre;
  double total;
  double dctoPorcentaje;
  int stock;

  PromocionModel({
    required this.id,
    required this.urlImagen,
    required this.fechaInicio,
    required this.fechaFin,
    required this.descripcion,
    required this.nombre,
    required this.total,
    required this.dctoPorcentaje,
    required this.stock,
  });

  // Factory method to create a Promocion instance from JSON
  factory PromocionModel.fromJson(Map<String, dynamic> json) {
    return PromocionModel(
      id: json['id'],
      urlImagen: json['urlImagen'],
      fechaInicio: DateTime.parse(json['fechaInicio']),
      fechaFin: DateTime.parse(json['fechaFin']),
      descripcion: json['descripcion'],
      nombre: json['nombre'],
      total: json['total'].toDouble(),
      dctoPorcentaje: json['dctoPorcentaje'].toDouble(),
      stock: json['stock'],
    );
  }

  // Method to convert a Promocion instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'urlImagen': urlImagen,
      'fechaInicio': fechaInicio.toIso8601String(),
      'fechaFin': fechaFin.toIso8601String(),
      'descripcion': descripcion,
      'nombre': nombre,
      'total': total,
      'dctoPorcentaje': dctoPorcentaje,
      'stock': stock,
    };
  }
}
