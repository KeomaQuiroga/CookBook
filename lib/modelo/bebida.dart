import 'dart:convert';

class Bebida {
  final int idDrink;
  final String strDrink;
  final String strDrinkThumb;
  final String strAlcoholic;
  final String strGlass;
  final String strInstructions;
  final Map<String, String> ingredientsWithMeasure;

  Bebida({
    this.idDrink = 0,
    required this.strDrink,
    this.strDrinkThumb = '',
    required this.strAlcoholic,
    this.strGlass = '',
    required this.strInstructions,
    required this.ingredientsWithMeasure,
  });

  factory Bebida.fromJson(Map<String, dynamic> json) {
    final Map<String, String> ingredients = {};
    for (int i = 1; i <= 15; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      if (ingredient != null && ingredient.toString().isNotEmpty) {
        ingredients[ingredient] = measure ?? '';
      }
    }

    return Bebida(
      strDrink: json['strDrink'],
      strDrinkThumb: json['strDrinkThumb'],
      strAlcoholic: json['strAlcoholic'],
      strGlass: json['strGlass'],
      strInstructions: json['strInstructions'],
      ingredientsWithMeasure: ingredients,
    );
  }

  factory Bebida.fromMap(Map<String, dynamic> map) {
    final raw = map['ingredientes'] as String? ?? '{}';
    final Map<String, String> ingredientsWithMeasure =
        _parseIngredientsField(raw);

    return Bebida(
      idDrink: map['id'] as int? ?? 0,
      strDrink: map['titulo'] as String? ?? '',
      strInstructions: map['instrucciones'] as String? ?? '',
      strAlcoholic: map['alcohol'] as String? ?? '',
      ingredientsWithMeasure: ingredientsWithMeasure,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'titulo': strDrink,
      'ingredientes': jsonEncode(ingredientsWithMeasure),
      'instrucciones': strInstructions,
      'alcohol': strAlcoholic,
    };
    if (idDrink != 0) map['id'] = idDrink;
    return map;
  }
}

Map<String, String> _parseIngredientsField(String raw) {
  raw = raw.trim();
  if (raw.startsWith('{') && raw.contains(':')) {
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.map((k, v) => MapEntry(k, v.toString()));
  }
  final regExp = RegExp(r'([^=,{}]+)=([^,{}]+)');
  final matches = regExp.allMatches(raw);
  return Map.fromEntries(
    matches.map(
      (m) {
        final key = m.group(1)!.trim();
        final value = m.group(2)!.trim();
        return MapEntry(key, value);
      },
    ),
  );
}
