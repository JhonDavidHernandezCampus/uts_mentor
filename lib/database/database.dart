import 'package:uts_mentor/database/class/tutor.dart';
import 'package:uts_mentor/database/class/tutoria.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const String dbName = 'chat.db';

  static const String userTable = 'usuario'; // Tabla de usuarios
  static const String messageTable = 'mensajes'; // Tabla de mensajes
  static const String tutoriasTable = 'tutorias'; // Tabla de tutorías

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  void _createDatabase(Database db, int version) async {
    // Crear tabla usuario
    await db.execute('''
      CREATE TABLE $userTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT,
        apellidos TEXT,
        email TEXT,
        cedula TEXT,
        area TEXT,
        password TEXT,
        rol TEXT
      )
    ''');
    // rol TEXT

    // Crear tabla mensajes
    await db.execute('''
      CREATE TABLE $messageTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        emisorId INTEGER,
        receptorId INTEGER,
        mensaje TEXT,
        fecha TEXT,
        FOREIGN KEY (emisorId) REFERENCES $userTable(id),
        FOREIGN KEY (receptorId) REFERENCES $userTable(id)
      )
    ''');

    // Crear tabla tutorías
    await db.execute('''
      CREATE TABLE $tutoriasTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tutorId INTEGER,
        fecha TEXT,
        duracion INTEGER,
        estado TEXT,
        FOREIGN KEY (tutorId) REFERENCES $userTable(id)
      )
    ''');
  }

  // Métodos CRUD para usuarios
  Future<int> insertUsuario(Usuario usuario) async {
    final db = await database;
    return await db.insert(userTable, usuario.toMap());
  }

  Future<List<Usuario>> getUsuarios() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(userTable);
    return List.generate(result.length, (index) {
      return Usuario.fromMap(result[index]);
    });
  }

  // Métodos para mensajes
  Future<int> sendMessage(int emisorId, int receptorId, String mensaje) async {
    final db = await database;
    return await db.insert(messageTable, {
      'emisorId': emisorId,
      'receptorId': receptorId,
      'mensaje': mensaje,
      'fecha': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getMessages(int userId) async {
    final db = await database;
    return await db.query(messageTable,
        where: 'emisorId = ? OR receptorId = ?', whereArgs: [userId, userId]);
  }

  // CRUD para tutorías
  Future<int> createTutoria(Tutoria tutoria) async {
    final db = await database;
    return await db.insert(tutoriasTable, tutoria.toMap());
  }

  Future<List<Tutoria>> getTutorias() async {
    final db = await database;
    final List<Map<String, dynamic>> tutoriasMap =
        await db.query(tutoriasTable);
    return List.generate(tutoriasMap.length, (index) {
      return Tutoria.fromMap(tutoriasMap[index]);
    });
  }

  Future<int> updateTutoriaEstado(int id, String nuevoEstado) async {
    final db = await database;
    return await db.update(tutoriasTable, {'estado': nuevoEstado},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteTutoria(int id) async {
    final db = await database;
    return await db.delete(tutoriasTable, where: 'id = ?', whereArgs: [id]);
  }
}
