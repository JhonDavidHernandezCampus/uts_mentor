import 'package:flutter/material.dart';

class TutoriaDetallePage extends StatefulWidget {
  final String nombre;
  final String valor;
  final String imagen;
 

  TutoriaDetallePage({required this.nombre, required this.valor, required this.imagen});

  @override
  _TutoriaDetallePageState createState() => _TutoriaDetallePageState();
}

class _TutoriaDetallePageState extends State<TutoriaDetallePage> {
  bool isAgendada = false; // Estado para controlar si la tutoría está agendada

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de ${widget.nombre}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen de la tutoría
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                widget.imagen,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),

            // Recuadro con fondo lima y bordes curvos para los detalles y el botón
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.lightGreenAccent, // Color de fondo lima
                borderRadius: BorderRadius.circular(15), // Bordes redondeados
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Detalles de la tutoría
                  Text(
                    widget.nombre,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Valor: ${widget.valor}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 30),

                  // Botón de "Agendar" o "Agendada"
                  ElevatedButton.icon(
                    icon: isAgendada
                        ? Icon(Icons.check, color: Colors.white)
                        : Icon(Icons.schedule, color: Colors.white),
                    label: Text(isAgendada ? 'Agendada' : 'Agendar'),
                    onPressed: () {
                      setState(() {
                        isAgendada = true; // Cambiar el estado a "Agendada"
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isAgendada ? Colors.green : Colors.blue, // Cambiar el color del botón
                      minimumSize: Size(double.infinity, 50), // Hacer el botón ancho
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}