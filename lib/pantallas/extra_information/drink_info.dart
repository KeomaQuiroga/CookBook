import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_recetas/provider/bebida_provider.dart';

class DrinkScreen extends StatelessWidget {
  const DrinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bebidaProvider = Provider.of<BebidaProvider>(context);
    final bebida = bebidaProvider.bebida;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                bebida!.strDrink,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
              IconButton(
                onPressed: () {
                  if (bebidaProvider.isFavorite(bebida)) {
                    bebidaProvider.eliminarBebida(bebida.idDrink);
                  } else {
                    bebidaProvider.agregarBebida(bebida);
                  }
                },
                icon: Icon(
                  Icons.star,
                  color: bebidaProvider.isFavorite(bebida)
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
              colors: [Colors.orange, Colors.deepOrange],
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
                    bebida.strDrinkThumb,
                    height: 250,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: 'Alcohol: ',
                style: TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: bebida.strAlcoholic,
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: 'Glass Type: ',
                style: TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: bebida.strGlass,
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Ingredients:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...bebida.ingredientsWithMeasure.entries.map(
              (e) => Text('• ${e.value} ${e.key}'),
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: 'Instructions:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: bebida.strInstructions,
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
