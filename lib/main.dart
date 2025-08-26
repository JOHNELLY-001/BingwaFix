import 'package:bingwa_fix/Home/LandingPage.dart';
import 'package:flutter/material.dart';
import 'package:bingwa_fix/popUpScreens/SplashScreen.dart';
import 'package:bingwa_fix/Registration/LoginPage.dart';
import 'package:bingwa_fix/Registration/SignUpPage.dart';
import 'package:bingwa_fix/DashBoard/CustomerDash.dart';
import 'package:bingwa_fix/Registration/LoginPage2.dart';



void main() {
  runApp(const FundiConnectApp());
}

class FundiConnectApp extends StatelessWidget {
  const FundiConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FundiConnect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/login2': (context) => const LoginPage2(),
        '/signup': (context) => const SignUpPage(),
        '/landing': (context) => const LandingPage(),
        '/customer_dashboard': (context) => const CustomerHomePage(),
      },
    );
  }
}

