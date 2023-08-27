import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'CategoryDetailPage.dart';

class CategoryListPage extends StatefulWidget {
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<dynamic> categories = [];

  Future<void> fetchCategories() async {
    final response = await http
        .get(Uri.parse('http://pat.infolab.ecam.be:60848/categories'));

    if (response.statusCode == 200) {
      setState(() {
        categories = json.decode(response.body);
        print(response.body);
      });
    } else {
      print('Erreur lors de la récupération des catégories.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  void navigateToCategoryDetail(int catId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryDetailPage(catId: catId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catégories'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(categories[index]['name']),
              onTap: () {
                int catId = categories[index]
                    ['idcategory']; // Assurez-vous que la clé 'id' est correcte
                navigateToCategoryDetail(catId);
              },
              // Ajoute d'autres champs selon les besoins
            );
          },
        ),
      ),
    );
  }
}
