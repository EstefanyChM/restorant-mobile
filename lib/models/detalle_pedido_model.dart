class DetallePedidoModel {
  int id;
  int cantidad;
  int idProducto;
  int idPedido;
  int idCategoria;
  String nombreCategoria;
  String nombreProducto;
  double subTotal;
  double precioUnitario;

  DetallePedidoModel({
    this.id = 0,
    this.cantidad = 0,
    this.idProducto = 0,
    this.idPedido = 0,
    this.idCategoria = 0,
    this.nombreCategoria = '',
    this.nombreProducto = '',
    this.subTotal = 0.0,
    this.precioUnitario = 0.0,
  });

  // Método estático fromJson
  factory DetallePedidoModel.fromJson(Map<String, dynamic> json) {
    return DetallePedidoModel(
      id: json['id'] ?? 0,
      cantidad: json['cantidad'] ?? 0,
      idProducto: json['idProducto'] ?? 0,
      idPedido: json['idPedido'] ?? 0,
      idCategoria: json['idCategoria'] ?? 0,
      nombreCategoria: json['nombreCategoria'] ?? '',
      nombreProducto: json['nombreProducto'] ?? '',
      subTotal: json['subTotal']?.toDouble() ?? 0.0,
      precioUnitario: json['precioUnitario']?.toDouble() ?? 0.0,
    );
  }

  // Método toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cantidad': cantidad,
      'idProducto': idProducto,
      'idPedido': idPedido,
      'idCategoria': idCategoria,
      'nombreCategoria': nombreCategoria,
      'nombreProducto': nombreProducto,
      'subTotal': subTotal,
      'precioUnitario': precioUnitario,
    };
  }
}
