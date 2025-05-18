import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_recetas/pantallas/pantallas_principales/home_screen.dart';
import 'package:proyecto_recetas/provider/bebida_provider.dart';
import 'package:proyecto_recetas/provider/receta_provider.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BebidaProvider()),
        ChangeNotifierProvider(create: (_) => RecetaProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
