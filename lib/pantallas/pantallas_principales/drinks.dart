import 'package:flutter/material.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_recetas/pantallas/extra_information/drink_info.dart';
import 'package:proyecto_recetas/provider/bebida_provider.dart';

class DrinksSearch extends StatefulWidget {
  const DrinksSearch({super.key});

  @override
  State<DrinksSearch> createState() => _DrinksSearchState();
}

class _DrinksSearchState extends State<DrinksSearch> {
  final TextEditingController bebidaController = TextEditingController();

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
                controller: bebidaController,
                decoration: const InputDecoration(
                  labelText: 'Search for a drink',
                  labelStyle: TextStyle(color: Colors.orange),
                  suffixIcon: Icon(
                    Icons.loupe,
                    color: Colors.orange,
                  ),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepOrange)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepOrange)),
                ),
              ),
            ),
            GradientElevatedButton(
              onPressed: () async {
                final bebidaProvider =
                    Provider.of<BebidaProvider>(context, listen: false);
                final nombre = bebidaController.text.trim();

                if (nombre.isNotEmpty) {
                  try {
                    await bebidaProvider.buscarBebidaPorNombre(nombre);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DrinkScreen()),
                    );
                    bebidaController.clear();
                  } catch (e) {
                    bebidaController.clear();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('The drink was not found'),
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
                backgroundGradient: const LinearGradient(
                    colors: [Colors.orange, Colors.deepOrange]),
              ),
              child: Text(
                "Search",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 50),
            GradientElevatedButton(
              onPressed: () async {
                final bebidaProvider =
                    Provider.of<BebidaProvider>(context, listen: false);
                await bebidaProvider.bebidaAleatoria();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DrinkScreen()),
                );
              },
              style: GradientElevatedButton.styleFrom(
                backgroundGradient: const LinearGradient(
                    colors: [Colors.orange, Colors.deepOrange]),
              ),
              child: Text(
                "Random drink",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
