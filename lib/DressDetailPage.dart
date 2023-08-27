import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DressDetailPage extends StatefulWidget {
  final int dressId;

  DressDetailPage({required this.dressId});

  @override
  _DressDetailPageState createState() => _DressDetailPageState();
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
                  Text('Nom: ${dressDetails['name']}'),
                  Text('Prix: ${dressDetails['price']} €'),
                  Text('Matière: ${dressDetails['material']}'),
                  Text('Taille: ${dressDetails['size']}'),
                  // Ajoutez d'autres informations si nécessaire
                ],
              )
            : CircularProgressIndicator(), // Affiche un indicateur de chargement si les détails ne sont pas encore récupérés
      ),
    );
  }
}
