import 'package:bingwa_fix/Notifications/FundiNotify.dart';
import 'package:flutter/material.dart';
import 'package:bingwa_fix/DashBoard/fundi_stack.dart';
import 'package:bingwa_fix/Transactions/WalletPage.dart';

class FundiMyJobsPage extends StatefulWidget {
  const FundiMyJobsPage({super.key});

  @override
  State<FundiMyJobsPage> createState() => _FundiMyJobsPageState();
}

class _FundiMyJobsPageState extends State<FundiMyJobsPage> {
  int _selectedTabIndex = 0; // 0 = Active, 1 = Completed
  double avgRating = 4.5;

  void _onItemTapped (index) {
    setState(() {
      _selectedTabIndex = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Management'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Track and manage your accepted jobs',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueGrey,
              ),
            ),
          ),

          // Stats Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildStatCard('Active Jobs', '2'),
                const SizedBox(width: 10),
                _buildStatCard('Completed', '15'),
                const SizedBox(width: 10),
                _buildStatCard('Avg Rating', avgRating.toString()),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Filter Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => setState(() => _selectedTabIndex = 0),
                    style: TextButton.styleFrom(
                      backgroundColor: _selectedTabIndex == 0
                          ? Colors.blue[100]
                          : Colors.grey[200],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                    ),
                    child: Text(
                      'All Jobs',
                      style: TextStyle(
                        color: _selectedTabIndex == 0
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () => setState(() => _selectedTabIndex = 1),
                    style: TextButton.styleFrom(
                      backgroundColor: _selectedTabIndex == 1
                          ? Colors.blue[100]
                          : Colors.grey[200],
                    ),
                    child: Text(
                      'Active',
                      style: TextStyle(
                        color: _selectedTabIndex == 1
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () => setState(() => _selectedTabIndex = 2),
                    style: TextButton.styleFrom(
                      backgroundColor: _selectedTabIndex == 2
                          ? Colors.blue[100]
                          : Colors.grey[200],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                    ),
                    child: Text(
                      'Completed',
                      style: TextStyle(
                        color: _selectedTabIndex == 2
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Empty State
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.work_outline, size: 50, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No jobs found',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No ${_selectedTabIndex == 1 ? 'active' : 'completed'} jobs at the moment.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}