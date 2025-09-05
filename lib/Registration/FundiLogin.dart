import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FundiLoginPage extends StatefulWidget{
  const FundiLoginPage({super.key});

  State<FundiLoginPage> createState() => _FundiLoginPageState();
}

class _FundiLoginPageState extends State<FundiLoginPage>{
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true; // initial state (password hidden)
  bool _isLoading = false;

  Future<void> _login() async {
    final String apiUrl = "https://bingwa-fix-backend.vercel.app/api/auth/loginfundi/";

    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "email": _emailController.text.trim(),
        "password": _passwordController.text.trim(),
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return; // ✅ ensures the widget is still in the tree

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logged in successfully'))
      );
      Navigator.pushReplacementNamed(context, '/fundi_dashboard', arguments: data['fundi']);
    } else {
      final error = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${error[error]}'))
      );

    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // add a form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'BingwaFix Technician',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Email field
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password field with toggle icon
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: _isLoading ? null
                  : () {
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                  ),
                  child: _isLoading ? const CircularProgressIndicator(color:  Colors.blue,) : const  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}