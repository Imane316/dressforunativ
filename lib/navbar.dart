import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'DressForU',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem('Robes', '/dresses', context),
                _buildNavItem('Nv robe', '/dress', context),
                _buildNavItem('Catégories', '/categories', context),
                _buildNavItem('Recherche', '/search', context),
                _buildNavItem('Contact', '/contact', context),
                _buildNavItem('Se connecter', '/login', context),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                _buildImageItem(
                    'https://images.pexels.com/photos/985635/pexels-photo-985635.jpeg?auto=compress&cs=tinysrgb&w=600'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, String route, BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildImageItem(String imageUrl) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: Image.network(
        imageUrl,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Recherche d\'une robe'),
          content: TextField(
            onChanged: (value) {
              // Mettez en œuvre votre logique de recherche ici
            },
            decoration: InputDecoration(
              hintText: 'Rechercher une robe...',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                // Mettez en œuvre la logique de recherche et de navigation ici
                // Utilisez Navigator.pushNamed pour naviguer vers la page de résultats de recherche
                Navigator.pushNamed(context, '/search');
              },
              child: Text('Rechercher'),
            ),
          ],
        );
      },
    );
  }
}
