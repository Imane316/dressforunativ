import 'package:flutter/material.dart';
import 'CreateCategory.dart';
import 'navbar.dart';
import 'dresslist.dart';
import 'Searchbar.dart';
import 'categories.dart';
import 'CreateDress.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dress For U',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Navbar(),
      routes: {
        //'/dresses': (context) => DressListPage(),
        '/dress': (context) => CreateDressPage(),
        '/dresses': (context) => DressListPage(),
        '/categories': (context) => CategoryListPage(),
        '/category': (context) => CreateCategoryPage(),
        '/search': (context) => SearchPage(),
        /*'/search': (context) => SearchPage(), // Ajoutez cette ligne pour la route de recherche*/

        // Autres routes...
      },
    );
  }
}
