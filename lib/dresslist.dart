import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'DressDetailPage.dart';

class DressListPage extends StatefulWidget {
  @override
  _DressListPageState createState() => _DressListPageState();
}

class _DressListPageState extends State<DressListPage> {
  List<dynamic> dresses = [];

  Future<void> fetchDresses() async {
    final response =
        await http.get(Uri.parse('http://pat.infolab.ecam.be:60848/dresses'));

    if (response.statusCode == 200) {
      setState(() {
        dresses = json.decode(response.body);
        print(response.body);
      });
    } else {
      print('Erreur lors de la récupération des robes.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDresses();
  }

  void navigateToDressDetail(int dressId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DressDetailPage(dressId: dressId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Robes'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: dresses.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(dresses[index]['name']),
              onTap: () {
                int dressId = dresses[index]
                    ['iddress']; // Assurez-vous que la clé 'id' est correcte
                navigateToDressDetail(dressId);
              },
              // Ajoute d'autres champs selon les besoins
            );
          },
        ),
      ),
    );
  }
}
