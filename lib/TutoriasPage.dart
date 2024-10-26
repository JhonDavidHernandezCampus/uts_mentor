import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Tutorías',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: TutoriasPage(),
    );
  }
}

class TutoriasPage extends StatefulWidget {
  @override
  _TutoriasPageState createState() => _TutoriasPageState();
}

class _TutoriasPageState extends State<TutoriasPage> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos del formulario
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  TextEditingController cedulaController = TextEditingController();
  TextEditingController newCriptoController = TextEditingController();
  TextEditingController rolController = TextEditingController();
  TextEditingController tutorIdController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  TextEditingController duracionController = TextEditingController();
  TextEditingController estadoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UTS MENTOR"),
        backgroundColor: const Color.fromARGB(255, 6, 150, 18),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildTextField(nombreController, "Nombre", Icons.person),
              _buildTextField(apellidosController, "Apellidos", Icons.person_outline),
              _buildTextField(cedulaController, "Cédula", Icons.badge),
              _buildTextField(newCriptoController, "Cripto", Icons.monetization_on),
              _buildTextField(rolController, "Rol (Estudiante/Tutor)", Icons.school),
              _buildTextField(tutorIdController, "Tutor ID", Icons.card_membership),
              _buildTextField(fechaController, "Fecha (DD/MM/AAAA)", Icons.calendar_today),
              _buildTextField(duracionController, "Duración (minutos)", Icons.timer),
              _buildTextField(estadoController, "Estado", Icons.check_circle_outline),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tutoría creada exitosamente')),
                    );
                  }
                },
                child: Text("Guardar Tutoría"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 8, 8, 8),  // Color de fondo del botón
                  foregroundColor: Colors.white,  // Color del texto cambiado a blanco
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para crear los campos de texto
  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese $label';
          }
          return null;
        },
      ),
    );
  }
}
