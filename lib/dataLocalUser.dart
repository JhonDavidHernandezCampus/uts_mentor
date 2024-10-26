import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUserData(String id, String nombre, String email) async {
  final prefs = await SharedPreferences.getInstance();

  // Guardar los datos en SharedPreferences
  await prefs.setString('id', id);
  await prefs.setString('nombre', nombre);
  await prefs.setString('email', email);
}

// Llama a esta función después de la autenticación
// saveUserData(usuario.nombre, usuario.email);

Future<Map<String, String?>> getUserData() async {
  final prefs = await SharedPreferences.getInstance();

  String? id = prefs.getString('id');
  String? nombre = prefs.getString('nombre');
  String? email = prefs.getString('email');

  return {
    'id': id,
    'nombre': nombre,
    'email': email,
  };
}



// Para usar los datos:
//getUserData().then((userData) {
//  print('Nombre del usuario: ${userData['nombre']}');
//  print('Email del usuario: ${userData['email']}');
//});