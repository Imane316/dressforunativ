import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryDetailPage extends StatefulWidget {
  final int catId;

  CategoryDetailPage({required this.catId});

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  Map<String, dynamic> categoryDetails = {};

  Future<void> fetchCategoryDetails() async {
    final response = await http.get(
      Uri.parse('http://pat.infolab.ecam.be:60848/category/${widget.catId}'),
    );

    if (response.statusCode == 200) {
      setState(() {
        categoryDetails = json.decode(response.body);
      });
    } else {
      print('Erreur lors de la récupération des détails de la robe.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCategoryDetails();
  }

  Future<void> _deleteCategory(int catId) async {
    final response = await http.delete(
      Uri.parse('http://pat.infolab.ecam.be:60848/category/$catId'),
    );

    if (response.statusCode == 200) {
      setState(() {});
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Catégorie supprimée'),
            content: Text('La catégorie a été supprimée avec succès.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Ferme la boîte de dialogue
                  Navigator.pushReplacementNamed(context,
                      '/categories'); // Redirige vers la liste des robes
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      print('Erreur lors de la suppression de la catégorie.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la catégorie'),
      ),
      body: Center(
        child: categoryDetails.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Nom: ${categoryDetails['name']}'),

                  // Ajoutez d'autres informations si nécessaire
                  ElevatedButton(
                    onPressed: () {
                      // Appel à la fonction de suppression ici
                      _deleteCategory(widget.catId);
                    },
                    child: Text('Supprimer cette catégorie'),
                  )
                ],
              )
            : CircularProgressIndicator(), // Affiche un indicateur de chargement si les détails ne sont pas encore récupérés
      ),
    );
  }
}
