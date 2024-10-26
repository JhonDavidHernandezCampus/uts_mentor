class Usuario {
  final int? id;
  final String nombre;
  final String apellidos;
  final String cedula;
  final String email;
  final String area;
  final String password;
  final String rol; // Puede ser 'tutor', 'estudiante' o 'ambos'

  Usuario({
    this.id,
    required this.nombre,
    required this.apellidos,
    required this.cedula,
    required this.email,
    required this.area,
    required this.password,
    required this.rol,
  });

  factory Usuario.fromMap(Map<String, dynamic> json) {
    return Usuario(
      id: json["id"],
      nombre: json["nombre"],
      email: json["email"],
      apellidos: json["apellidos"],
      cedula: json["cedula"],
      area: json["area"],
      password: json["password"],
      rol: json["rol"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) "id": id,
      "nombre": nombre,
      "apellidos": apellidos,
      'email': email,
      "cedula": cedula,
      "area": area,
      "password": password,
      "rol": rol
    };
  }
}
