import 'package:bingwa_fix/Notifications/FundiNotify.dart';
import 'package:flutter/material.dart';
import 'package:bingwa_fix/JobStatus/JobManager.dart';
import 'package:bingwa_fix/Transactions/WalletPage.dart';

class FundiDashboardPage extends StatefulWidget {
  const FundiDashboardPage({super.key});

  @override
  State<FundiDashboardPage> createState() => _FundiDashboardPageState();
}

class _FundiDashboardPageState extends State<FundiDashboardPage> {
  int _selectedIndex = 0; // For bottom navigation
  int credits = 96;
  double rating = 4.5; // Sample rating out of 5

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0: //Dashboard
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1,animation2) => const FundiDashboardPage(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case 1: //My Jobs
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FundiMyJobsPage(),
          ),
        );
        break;
      case 2: //Wallet
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FundiWalletPage(),
          ),
        );
        break;
      case 3: //Notifications
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const FundiNotificationsPage(),
          )
        );
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fundi Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'New job opportunities await',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Credits Card
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '96 Credits',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Wallet Balance'),
                            Text(
                              '$credits credits',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            // Top up credits
                          },
                          child: const Text('Top Up'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),

            // My Jobs Section
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Jobs',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Badge(
                  label: Text('3'),
                  child: Icon(Icons.notifications),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Rating Section
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Rating',
                          style: TextStyle(fontSize: 16),
                        ),
                        Row(
                          children: [
                            Text(
                              rating.toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text('/5', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.star, color: Colors.amber, size: 30),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // New Job Requests Section
            const Text(
              'New Job Requests',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Jobs matching your service category (Electrician) - Pay 1 credit per accepted lead',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),

            // Empty state for job requests (will be populated later)
            const Center(
              child: Column(
                children: [
                  Icon(Icons.work_outline, size: 50, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    'No new job requests available',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
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
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}