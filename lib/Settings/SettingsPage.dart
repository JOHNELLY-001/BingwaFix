import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();

}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.blueGrey),
            ),
            onTap: () {},
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: const Text('sw/en'),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.blueGrey),
            ),
            onTap: () {},
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.blueGrey),
            ),
          ),
          const Divider (),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.blueGrey),
            ),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, '/landing', (Route<dynamic> route) => false);
            },
          )
        ],
      ),
    );
}

}