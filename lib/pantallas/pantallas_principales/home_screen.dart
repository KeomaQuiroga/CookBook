import 'package:flutter/material.dart';
import 'package:proyecto_recetas/pantallas/pantallas_principales/drinks.dart';
import 'package:proyecto_recetas/pantallas/pantallas_principales/favorite_drink.dart';
import 'package:proyecto_recetas/pantallas/pantallas_principales/favorite_food.dart';
import 'package:proyecto_recetas/pantallas/pantallas_principales/food.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    FoodSearch(),
    DrinksSearch(),
    FavoriteFood(),
    FavoriteDrink(), // New page added
  ];

  final List<LinearGradient> _gradients = [
    LinearGradient(colors: [Colors.green, Colors.teal]),
    LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
    LinearGradient(colors: [Colors.amberAccent, Colors.amber]),
    LinearGradient(colors: [Colors.amberAccent, Colors.amber]), // New gradient
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentGradient = _gradients[_selectedIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cook Book',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: currentGradient,
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              gradient: currentGradient,
            ),
          ),
          BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: _selectedIndex,
            onTap: _onTap,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            type: BottomNavigationBarType.fixed, // Needed for 4+ items
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.food_bank),
                label: 'Food',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_drink),
                label: 'Drinks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Fav. foods',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Fav. drinks',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
