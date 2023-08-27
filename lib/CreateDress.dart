import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateDressPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pictureController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _materialController = TextEditingController();
  // Ajoute d'autres contrôleurs pour les champs supplémentaires

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Création de robe'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Entrez les détails de la nouvelle robe:'),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nom de la robe'),
            ),
            TextFormField(
              controller: _pictureController,
              decoration: InputDecoration(labelText: 'URL de l\'image'),
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Prix'),
            ),
            TextFormField(
              controller: _materialController,
              decoration: InputDecoration(labelText: 'Matière'),
            ),
            // Ajoute d'autres champs ici

            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Ici tu pourrais appeler une fonction pour créer la robe
                _createDress(context);
              },
              child: Text('Créer la robe'),
            ),
          ],
        ),
      ),
    );
  }

  // Cette fonction pourrait être utilisée pour créer la robe
  Future<void> _createDress(BuildContext context) async {
    // Récupérer les valeurs des contrôleurs
    String name = _nameController.text;
    String picture = _pictureController.text;
    String price = _priceController.text;
    String material = _materialController.text;
    // Récupérer d'autres champs si nécessaire

    // Afficher les valeurs récupérées dans le terminal
    print('Nom de la robe: $name');
    print('URL de l\'image: $picture');
    print('Prix: $price');
    print('Matière: $material');

    // Créer un objet Map pour représenter les données
    Map<String, dynamic> requestBody = {
      'name': name,
      'picture': picture,
      'price': price,
      'material': material,
      // Ajouter d'autres champs si nécessaire
    };

    // Convertir le Map en JSON
    String requestBodyJson = jsonEncode(requestBody);

    // Envoyer les données au backend
    final response = await http.post(
      Uri.parse('http://pat.infolab.ecam.be:60848/dress'), // L'URL de l'API
      headers: {'Content-Type': 'application/json'},
      body: requestBodyJson,
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Robe ajoutée'),
            content: Text('La robe a été ajoutée avec succès.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Ferme la boîte de dialogue
                  Navigator.pushReplacementNamed(
                      context, '/dresses'); // Redirige vers la liste des robes
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      print('Robe ajoutée avec succès');
    } else {
      print('Erreur lors de l\'ajout de la robe');
    }
  }
}
