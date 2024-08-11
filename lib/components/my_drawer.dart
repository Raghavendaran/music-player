import 'package:flutter/material.dart';
import 'package:music_player/about.dart';
import 'package:music_player/favorities_page.dart';
import 'package:music_player/pages/settings_page.dart';
import 'package:music_player/profile_pagee.dart'; // Fixed the import

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900], // Dark background color for the drawer
      child: Column(
        children: [
          // Logo
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey[850], // Slightly lighter color for the header
            ),
            child: Center(
              child: Icon(
                Icons.music_note,
                size: 40,
                color: Colors.white, // White color for the icon
              ),
            ),
          ),
          // Home tile
          _buildListTile(
            context,
            title: "H O M E",
            icon: Icons.home,
            onTap: () => Navigator.pop(context),
          ),
          // Profile tile
          _buildListTile(
            context,
            title: "P R O F I L E",
            icon: Icons.person,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
          ),
          // Favorites tile
          _buildListTile(
            context,
            title: "F A V O R I T E S",
            icon: Icons.favorite,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesPage(),
                ),
              );
            },
          ),
          // Settings tile
          _buildListTile(
            context,
            title: "S E T T I N G S",
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          ),
          // About tile
          _buildListTile(
            context,
            title: "A B O U T",
            icon: Icons.info,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutPage(),
                ),
              );
            },
          ),
          // Logout tile
          _buildListTile(
            context,
            title: "L O G O U T",
            icon: Icons.logout,
            onTap: () {
              // Implement logout functionality here
              Navigator.pop(context);
              // Navigate to login screen (replace with your login screen)
              // Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, {required String title, required IconData icon, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 25),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.white), // Text color
        ),
        leading: Icon(
          icon,
          color: Colors.white, // Icon color
        ),
        onTap: onTap,
      ),
    );
  }
}
