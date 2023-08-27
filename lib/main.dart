import 'package:dressforunativ/CreateDress.dart';
//import 'package:dressforunativ/Searchbar.dart';
import 'package:flutter/material.dart';
import 'navbar.dart';
import 'dresslist.dart';
import 'Searchbar.dart';

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
        '/search': (context) => SearchPage(),
        /*'/search': (context) => SearchPage(), // Ajoutez cette ligne pour la route de recherche*/

        // Autres routes...
      },
    );
  }
}
