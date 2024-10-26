import 'package:flutter/material.dart'; // Importa la librería Flutter
import 'package:url_launcher/url_launcher.dart';
import 'package:uts_mentor/database/chat.dart';
import 'package:uts_mentor/database/class/tutor.dart';
import 'package:uts_mentor/database/database.dart';
import 'home_page.dart';
import 'PerfilPage.dart';
import 'TutoriasPage.dart';
import 'dataLocalUser.dart';

void main() {
  runApp(
      MyApp()); // Llama a la función runApp para iniciar la aplicación Flutter.
}

class MyApp extends StatelessWidget {
  // Define una clase llamada MyApp que extiende StatelessWidget.
  @override
  Widget build(BuildContext context) {
    // Define el método build para construir la interfaz de la aplicación.
    return MaterialApp(
      title: 'Mi Aplicación', // Título de la aplicación.
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors
            .blue, // Configura el tema de la aplicación con un color azul.
      ),
      initialRoute:
          '/', // La ruta inicial de la app será la pantalla de autenticación.
      routes: {
        '/': (context) => AuthScreen(),
        // '/': (context) => HomePage(),
        '/home': (context) =>
            HomePage(), // Redirige a la pagina de inicio en el home_page.dart
        '/register': (context) => RegisterScreen(),
        '/chat': (context) => ChatPage(),
        '/profile': (context) => PerfilPage(),
        '/addtutoria': (context) => TutoriasPage()
      },
    );
  }
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoggedIn = false;

  void login() async {
    final enteredEmail = emailController.text;
    final enteredPassword = passwordController.text;

    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> result = await db.query(
      DatabaseHelper.userTable,
      where: 'email = ?',
      whereArgs: [enteredEmail],
    );

    print(result);
    // saveUserData(id, nombre, email)

    if (result.isNotEmpty) {
      final user = Usuario.fromMap(result.first);

      print(user);
      saveUserData(user.id.toString(), user.nombre, user.email);

      // Aquí puedes agregar tu lógica de cifrado si la contraseña está cifrada.
      if (user.password == enteredPassword) {
        setState(() {
          isLoggedIn = true;
        });
        // Redirigir a la página de inicio
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        showErrorDialog('Contraseña incorrecta.');
      }
    } else {
      showErrorDialog('El correo electrónico no está registrado.');
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error de inicio de sesión'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Inicio de Sesión o Registro')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse("https://www.youtube.com"));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Image.asset(
                  'imagenes/logoMentor.jpg',
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 400,
              child: TextField(
                controller: emailController,
                decoration:
                    const InputDecoration(labelText: 'Correo Electrónico'),
              ),
            ),
            Container(
              width: 400,
              height: 70,
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
            ),
            ElevatedButton(
              onPressed: login,
              child: const Text('Iniciar Sesión'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('¿No tienes una cuenta? Regístrate aquí.'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  final TextEditingController registerNombreController =
      TextEditingController();
  final TextEditingController registerApellidosController =
      TextEditingController();
  final TextEditingController registerCedulaController =
      TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();
  final TextEditingController registerAreaController = TextEditingController();
  final TextEditingController registerRolController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 10), // Padding for the form
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Registro de Usuario',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 57, 150, 53),
                ),
              ),
              const SizedBox(height: 20), // Space between title and fields
              TextField(
                controller: registerNombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: registerApellidosController,
                decoration: InputDecoration(
                  labelText: 'Apellidos',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: registerCedulaController,
                decoration: InputDecoration(
                  labelText: 'Cédula',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: registerEmailController,
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: registerPasswordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                obscureText: true,
              ),
              const SizedBox(height: 15),
              TextField(
                controller: registerAreaController,
                decoration: InputDecoration(
                  labelText: 'Area',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              /*  const SizedBox(height: 15),
              TextField(
                controller: registerRolController,
                decoration: InputDecoration(
                  labelText: 'Rol (tutor/estudiante/ambos)',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ), */
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () async {
                  final usuario = Usuario(
                      nombre: registerNombreController.text,
                      apellidos: registerApellidosController.text,
                      email: registerEmailController.text,
                      cedula: registerCedulaController.text,
                      area: registerAreaController.text,
                      password: registerPasswordController.text,
                      // rol: registerRolController.text ,
                      rol: 'estudiante');
                  // Insertar en la base de datos
                  await DatabaseHelper().insertUsuario(usuario);

                  Navigator.pop(context); // Regresar a la pantalla de login
                },
                child: const Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
