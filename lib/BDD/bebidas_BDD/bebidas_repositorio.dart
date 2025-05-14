import 'package:proyecto_recetas/BDD/bebidas_BDD/data_base_bebida.dart';
import 'package:proyecto_recetas/modelo/bebida.dart';

class BebidasRepositorio {
    // Insertar un usuario
  Future<void> insertarBebida(Bebida bebida) async {
    final db = await DataBaseSqlite.instanciaBebidas.database;
    await db.insert('bebidas', bebida.toMap());
  }

  // Obtener todos los usuarios
  Future<List<Bebida>> obtenerBebida() async {
    final db = await DataBaseSqlite.instanciaBebidas.database;
    final List<Map<String, dynamic>> maps = await db.query('bebidas');
    return List.generate(maps.length, (i) {
      return Bebida.fromMap(maps[i]);
    });
  }

  // Eliminar usuario por ID
  Future<void> eliminarBebida(int id) async {
    final db = await DataBaseSqlite.instanciaBebidas.database;
    await db.delete('bebidas', where: 'id = ?', whereArgs: [id]);
  }
}