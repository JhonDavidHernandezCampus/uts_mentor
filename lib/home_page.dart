import 'package:flutter/material.dart';
import 'detalle_tutoria.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showAllTutorias = false;

  final List<Map<String, String>> tutorias = [
    {
      'nombre': 'Matemáticas',
      'valor': '50,000 COP',
      'imagen': 'imagenes/imagenesHome/matematicas.jpg',
    },
    {
      'nombre': 'Física',
      'valor': '40,000 COP',
      'imagen': 'imagenes/imagenesHome/fisica.jpg',
    },
    {
      'nombre': 'Química',
      'valor': '45,000 COP',
      'imagen': 'imagenes/imagenesHome/quimica.jpg',
    },
    {
      'nombre': 'Inglés',
      'valor': '60,000 COP',
      'imagen': 'imagenes/imagenesHome/ingles.jpg',
    },
    {
      'nombre': 'Historia',
      'valor': '35,000 COP',
      'imagen': 'imagenes/imagenesHome/historia.jpg',
    },
    {
      'nombre': 'Programación',
      'valor': '80,000 COP',
      'imagen': 'imagenes/imagenesHome/programacion.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final tutoriasMostradas = showAllTutorias
        ? tutorias
        : tutorias.sublist(0, 4); // Muestra solo 4 tutorías al inicio

    return Scaffold(
      appBar: AppBar(
        title: Text('Página de Inicio'),
      ),
      body: Column(
        children: [
          // Parte superior: Imagen
          Container(
            margin: EdgeInsets.all(3.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'imagenes/imagenesHome/banner.jpg', // Imagen banner superior
                height: 260,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Parte central: Listado de tutorías
          Expanded(
            child: ListView.builder(
              itemCount:
                  tutoriasMostradas.length + 1, // Incluye el botón "Ver más"
              itemBuilder: (context, index) {
                if (index == tutoriasMostradas.length) {
                  return showAllTutorias
                      ? SizedBox
                          .shrink() // Oculta el botón cuando ya se muestran todas las tutorías
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  showAllTutorias = true;
                                });
                              },
                              child: Text('Ver más tutorías'),
                            ),
                          ),
                        );
                }

                final tutoria = tutoriasMostradas[index];

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.lightGreenAccent,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // Imagen a la izquierda
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(50), // Borde redondeado
                            child: Image.asset(
                              tutoria['imagen']!,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16.0),

                          // Nombre de la tutoría en el centro
                          Expanded(
                            child: Text(
                              tutoria['nombre']!,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // Botón de chat y valor de la tutoría a la derecha
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.chat_bubble_outline),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/chat');
                                },
                              ),
                              Text(tutoria['valor']!),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      // Botón "Ver detalle"
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TutoriaDetallePage(
                                  nombre: tutoria['nombre']!,
                                  valor: tutoria['valor']!,
                                  imagen: tutoria['imagen']!,
                                ),
                              ),
                            );
                          },
                          child: Text('Ver detalle'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Parte inferior: Sección verde con botones de usuario, agregar y menú
          Container(
            color: Colors.green, // Color verde para la sección inferior
            height: 70, // Altura de la sección
            width: double.infinity, // Ocupar todo el ancho
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, // Distribuye los botones uniformemente
              children: <Widget>[
                // Botón para los datos del usuario
                IconButton(
                  icon: Icon(Icons.person,
                      color: Colors.white, size: 40), // Icono de usuario
                  onPressed: () {
                    // Redirigir a la página de perfil
                    Navigator.pushNamed(context, '/profile');
                  },
                ),

                // Botón para agregar una tutoría
                IconButton(
                  icon: Icon(Icons.add,
                      color: Colors.white, size: 40), // Icono de más
                  onPressed: () {
                    // Acción para agregar una tutoría
                    Navigator.pushNamed(context, '/addtutoria');
                    // Aquí puedes redirigir a la página para agregar una tutoría o abrir un diálogo
                  },
                ),

                // Botón de menú
                IconButton(
                  icon: Icon(Icons.menu,
                      color: Colors.white,
                      size: 40), // Icono de menú (tres líneas horizontales)
                  onPressed: () {
                    // Acción del botón de menú
                    print('Menú tocado');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
