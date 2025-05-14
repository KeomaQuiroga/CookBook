import 'dart:convert';

class Receta {
  final int id;
  final String title;
  final String image;
  final List<String> ingredientes;
  final List<String> instrucciones;
  final Map<String, dynamic> nutricional;

  Receta({
    this.id = 0,
    required this.title,
    this.image = '',
    required this.ingredientes,
    required this.instrucciones,
    required this.nutricional,
  });

  factory Receta.fromJson(Map<String, dynamic> json) {
    final extendedIngredients = json['extendedIngredients'] as List;
    final analyzedInstructions = json['analyzedInstructions'] as List;
    final nutrientesList = json['nutrition']['nutrients'] as List;
    final Map<String, dynamic> nutrientesMap = {
      for (var n in nutrientesList)
        n['name'] as String: n['amount'] // o cualquier campo que te interese
    };

    return Receta(
      title: json['title'],
      image: json['image'],
      ingredientes: extendedIngredients
          .map((i) => i['originalString'] ?? i['original'])
          .cast<String>()
          .toList(),
      instrucciones: analyzedInstructions.isNotEmpty
          ? (analyzedInstructions[0]['steps'] as List)
              .map((step) => step['step'] as String)
              .toList()
          : [],
      nutricional: nutrientesMap,
    );
  }

  factory Receta.fromMap(Map<String, dynamic> map) {
    final raw = map['nutricional'] as String? ?? '{}';
    final Map<String, String> nutricional = _parseIngredientsField(raw);

    final ingredientesJson = map['ingredientes'] as String? ?? '[]';
    final instruccionesJson = map['instrucciones'] as String? ?? '[]';

    return Receta(
      id: map['id'] as int? ?? 0,
      title: map['title'] as String? ?? '',
      ingredientes: (jsonDecode(ingredientesJson) as List)
          .map((e) => e as String)
          .toList(),
      instrucciones: (jsonDecode(instruccionesJson) as List)
          .map((e) => e as String)
          .toList(),
      nutricional: nutricional,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'title': title,
      'ingredientes': jsonEncode(ingredientes),
      'instrucciones': jsonEncode(instrucciones),
      'nutricional': jsonEncode(nutricional),
    };
    if (id != 0) map['id'] = id;
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
