import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bingwa_fix/Registration/LoginPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _signUp() async {
    final String apiUrl = "https://bingwa-fix-backend.vercel.app/api/auth/register/";

    setState(() {
      _isLoading = true;
    });

   try {
     final response = await http.post(
       Uri.parse(apiUrl),
       headers: {"Content-Type": "application/json"},
       body: json.encode({
         "full_name": _fullNameController.text.trim(),
         "phone_number": "+255${_phoneNumberController.text.trim()}",
         "email": _emailController.text.trim(),
         "password": _passwordController.text.trim(),
       }),
     );

     setState(() {
       _isLoading = false;
     });

     if (!mounted) return; // ✅ ensures the widget is still in the tree

     if (response.statusCode == 201) {
       final data = json.decode(response.body);
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Registered successfully',
           style: TextStyle(color: Colors.white, fontSize: 16),),
           backgroundColor: Colors.green,
           behavior: SnackBarBehavior.floating,
           margin: EdgeInsets.all(12),
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(10),),
           duration: Duration(seconds: 2),
           dismissDirection: DismissDirection.horizontal,),
       );
       Navigator.pushReplacementNamed(context,
           '/login2', arguments: data['user']);
     } else {
       try {
         final error = json.decode(response.body);
         ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text('Error: ${error[error]}',
               style: TextStyle(color: Colors.white, fontSize: 16),),
               backgroundColor: Colors.black54,
               behavior: SnackBarBehavior.floating,
               margin: EdgeInsets.all(15),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(10),),
               duration: Duration(seconds: 2),
               dismissDirection: DismissDirection.horizontal,)
         );
       } catch (_) {
         ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text('Server error: ${response.statusCode}')));
       }
     }
   }  catch (e) {
     setState(() {
       _isLoading = false;
     });

  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Connection Error!')),
  );
  }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 60),
            const Text(
              'Customer Access',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Sign up to request fundi services',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    // foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Full Name',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(
                hintText: 'Enter your full name',
                hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Phone Number',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                prefixText: '+255 ',
                hintText: 'XXX XXX XXX',
                hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            const Text(
              'Password',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Create a password (min 6 characters)',
                hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isLoading ? null : _signUp,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueGrey,
              ),
              child: _isLoading ? const CircularProgressIndicator(color: Colors.blueGrey,) : const Text('Create Account', style: TextStyle(fontSize: 17),),
            ),
          ],
        ),
      ),
    );
  }
}