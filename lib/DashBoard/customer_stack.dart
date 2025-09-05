import 'package:bingwa_fix/DashBoard/customer_dash.dart';
import 'package:bingwa_fix/Notifications/CustomerNotify.dart';
import 'package:bingwa_fix/Settings/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:bingwa_fix/JobStatus/MyRequest.dart';

class CustomerStackPage extends StatefulWidget {
  const CustomerStackPage({super.key});

  @override
  State<CustomerStackPage> createState() => _CustomerStackPageState();
}

class _CustomerStackPageState extends State<CustomerStackPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    CustomerDashboard(),
    MyRequestsPage(),
    CustomerNotifyPage(),
    SettingsPage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (Index) {
          setState(() {
            _selectedIndex = Index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'My Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

}
