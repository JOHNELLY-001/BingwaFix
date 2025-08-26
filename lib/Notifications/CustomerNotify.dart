import 'package:bingwa_fix/JobStatus/MyRequest.dart';
import 'package:flutter/material.dart';
import 'package:bingwa_fix/DashBoard/CustomerDash.dart';
import 'package:bingwa_fix/Settings/SettingsPage.dart';

class CustomerNotifyPage extends StatefulWidget {
  const CustomerNotifyPage({super.key});

  @override
  State<CustomerNotifyPage> createState() => _CustomerNotifyPage();
}

class _CustomerNotifyPage extends State<CustomerNotifyPage> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications',style: TextStyle(fontSize: 25),),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(16.0),
          child: Text('Coming soon!'),),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'My requests'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blue,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CustomerHomePage() ),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyRequestsPage(),));
          } else if (index == 3) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage(),));
          }
        },
      ),
    );
  }
}