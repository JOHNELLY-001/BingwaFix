import 'package:flutter/material.dart';
import 'package:bingwa_fix/Registration/FundiRegister.dart';
import 'package:bingwa_fix/Registration/LoginPage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),
              const Center(
                child: Text(
                  'Welcome to BingwaFix',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              const Center(
                child: Text(
                  'Connecting skilled & trustworthy Fundi with customers who need their services',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              _buildServiceCard(
                title: 'I Need Services',
                subtitle: 'Find qualified technicians for your home and office repair needs',
                features: [
                  'Post service requests instantly',
                  'Get matched with verified fundis',
                  'Track job progress in real-time',
                  'Rate and review services',
                ],
                buttonText: 'Continue as Customer',
                context: context,
              ),
              const SizedBox(height: 25),
              _buildServiceCard(
                title: 'I Offer Services',
                subtitle: 'Join our network of skilled technicians and grow your business',
                features: [
                  'Access job opportunities in your area',
                  'Pay-per-lead model (1 credit per job)',
                  'Build your reputation with reviews',
                  'Manage jobs through mobile app',
                ],
                buttonText: 'Join Fundi Network',
                context: context,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String subtitle,
    required List<String> features,
    required String buttonText,
    required BuildContext context,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: features.map((feature) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle, color: Colors.blue, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          feature,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (buttonText == 'Continue as Customer') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage())
                    );
                  } else if (buttonText == 'Join Fundi Network') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FundiAuthPortal())
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueGrey,
                ),
                child: Text(buttonText,style: TextStyle(fontSize: 16),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}