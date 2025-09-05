import 'package:flutter/material.dart';

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
    );
  }
}