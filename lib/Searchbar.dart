import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchTerm = '';
  Map<String, dynamic>? dress;
  String message = '';

  Future<void> search() async {
    final response = await http.get(
      Uri.parse('http://pat.infolab.ecam.be:60848/dress/name/$searchTerm'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);

      setState(() {
        if (jsonData.isNotEmpty) {
          dress = jsonData;
          print(dress);
          message = '';
        } else {
          dress = null;
          message = "Essaye un autre nom";
        }
      });
    } else {
      print('Erreur lors de la recherche de la robe.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recherche de robe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  print('ok');
                  searchTerm = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Rechercher une robe...",
              ),
            ),
            ElevatedButton(
              onPressed: search,
              child: Text("Rechercher"),
            ),
            Text(message),
            if (dress != null)
              Column(
                children: [
                  Text(dress!['name']),
                  //Image.network(dress!['picture']),
                  Text("Price: ${dress!['price']}"),
                  Text("Material: ${dress!['material']}"),
                  Text("Size: ${dress!['size']}"),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
