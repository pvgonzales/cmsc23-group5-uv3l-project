import 'package:flutter/material.dart';
import 'package:flutter_project/screens/donations/donation.dart';
import 'package:flutter_project/screens/user_profile/user_profile_screen.dart';
import 'package:flutter_project/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 83, 14, 14),
            ),
          ),
          ListTile(
            title: Text('My Donations'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DonationsScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              context.read<UserAuthProvider>().authService.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
