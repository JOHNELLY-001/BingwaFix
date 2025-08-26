import 'dart:convert';
import 'package:bingwa_fix/Notifications/CustomerNotify.dart';
import 'package:bingwa_fix/Settings/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:bingwa_fix/DashBoard/CustomerDash.dart';

class MyRequestsPage extends StatefulWidget {
  const MyRequestsPage({super.key});

  @override
  State<MyRequestsPage> createState() => _MyRequestsPageState();
}

class _MyRequestsPageState extends State<MyRequestsPage> {
  int _selectedFilterIndex = 0;
  final List<String> _filterOptions = ['All', 'Pending', 'Active', 'Done'];
  List<Map<String, dynamic>> _requests = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Fetch requests after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (user != null) {
        _fetchRequests(user['id']);
      }
    });
  }

  Future<void> _fetchRequests(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('https://bingwa-fix-backend.vercel.app/api/requests/user/$userId'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _requests = List<Map<String, dynamic>>.from(data['requests']);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load requests');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
      case 'in_progress':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredRequests = _requests.where((req) {
      switch (_selectedFilterIndex) {
        case 1:
          return req['status'] == 'pending';
        case 2:
          return req['status'] == 'in_progress' || req['status'] == 'accepted';
        case 3:
          return req['status'] == 'completed';
        default:
          return true;
      }
    }).toList();

    final user = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'My Requests',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Track your service requests',
              style: TextStyle(fontSize: 17, color: Colors.blueGrey),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _filterOptions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: FilterChip(
                    label: Text(_filterOptions[index]),
                    selected: _selectedFilterIndex == index,
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedFilterIndex = selected ? index : 0;
                      });
                    },
                    selectedColor: Colors.blue[100],
                    checkmarkColor: Colors.blue,
                    labelStyle: TextStyle(
                      color: _selectedFilterIndex == index ? Colors.blue : Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: _selectedFilterIndex == index ? Colors.blue : Colors.grey[300]!,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredRequests.isEmpty
                ? const Center(
              child: Text(
                'No requests to show',
                style: TextStyle(color: Colors.grey),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredRequests.length,
              itemBuilder: (context, index) {
                final req = filteredRequests[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              req['category'] ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _statusColor(req['status']),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                req['status']?.toUpperCase() ?? '',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          req['description'] ?? '',
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Location: ${req['location'] ?? ''}',
                              style: const TextStyle(fontSize: 14, color: Colors.black87),
                            ),
                            Text(
                              'Date: ${req['preferred_date'] != null ? DateFormat('MMM dd, yyyy').format(DateTime.parse(req['preferred_date'])) : ''}',
                              style: const TextStyle(fontSize: 14, color: Colors.black87),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Time: ${req['preferred_time'] ?? ''}',
                          style: const TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Highlight the My Requests tab
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'My Requests'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CustomerHomePage(), settings: RouteSettings(arguments: {"id": user?['id']}) ),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
            MaterialPageRoute(builder: (context) => CustomerNotifyPage(),));
          } else if (index == 3) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage(),));
          }
        },
      ),
    );
  }
}
