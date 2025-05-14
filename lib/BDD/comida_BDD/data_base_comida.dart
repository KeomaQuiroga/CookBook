import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseSqliteComida {
  //Tipo static permite acceder a _instance sin crear una nueva instancia de DataBaseSqlite.
  static final DataBaseSqliteComida instanciaComida =
      DataBaseSqliteComida._internal();
  static Database? basedatosComida;

//factory devuelve la única instancia de DataBaseSqlite, Si llamas varias veces a DataBaseSqlite(), obtendrás siempre la misma instancia
  factory DataBaseSqliteComida() => instanciaComida;
  DataBaseSqliteComida._internal(); //_internal() es un constructor privado (va de la mano con factory - patron singleton) que evita que otras clases creen instancias de DataBaseSqlite directamente.

  // Getter para Obtener la Base de Datos
  Future<Database> get database async {
    if (basedatosComida != null) return basedatosComida!;
    basedatosComida = await _initDB();
    return basedatosComida!;
  }

//Abrir o Inicializar la Base de Datos:
  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'comida.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE comida (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          ingredientes TEXT,
          instrucciones TEXT,
          nutricional TEXT
        )
      ''');
    });
  }
}
