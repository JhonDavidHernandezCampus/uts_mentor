import 'package:flutter/material.dart'; // Importa la librería Flutter
import 'package:url_launcher/url_launcher.dart';

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
      initialRoute: '/', // Ruta inicial de la aplicación.
      routes: {
        '/': (context) =>
            AuthScreen(), // Define una ruta llamada '/' que muestra AuthScreen.
        '/register': (context) => RegisterScreen(),
        '/home': (context) =>
            HomePage(), // Define una ruta llamada '/register' que muestra RegisterScreen.
      },
    );
  }
}

class AuthScreen extends StatefulWidget {
  // Define una clase llamada AuthScreen que extiende StatefulWidget.
  @override
  _AuthScreenState createState() =>
      _AuthScreenState(); // Crea el estado para AuthScreen.
}

class _AuthScreenState extends State<AuthScreen> {
  // Define el estado de AuthScreen.
  TextEditingController emailController =
      TextEditingController(); // Controlador para el campo de correo electrónico.
  TextEditingController passwordController =
      TextEditingController(); // Controlador para el campo de contraseña.
  bool isRegistered =
      false; // Variable booleana que indica si el usuario está registrado.
  bool isLoggedIn =
      false; // Variable booleana que indica si el usuario ha iniciado sesión.
  String? registeredEmail; // Almacena el correo electrónico registrado.
  String? registeredPassword; // Almacena la contraseña registrada.

  void register() async {
    // Función para registrar un usuario.
    final result = await Navigator.pushNamed(context,
        '/register'); // Abre la pantalla de registro y espera un resultado.
    if (result != null && result is Map<String, String>) {
      // Comprueba si se recibió un resultado válido.
      setState(() {
        // Actualiza el estado de la aplicación.
        isRegistered = true;
        registeredEmail =
            result['email']; // Almacena el correo electrónico registrado.
        registeredPassword =
            result['password']; // Almacena la contraseña registrada.
      });
    }
  }

  void login() {
    // Función para iniciar sesión.
    if (isRegistered) {
      // Comprueba si el usuario está registrado.
      final enteredEmail =
          emailController.text; // Obtiene el correo electrónico ingresado.
      final enteredPassword =
          passwordController.text; // Obtiene la contraseña ingresada.

      if (enteredEmail == registeredEmail &&
          enteredPassword == registeredPassword) {
        // Comprueba las credenciales.
        setState(() {
          // Actualiza el estado de la aplicación.
          isLoggedIn = true; // Marca al usuario como autenticado.
        });
      } else {
        // Credenciales incorrectas, muestra un diálogo de error.
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error de inicio de sesión'),
              content: const Text(
                  'Credenciales incorrectas. Verifica tu correo y contraseña.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cerrar'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // El usuario no está registrado, muestra un diálogo de error.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error de inicio de sesión'),
            content: const Text('Debes registrarte antes de iniciar sesión.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Método para construir la interfaz de AuthScreen.
    if (isLoggedIn) {
      // Si el usuario ha iniciado sesión, muestra la pantalla HelloWorldScreen.
      return HomePage();
    } else {
      // Si no ha iniciado sesión, muestra la pantalla de inicio de sesión o registro.
      return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Inicio de Sesión o Registro')),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                // Widget GestureDetector envuelve el contenido para detectar gestos del usuario.
                onTap: () {
                  // Cuando se toque el contenido, se ejecutará esta función anónima.
                  // Abre la URL del hipervínculo
                  launchUrl(Uri.parse(
                      "https://www.youtube.com")); // Abre la URL de Google en el navegador.
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
                width: 400, // Ancho de la imagen en píxeles.
                child: TextField(
                  controller: emailController,
                  decoration:
                      const InputDecoration(labelText: 'Correo Electrónico'),
                ),
              ),

              Container(
                width: 400, // Ancho de la imagen en píxeles.
                height: 70, // Alto de la imagen en píxeles.
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  obscureText: true, // Oculta el texto de la contraseña.
                ),
              ),

              ElevatedButton(
                onPressed: login, // Llama a la función de inicio de sesión.
                child: const Text('Iniciar Sesión'),
              ),

              const SizedBox(
                  height:
                      10), // Agrega un espacio de 20 puntos entre el TextField y el botón

              TextButton(
                onPressed: register, // Llama a la función de registro.
                child: const Text('¿No tienes una cuenta? Regístrate aquí.'),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class RegisterScreen extends StatelessWidget {
  // Define una clase llamada RegisterScreen que extiende StatelessWidget.
  @override
  Widget build(BuildContext context) {
    // Método para construir la interfaz de RegisterScreen.
    TextEditingController registerEmailController =
        TextEditingController(); // Controlador para el correo electrónico de registro.
    TextEditingController registerPasswordController =
        TextEditingController(); // Controlador para la contraseña de registro.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: registerEmailController,
              decoration:
                  const InputDecoration(labelText: 'Correo Electrónico'),
            ),
            TextField(
              controller: registerPasswordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true, // Oculta el texto de la contraseña.
            ),
            ElevatedButton(
              onPressed: () {
                final registerEmail = registerEmailController
                    .text; // Obtiene el correo electrónico ingresado.
                final registerPassword = registerPasswordController
                    .text; // Obtiene la contraseña ingresada.
                final result = {
                  'email': registerEmail,
                  'password': registerPassword
                }; // Crea un mapa con los datos de registro.
                Navigator.pop(context,
                    result); // Cierra la pantalla de registro y devuelve los datos al estado anterior.
              },
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                // Agrega tu función para manejar el toque aquí
                print('Botón de perfil tocado');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Color de fondo del botón
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize
                      .min, // Para que el Row ocupe el espacio mínimo necesario
                  children: <Widget>[
                    Icon(Icons.person,
                        color: const Color.fromARGB(
                            255, 17, 18, 19)), // Icono del usuario
                    SizedBox(
                      width: 10,
                      height: 100,
                    ), // Espacio entre el icono y el texto
                    Text('Nombre de usuario',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 24, 27,
                                29))), // Texto para el nombre del usuario
                  ],
                ),
              ),
            ),
          ),
          Center(
              child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.outbox),
          )),
        ],
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.outbox),
          ),
        ],
      ),
    );
  }
}

class HelloWorldScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('¡Hola Mundo!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centra verticalmente la columna
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centra horizontalmente la columna
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .center, // Centra horizontalmente los textos dentro del Row
              crossAxisAlignment: CrossAxisAlignment
                  .center, // Centra verticalmente los textos dentro del Row
              children: [
                Image.asset(
                  'imagenes/instagram.jpeg',
                  width: 100,
                  height: 200,
                ),
                Image.asset(
                  'imagenes/spotify.png',
                  width: 200,
                  height: 200,
                ),
              ],
            ),
            const SizedBox(height: 20), // Espacio entre las filas
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .center, // Centra horizontalmente los textos dentro del Row
              crossAxisAlignment: CrossAxisAlignment
                  .center, // Centra verticalmente los textos dentro del Row
              children: [
                GestureDetector(
                  /* child: Image.asset(
                    'imagenes/whatsapp.jpeg',
                    width: 150,
                    height: 200,
                  ) */
                  child: ButtonTheme(
                    child: const Text('data'),
                  ),
                  onTap: () {
                    print('object');
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
