import 'package:flutter/material.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_recetas/pantallas/extra_information/food_info.dart';
import 'package:proyecto_recetas/provider/receta_provider.dart';

class FoodSearch extends StatefulWidget {
  const FoodSearch({super.key});

  @override
  State<FoodSearch> createState() => _FoodSearchState();
}

class _FoodSearchState extends State<FoodSearch> {
  final TextEditingController comidaControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: comidaControler,
                decoration: const InputDecoration(
                  labelText: 'Search for a food',
                  labelStyle: TextStyle(color: Colors.green),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  suffixIcon: Icon(
                    Icons.loupe,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            GradientElevatedButton(
              onPressed: () async {
                final recetaProvider =
                    Provider.of<RecetaProvider>(context, listen: false);
                final nombre = comidaControler.text.trim();

                if (nombre.isNotEmpty) {
                  try {
                    await recetaProvider.buscarRecetas(nombre);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FoodScreen()),
                    );
                    comidaControler.clear();
                  } catch (e) {
                    comidaControler.clear();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('The food was not found'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
              style: GradientElevatedButton.styleFrom(
                backgroundGradient:
                    const LinearGradient(colors: [Colors.green, Colors.teal]),
              ),
              child: Text(
                "Search",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 50),
            GradientElevatedButton(
              onPressed: () async {
                final recetaProvider =
                    Provider.of<RecetaProvider>(context, listen: false);
                await recetaProvider.recetaAleatoria();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FoodScreen()),
                );
              },
              style: GradientElevatedButton.styleFrom(
                backgroundGradient:
                    const LinearGradient(colors: [Colors.green, Colors.teal]),
              ),
              child: Text(
                "Random food",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
