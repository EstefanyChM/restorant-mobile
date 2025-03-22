class PedidoDelUsuarioResponse {
  final int idProducto;
  final String nombreProducto;
  final int cantidad;
  final DateTime fecha;

  PedidoDelUsuarioResponse({
    required this.idProducto,
    required this.nombreProducto,
    required this.cantidad,
    required this.fecha,
  });

  // Método para convertir un mapa JSON a un objeto PedidoDelUsuarioResponse
  factory PedidoDelUsuarioResponse.fromJson(Map<String, dynamic> json) {
    return PedidoDelUsuarioResponse(
      idProducto: json['idProducto'],
      nombreProducto: json['nombreProducto'],
      cantidad: json['cantidad'],
      fecha: DateTime.parse(json['fecha']),
    );
  }

  // Método para convertir un objeto PedidoDelUsuarioResponse a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'idProducto': idProducto,
      'nombreProducto': nombreProducto,
      'cantidad': cantidad,
      'fecha': fecha.toIso8601String(),
    };
  }
}
