import 'package:flutter/material.dart';

void main() => runApp(MiAplicacion());

class MiAplicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PerfilPage(),
    );
  }
}

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UTS MENTOR'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.purple),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightGreenAccent, Colors.greenAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('imagenes/Profile.png'),
            ),
            SizedBox(height: 10),
            Text(
              'STIVEN MARTINEZ VILLAMIZAR',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              'smartinezv@uts.edu.co',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                infoCard('Jornada', 'NOCTURNA'),
                infoCard('Situación', 'ACTIVO'),
                infoCard('Categoría', 'ANTIGUO'),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Text(
                    'TECNOLOGÍA EN DESARROLLO DE SISTEMAS INFORMÁTICOS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Text(
                    'Programa',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BusquedaTutoriasPage()),
                    );
                  },
                  child: actionIcon(Icons.book, 'Tutorías'),
                ),
                SizedBox(width: 50),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HorarioPage()),
                    );
                  },
                  child: actionIcon(Icons.schedule, 'Horario'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget infoCard(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(fontSize: 14, color: Colors.black45),
          ),
          Text(
            subtitle.toUpperCase(),
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget actionIcon(IconData iconData, String label) {
    return Column(
      children: [
        Icon(iconData, size: 40, color: Colors.black87),
        SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.black87)),
      ],
    );
  }
}


class BusquedaTutoriasPage extends StatefulWidget {
  @override
  _BusquedaTutoriasPageState createState() => _BusquedaTutoriasPageState();
}

class _BusquedaTutoriasPageState extends State<BusquedaTutoriasPage> {
  String filtroSeleccionado = 'Todas'; // Filtro por tipo

  List<Map<String, String>> tutorias = [
    {'materia': 'Álgebra', 'tutor': 'Prof. Pérez', 'tipo': 'Comprada'},
    {'materia': 'Matemáticas Discretas', 'tutor': 'Prof. Gómez', 'tipo': 'Agendada'},
    {'materia': 'Cálculo Integral', 'tutor': 'Prof. Ramírez', 'tipo': 'Comprada'},
    {'materia': 'Electromagnetismo', 'tutor': 'Prof. Fernández', 'tipo': 'Agendada'},
    {'materia': 'Finanzas', 'tutor': 'Prof. Rodríguez', 'tipo': 'Comprada'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Búsqueda de Tutorías")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Dropdown para filtrar por tipo
                DropdownButton<String>(
                  value: filtroSeleccionado,
                  items: <String>['Todas', 'Comprada', 'Agendada']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      filtroSeleccionado = value!; // Actualiza filtro
                    });
                  },
                ),
              ],
            ),
          ),

          // Lista de tutorías filtradas
          Expanded(
            child: ListView(
              children: tutorias
                  .where((tutoria) {
                    // Aplicar filtro de tipo
                    final matchFiltro = filtroSeleccionado == 'Todas' || 
                                        tutoria['tipo'] == filtroSeleccionado;
                    return matchFiltro; // Coincide con el filtro seleccionado
                  })
                  .map((tutoria) {
                    return ListTile(
                      leading: Icon(Icons.person),
                      title: Text('${tutoria['materia']} - ${tutoria['tutor']}'),
                      subtitle: Text('Tipo: ${tutoria['tipo']}'),
                      trailing: Icon(Icons.chat),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}



//PAGINA HORARIO


class HorarioPage extends StatefulWidget {
  @override
  _HorarioPageState createState() => _HorarioPageState();
}

class _HorarioPageState extends State<HorarioPage> {
  String filtroSeleccionado = 'Horario Agendadas';

  // Datos para los dos horarios
  List<DataRow> horarioAgendadas = [
    DataRow(cells: [
      DataCell(Text("8:00-10:00")),
      DataCell(Text("Álgebra\nProf. Pérez")),
      DataCell(Text("Cálculo Integral\nProf. Ramírez")),
      DataCell(Text("Electromagnetismo\nProf. Fernández")),
      DataCell(Text("Matemáticas Discretas\nProf. Gómez")),
      DataCell(Text("Finanzas\nProf. Rodríguez")),
      DataCell(Text("Libre")),
    ]),
    DataRow(cells: [
      DataCell(Text("10:00-12:00")),
      DataCell(Text("Matemáticas Discretas\nProf. Gómez")),
      DataCell(Text("Electromagnetismo\nProf. Fernández")),
      DataCell(Text("Álgebra\nProf. Pérez")),
      DataCell(Text("Finanzas\nProf. Rodríguez")),
      DataCell(Text("Cálculo Integral\nProf. Ramírez")),
      DataCell(Text("Libre")),
    ]),
    // Más filas aquí...
  ];

  List<DataRow> horarioTutor = [
    DataRow(cells: [
      DataCell(Text("8:00-10:00")),
      DataCell(Text("Tutoría Álgebra")),
      DataCell(Text("Tutoría Cálculo Integral")),
      DataCell(Text("Electromagnetismo")),
      DataCell(Text("Libre")),
      DataCell(Text("Libre")),
      DataCell(Text("Libre")),
    ]),
    DataRow(cells: [
      DataCell(Text("10:00-12:00")),
      DataCell(Text("Matemáticas Discretas")),
      DataCell(Text("Electromagnetismo")),
      DataCell(Text("Álgebra")),
      DataCell(Text("Libre")),
      DataCell(Text("Libre")),
      DataCell(Text("Libre")),
    ]),
    // Más filas aquí...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Horario")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: filtroSeleccionado,
              items: <String>['Horario Tutor', 'Horario Agendadas']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  filtroSeleccionado = value!;
                });
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text("Hora")),
                  DataColumn(label: Text("Lunes")),
                  DataColumn(label: Text("Martes")),
                  DataColumn(label: Text("Miércoles")),
                  DataColumn(label: Text("Jueves")),
                  DataColumn(label: Text("Viernes")),
                  DataColumn(label: Text("Sábado")),
                ],
                rows: filtroSeleccionado == 'Horario Tutor'
                    ? horarioTutor
                    : horarioAgendadas,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
