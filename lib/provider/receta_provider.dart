import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_recetas/BDD/comida_BDD/comida_repositorio.dart';
import 'package:proyecto_recetas/modelo/receta.dart';

class RecetaProvider extends ChangeNotifier {
  List<Receta> _favoritasCom = []; //bebidas favorritas
  List<Receta> get favoritos => _favoritasCom;

  final RecetasRepositorio recetaRepositorio = RecetasRepositorio();

  Receta? receta;
  final String _apiKey = dotenv.env['3f22fcd59aa44534a072541f515022a5'] ?? '';

  //metodos API
  Future<void> recetaAleatoria() async {
    final url = Uri.parse(
        'https://api.spoonacular.com/recipes/random?number=1&includeNutrition=true&apiKey=$_apiKey');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      receta = Receta.fromJson(data['recipes'][0]);
      notifyListeners();
    } else {
      throw Exception('Error charging the recipe');
    }
  }

  Future<void> buscarRecetas(String nombre) async {
    final searchUrl =
        Uri.parse('https://api.spoonacular.com/recipes/complexSearch'
            '?query=$nombre&number=1&apiKey=$_apiKey');
    final searchRes = await http.get(searchUrl);
    if (searchRes.statusCode == 200) {
      final searchData = jsonDecode(searchRes.body);
      final id = searchData['results'][0]['id'];
      final infoUrl =
          Uri.parse('https://api.spoonacular.com/recipes/$id/information'
              '?includeNutrition=true&apiKey=$_apiKey');
      final infoRes = await http.get(infoUrl);
      if (infoRes.statusCode == 200) {
        final infoData = jsonDecode(infoRes.body);
        receta = Receta.fromJson(infoData);
        notifyListeners();
      } else {
        throw Exception('Error fetching recipe information');
      }
    } else {
      throw Exception('Error searching for recipe');
    }
  }

  //metodos BDD
  RecetaProvider() {
    _cargarFavoritosDesdeBD();
  }
  Future<void> _cargarFavoritosDesdeBD() async {
    _favoritasCom = await recetaRepositorio.obtenerComida();
    notifyListeners();
  }

  Future<void> agregarComida(Receta nuevo) async {
    await recetaRepositorio.insertarComida(nuevo);
    await _cargarFavoritosDesdeBD();
  }

  Future<void> eliminarComida(int id) async {
    await recetaRepositorio.eliminarComida(id);
    await _cargarFavoritosDesdeBD();
  }

  bool isFavorite(Receta r) => _favoritasCom.any((f) => f.id == r.id);
}
