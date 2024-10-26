class Tutoria {
  final int? id;
  final int tutorId;
  final String fecha; // Fecha en formato ISO
  final int duracion; // Duración en minutos
  final String estado; // Puede ser 'pendiente', 'completada', 'cancelada'

  // Constructor de la clase Tutoria.
  Tutoria({
    this.id,
    required this.tutorId,
    required this.fecha,
    required this.duracion,
    required this.estado,
  });

  // Constructor de fábrica para crear una Tutoria desde un Map.
  factory Tutoria.fromMap(Map<String, dynamic> json) {
    return Tutoria(
      id: json['id'],
      tutorId: json['tutorId'],
      fecha: json['fecha'],
      duracion: json['duracion'],
      estado: json['estado'],
    );
  }

  // Método para convertir una Tutoria a un Map.
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'tutorId': tutorId,
      'fecha': fecha,
      'duracion': duracion,
      'estado': estado,
    };
  }
}
