import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseSqlite {
  //Tipo static permite acceder a _instance sin crear una nueva instancia de DataBaseSqlite.
  static final DataBaseSqlite instanciaBebidas = DataBaseSqlite._internal();
  static Database? basedatosBebidas;

//factory devuelve la única instancia de DataBaseSqlite, Si llamas varias veces a DataBaseSqlite(), obtendrás siempre la misma instancia
  factory DataBaseSqlite() => instanciaBebidas;
  DataBaseSqlite._internal(); //_internal() es un constructor privado (va de la mano con factory - patron singleton) que evita que otras clases creen instancias de DataBaseSqlite directamente.

  // Getter para Obtener la Base de Datos
  Future<Database> get database async {
    if (basedatosBebidas != null) return basedatosBebidas!;
    basedatosBebidas = await _initDB();
    return basedatosBebidas!;
  }

//Abrir o Inicializar la Base de Datos:
  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'bebidas.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE bebidas (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          titulo TEXT,
         ingredientes TEXT,
          instrucciones TEXT,
          alcohol TEXT
        )
      ''');
    });
  }
}
