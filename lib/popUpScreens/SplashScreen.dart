import 'package:bingwa_fix/IntroSlides/slide1Page.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const Slide1Page(),));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.build_circle_outlined,
                size: 120,
                color: Colors.black,
              ),
              SizedBox(height: 21,),
              Text("BingwaFix",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800,color: Colors.black),)
            ],
          ),
        )
    );
  }
}