class Mensaje {
  final int? id;
  final int emisorId;
  final int receptorId;
  final String mensaje;
  final String fecha; // Fecha en formato ISO

  Mensaje({
    this.id,
    required this.emisorId,
    required this.receptorId,
    required this.mensaje,
    required this.fecha,
  });

  // Constructor de fábrica para crear un Mensaje desde un Map.
  factory Mensaje.fromMap(Map<String, dynamic> json) {
    return Mensaje(
      id: json['id'],
      emisorId: json['emisorId'],
      receptorId: json['receptorId'],
      mensaje: json['mensaje'],
      fecha: json['fecha'],
    );
  }

  // Método para convertir un Mensaje a un Map.
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'emisorId': emisorId,
      'receptorId': receptorId,
      'mensaje': mensaje,
      'fecha': fecha,
    };
  }
}
