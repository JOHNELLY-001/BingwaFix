import 'package:bingwa_fix/Registration/FundiLogin.dart';
import 'package:flutter/material.dart';

class FundiAuthPortal extends StatelessWidget {
  const FundiAuthPortal({super.key});


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Contact BingwaFix Offices for Registration', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,),),
            SizedBox(height: 08,),
            Text('+255 629 763 121', style: TextStyle(fontSize: 15, color: Colors.blueGrey),),
            SizedBox(height: 08,),
            Text('+255 628 729 335', style: TextStyle(fontSize: 15, color: Colors.blueGrey),),
            SizedBox(height: 08,),
            Text('fixflowinnovators@gmail.com', style: TextStyle(fontSize: 15, color: Colors.blue),),
            SizedBox(height: 100,),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FundiLoginPage()));
                },
              child: const Text('Sign In',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.white60, width: 1),
                ),
                backgroundColor: Colors.blueGrey,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
}
}