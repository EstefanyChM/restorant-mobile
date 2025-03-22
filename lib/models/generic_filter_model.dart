// Clase que representa un filtro individual
class ItemFilter {
  String name;
  String value;

  ItemFilter({
    this.name = "",
    this.value = "",
  });

  // Constructor de fábrica para crear un ItemFilter desde un Map (JSON)
  factory ItemFilter.fromJson(Map<String, dynamic> json) {
    return ItemFilter(
      name: json['name'] ?? '',
      value: json['value'] ?? '',
    );
  }

  // Método para convertir un ItemFilter a Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
    };
  }
}

// Clase que representa la solicitud de filtro (GenericFilterRequest)
class GenericFilterRequest {
  int numeroPagina;
  int cantidad;
  List<ItemFilter> filtros;

  GenericFilterRequest({
    this.numeroPagina = 1,
    this.cantidad = 8,
    this.filtros = const [],
  });

  // Constructor de fábrica para crear GenericFilterRequest desde un Map (JSON)
  factory GenericFilterRequest.fromJson(Map<String, dynamic> json) {
    return GenericFilterRequest(
      numeroPagina: json['numeroPagina'] ?? 1,
      cantidad: json['cantidad'] ?? 8,
      filtros: (json['filtros'] as List<dynamic>?)
              ?.map((item) => ItemFilter.fromJson(item))
              .toList() ??
          [],
    );
  }

  // Método para convertir GenericFilterRequest a Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'numeroPagina': numeroPagina,
      'cantidad': cantidad,
      'filtros': filtros.map((item) => item.toJson()).toList(),
    };
  }
}

// Clase que representa la respuesta de filtro (GenericFilterResponse)
class GenericFilterResponse<T> {
  int totalRegistros;
  List<T> lista;

  GenericFilterResponse({
    this.totalRegistros = 0,
    this.lista = const [],
  });

  // Constructor de fábrica para crear GenericFilterResponse desde un Map (JSON)
  factory GenericFilterResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return GenericFilterResponse<T>(
      totalRegistros: json['totalRegistros'] ?? 0,
      lista: (json['lista'] as List<dynamic>?)
              ?.map((item) => fromJsonT(item))
              .toList() ??
          [],
    );
  }

  // Método para convertir GenericFilterResponse a Map (JSON)
  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'totalRegistros': totalRegistros,
      'lista': lista.map((item) => toJsonT(item)).toList(),
    };
  }
}
