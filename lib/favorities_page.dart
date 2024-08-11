// lib/pages/favorites_page.dart

import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/nobi.png'),
            ),
            title: Text('Innum-Konjam-Neram.mp3'),
            subtitle: Text('Bhai nobi'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/jeva.jpeg'),
            ),
            title: Text('Netru-Aval-Irundhal.mp3'),
            subtitle: Text('Bhai jeva'),
          ),
        ],
      ),
    );
  }
}
