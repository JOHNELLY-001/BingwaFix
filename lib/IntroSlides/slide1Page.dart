import 'package:bingwa_fix/Home/LandingPage.dart';
import 'package:flutter/material.dart';

class Slide1Page extends StatelessWidget {
  const Slide1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.build_circle_outlined, size: 70.0,color: Colors.white,),
                SizedBox(height: 10,),
                Text('BINGWAFIX', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600, color: Colors.white),),
                SizedBox(height: 350,),
                Text('Trusted Link To Skilled and Reliable Fundis',style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0, color: Colors.white)),
                SizedBox(height: 20,),
                Text('Anytime, Anywhere', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0, color: Colors.white))
              ],
            ),
        ),
      ),
      bottomNavigationBar: Padding(padding: const EdgeInsets.all(25.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.white,
        ),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandingPage()));
          },
          child: Text('Get started',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blueGrey),)
      ),
      ),
    );
  }
}