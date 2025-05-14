import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_recetas/provider/receta_provider.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recetaProvider = Provider.of<RecetaProvider>(context);
    final receta = recetaProvider.receta;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                receta!.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
              IconButton(
                onPressed: () {
                  if (recetaProvider.isFavorite(receta)) {
                    recetaProvider.eliminarComida(receta.id);
                  } else {
                    recetaProvider.agregarComida(receta);
                  }
                },
                icon: Icon(
                  Icons.star,
                  color: recetaProvider.isFavorite(receta)
                      ? Colors.yellow
                      : Colors.white,
                ),
              )
            ],
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.teal],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Image.network(
                    receta.image,
                    height: 250,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Ingredients:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...receta.ingredientes.map(
              (e) => Text("• $e"),
            ),
            SizedBox(height: 10),
            Text(
              'Instructions:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...receta.instrucciones.map(
              (e) => Text("- $e"),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Nutritional information:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                ...receta.nutricional.entries.take(5).map(
                      (e) => Text(
                        '• ${e.value} ${e.key}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
