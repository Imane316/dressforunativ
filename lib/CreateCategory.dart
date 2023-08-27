import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateCategoryPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  // Ajoute d'autres contrôleurs pour les champs supplémentaires

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Création de catégorie'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Entrez les détails de la nouvelle catégorie:'),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nom de la catégorie'),
            ),
            // Ajoute d'autres champs ici

            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Ici tu pourrais appeler une fonction pour créer la catégorie
                _createCategory(context);
              },
              child: Text('Créer la catégorie'),
            ),
          ],
        ),
      ),
    );
  }

  // Cette fonction pourrait être utilisée pour créer la catégorie
  Future<void> _createCategory(BuildContext context) async {
    // Récupérer les valeurs des contrôleurs
    String name = _nameController.text;
    // Récupérer d'autres champs si nécessaire

    // Créer un objet Map pour représenter les données
    Map<String, dynamic> requestBody = {
      'name': name,
      // Ajouter d'autres champs si nécessaire
    };

    // Convertir le Map en JSON
    String requestBodyJson = jsonEncode(requestBody);

    // Envoyer les données au backend
    final response = await http.post(
      Uri.parse('http://pat.infolab.ecam.be:60848/category'), // L'URL de l'API
      headers: {'Content-Type': 'application/json'},
      body: requestBodyJson,
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Catégorie ajoutée'),
            content: Text('La catégorie a été ajoutée avec succès.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Ferme la boîte de dialogue
                  Navigator.pushReplacementNamed(context,
                      '/categories'); // Redirige vers la liste des catégories
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      print('Catégorie ajoutée avec succès');
    } else {
      print('Erreur lors de l\'ajout de la catégorie');
    }
  }
}
