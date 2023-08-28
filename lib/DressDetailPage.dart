import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'UpdateDressPage.dart';

class DressDetailPage extends StatefulWidget {
  DressDetailPage({required this.dressId});

  @override
  _DressDetailPageState createState() => _DressDetailPageState();
  late int dressId;
}

class _DressDetailPageState extends State<DressDetailPage> {
  Map<String, dynamic> dressDetails = {};

  Future<void> fetchDressDetails() async {
    final response = await http.get(
      Uri.parse('http://pat.infolab.ecam.be:60848/dress/${widget.dressId}'),
    );

    if (response.statusCode == 200) {
      setState(() {
        dressDetails = json.decode(response.body);
      });
    } else {
      print('Erreur lors de la récupération des détails de la robe.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDressDetails();
  }

  Future<void> _deleteDress(int dressId) async {
    final response = await http.delete(
      Uri.parse('http://pat.infolab.ecam.be:60848/dress/$dressId'),
    );

    if (response.statusCode == 200) {
      setState(() {});
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Robe supprimée'),
            content: Text('La robe a été supprimée avec succès.'),
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
    } else {
      print('Erreur lors de la suppression de la robe.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la robe'),
      ),
      body: Center(
        child: dressDetails.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (dressDetails.isNotEmpty)
                    Text('Nom: ${dressDetails['name']}'),
                  Text('Prix: ${dressDetails['price']} €'),
                  Text('Matière: ${dressDetails['material']}'),
                  Text('Taille: ${dressDetails['size']}'),
                  // Ajoutez d'autres informations si nécessaire
                  ElevatedButton(
                    onPressed: () {
                      // Appel à la fonction de suppression ici
                      _deleteDress(widget.dressId);
                    },
                    child: Text('Supprimer cette robe'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Naviguer vers la page de modification ici
                      Navigator.pushNamed(
                        context,
                        '/updateDress',
                        arguments: {'dressId': widget.dressId},
                      );
                    },
                    child: Text('Modifier cette robe'),
                  ),
                ],
              )
            : CircularProgressIndicator(), // Affiche un indicateur de chargement si les détails ne sont pas encore récupérés
      ),
    );
  }
}
