import 'package:proyecto_recetas/BDD/comida_BDD/data_base_comida.dart';
import 'package:proyecto_recetas/modelo/receta.dart';

class RecetasRepositorio {
  // Insertar un usuario
  Future<void> insertarComida(Receta receta) async {
    final db = await DataBaseSqliteComida.instanciaComida.database;
    await db.insert('comida', receta.toMap());
  }

  // Obtener todos los usuarios
  Future<List<Receta>> obtenerComida() async {
    final db = await DataBaseSqliteComida.instanciaComida.database;
    final List<Map<String, dynamic>> maps = await db.query('comida');
    return List.generate(maps.length, (i) {
      return Receta.fromMap(maps[i]);
    });
  }

  // Eliminar usuario por ID
  Future<void> eliminarComida(int id) async {
    final db = await DataBaseSqliteComida.instanciaComida.database;
    await db.delete('comida', where: 'id = ?', whereArgs: [id]);
  }
}
