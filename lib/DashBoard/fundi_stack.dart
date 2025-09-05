import 'package:bingwa_fix/DashBoard/Dash.dart';
import 'package:bingwa_fix/Notifications/FundiNotify.dart';
import 'package:bingwa_fix/Settings/SettingsPage2.dart';
import 'package:flutter/material.dart';
import 'package:bingwa_fix/JobStatus/JobManager.dart';
import 'package:bingwa_fix/Transactions/WalletPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FundiDashboardPage extends StatefulWidget {
  const FundiDashboardPage({super.key});

  @override
  State<FundiDashboardPage> createState() => _FundiDashboardPageState();
}

class _FundiDashboardPageState extends State<FundiDashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DashPage(),
    FundiMyJobsPage(),
    FundiWalletPage(),
    SettingsPage2(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),


      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'My Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      );
  }
}

