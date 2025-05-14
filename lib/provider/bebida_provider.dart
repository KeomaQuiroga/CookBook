import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_recetas/BDD/bebidas_BDD/bebidas_repositorio.dart';
import 'package:proyecto_recetas/modelo/bebida.dart';

class BebidaProvider extends ChangeNotifier {
  List<Bebida> _favoritas = []; //bebidas favorritas
  List<Bebida> get favoritos => _favoritas;

  final BebidasRepositorio bebidasRepositorio = BebidasRepositorio();

  Bebida? bebida;

  //metodos API
  Future<void> bebidaAleatoria() async {
    final url =
        Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/random.php');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      bebida = Bebida.fromJson(data['drinks'][0]);
      notifyListeners();
    } else {
      throw Exception('Error charging the drink');
    }
  }

  Future<void> buscarBebidaPorNombre(String nombre) async {
    final url = Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$nombre');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['drinks'] != null && data['drinks'].isNotEmpty) {
        bebida = Bebida.fromJson(data['drinks'][0]);
        notifyListeners();
      } else {
        throw Exception('No drink found with that name');
      }
    } else {
      throw Exception('Error searching the drink');
    }
  }

  //metodos BDD
  BebidaProvider() {
    _cargarFavoritosDesdeBD();
  }
  Future<void> _cargarFavoritosDesdeBD() async {
    _favoritas = await bebidasRepositorio.obtenerBebida();
    notifyListeners();
  }

  Future<void> agregarBebida(Bebida nuevo) async {
    await bebidasRepositorio.insertarBebida(nuevo);
    await _cargarFavoritosDesdeBD();
  }

  Future<void> eliminarBebida(int id) async {
    await bebidasRepositorio.eliminarBebida(id);
    await _cargarFavoritosDesdeBD();
  }

  bool isFavorite(Bebida b) => _favoritas.any((f) => f.idDrink == b.idDrink);
}
