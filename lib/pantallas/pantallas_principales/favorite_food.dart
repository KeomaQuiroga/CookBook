import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_recetas/modelo/receta.dart';
import 'package:proyecto_recetas/provider/receta_provider.dart';

class FavoriteFood extends StatelessWidget {
  const FavoriteFood({super.key});

  @override
  Widget build(BuildContext context) {
    final recProvider = Provider.of<RecetaProvider>(context);
    List<Receta> favoritos = recProvider.favoritos;

    return Expanded(
      child: ListView.builder(
        itemCount: favoritos.length,
        itemBuilder: (context, index) {
          final fav = favoritos[index];
          return Card(
            child: ExpansionTile(
              title: Text(
                fav.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => recProvider.eliminarComida(fav.id),
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
              children: [
                ...fav.nutricional.entries.take(5).map(
                      (e) => Text(
                        '• ${e.value} ${e.key}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text.rich(
                    TextSpan(
                      text: 'Ingredients:\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: fav.ingredientes.join('\n'),
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text.rich(
                    TextSpan(
                      text: 'Instructions:\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: fav.instrucciones.join('\n'),
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
