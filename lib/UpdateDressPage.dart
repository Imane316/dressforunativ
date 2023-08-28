import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'DressDetailPage.dart';

class UpdateDressPage extends StatefulWidget {
  late int dressId;

  UpdateDressPage({required this.dressId});

  @override
  _UpdateDressPageState createState() => _UpdateDressPageState();
}

class _UpdateDressPageState extends State<UpdateDressPage>
    with AutomaticKeepAliveClientMixin {
  late int dressId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null && args.containsKey('dressId')) {
      dressId = args['dressId'];
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _materialController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  String _message = '';

  @override
  bool get wantKeepAlive => true;

  Future<void> _fetchDressDetails() async {
    try {
      final response = await http.get(
        Uri.parse('http://pat.infolab.ecam.be:60848/dress/${widget.dressId}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final dress = jsonDecode(response.body);
        _nameController.text = dress['name'];
        _priceController.text = dress['price'];
        _materialController.text = dress['material'];
        _sizeController.text = dress['size'];
      } else {
        setState(() {
          _message = 'Error loading dress details';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Error loading dress details: $e';
      });
    }
  }

  Future<void> _updateDress() async {
    try {
      final response = await http.put(
        Uri.parse('http://pat.infolab.ecam.be:60848/dress/${widget.dressId}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': _nameController.text,
          'price': _priceController.text,
          'material': _materialController.text,
          'size': _sizeController.text,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _message = 'Dress updated successfully';
        });
      } else {
        setState(() {
          _message = 'Error updating dress';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Error updating dress: $e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchDressDetails();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Modification des données'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nom';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Prix';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _materialController,
                  decoration: InputDecoration(labelText: 'Material'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Matière';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _sizeController,
                  decoration: InputDecoration(labelText: 'Size'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Taille';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _updateDress();
                      Navigator.of(context).pop(); // Ferme la boîte de dialogue
                      Navigator.pushReplacementNamed(context, '/dresses');
                    }
                  },
                  child: Text('Update Dress'),
                ),
                if (_message.isNotEmpty) SizedBox(height: 16),
                Text(
                  _message,
                  style: TextStyle(color: Colors.green, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}










/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DressEditPage extends StatefulWidget {
  final int dressId;

  DressEditPage({required this.dressId});

  @override
  _DressEditPageState createState() => _DressEditPageState();
}

class _DressEditPageState extends State<DressEditPage> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _materialController;
  late TextEditingController _sizeController;

  Map<String, dynamic> dressDetails = {};

  @override
  void initState() {
    super.initState();
    fetchDressDetails();
  }

  Future<void> fetchDressDetails() async {
    final response = await http.get(
      Uri.parse('http://pat.infolab.ecam.be:60848/dress/${widget.dressId}'),
    );

    if (response.statusCode == 200) {
      final dressData = json.decode(response.body);
      setState(() {
        dressDetails = dressData;
        _nameController = TextEditingController(text: dressDetails['name']);
        _priceController = TextEditingController(text: dressDetails['price']);
        _materialController =
            TextEditingController(text: dressDetails['material']);
        _sizeController = TextEditingController(text: dressDetails['size']);
      });
    } else {
      print('Erreur lors de la récupération des détails de la robe.');
    }
  }

  Future<void> _updateDress() async {
    final updatedData = {
      'name': _nameController.text,
      'price': _priceController.text,
      'material': _materialController.text,
      'size': _sizeController.text,
      // Ajoutez d'autres champs si nécessaire
    };

    final response = await http.put(
      Uri.parse('http://pat.infolab.ecam.be:60848/dress/${widget.dressId}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedData),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context); // Revenir à la page précédente
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Robe modifiée'),
            content: Text('La robe a été modifiée avec succès.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Ferme la boîte de dialogue
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      print('Erreur lors de la modification de la robe.');
    }
  }

  // Ajoutez ici les champs de modification et la logique pour mettre à jour les attributs de la robe

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier la robe'),
      ),
      body: Center(
        child: dressDetails.isNotEmpty
            ? Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Nom'),
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(labelText: 'Prix'),
                  ),
                  TextFormField(
                    controller: _materialController,
                    decoration: InputDecoration(labelText: 'Matière'),
                  ),
                  TextFormField(
                    controller: _sizeController,
                    decoration: InputDecoration(labelText: 'Taille'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Mettez en œuvre la logique de mise à jour et d'envoi au backend ici
                      _updateDress();
                    },
                    child: Text('Sauvegarder'),
                  ),
                ],
              )
            : CircularProgressIndicator(),

        // Affichez ici les champs de modification et les boutons de sauvegarde/annulation
      ),
    );
  }
}
*/