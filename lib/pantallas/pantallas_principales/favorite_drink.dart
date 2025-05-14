import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_recetas/modelo/bebida.dart';
import 'package:proyecto_recetas/provider/bebida_provider.dart';

class FavoriteDrink extends StatelessWidget {
  const FavoriteDrink({super.key});

  @override
  Widget build(BuildContext context) {
    final bebProvider = Provider.of<BebidaProvider>(context);
    List<Bebida> favoritos = bebProvider.favoritos;

    return Expanded(
      child: ListView.builder(
        itemCount: favoritos.length,
        itemBuilder: (context, index) {
          final fav = favoritos[index];
          return Card(
            child: ExpansionTile(
              title: Text(
                fav.strDrink,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(fav.strAlcoholic),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => bebProvider.eliminarBebida(fav.idDrink),
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
              children: [
                Text(
                  "Ingredients",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                ...fav.ingredientsWithMeasure.entries.map(
                  (e) => Text(
                    '• ${e.value} ${e.key}',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text.rich(
                    TextSpan(
                      text: 'Instructions:\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: fav.strInstructions.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
