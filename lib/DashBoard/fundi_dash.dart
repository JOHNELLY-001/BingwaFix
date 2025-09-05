import 'package:bingwa_fix/Notifications/FundiNotify.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashPage extends StatefulWidget {
  const DashPage ({super.key});

  @override
  State<DashPage> createState() => _DashPage();
}


@override
class _DashPage extends State<DashPage> {
  List<Map<String, dynamic>> _jobs = [];
  int credits = 96;
  double rating = 4.5; // Sample rating out of 5
  final notifications = 'New';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAllJobs();
  }

  Future<void> _fetchAllJobs() async {
    try {
      final response = await http.get(
        Uri.parse('https://bingwa-fix-backend.vercel.app/api/requests/available'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _jobs = List<Map<String, dynamic>>.from(data);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Network error'),
          )
      );
    }
  }

  void _showJobDetails(Map<String, dynamic> job) {
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text(job['title'] ?? 'Job Details'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Description: ${job['description'] ?? ''}"),
                Text("Location: ${job['location'] ?? ''}"),
                Text("Date: ${job['created_at'] ?? ''}"),
                SizedBox(height: 10,),
                const Text(
                  "Phone: +255 *** *** ***",
                  style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AcceptJob()));
                  },
                  child: Text('Accept Job')
              )
            ],
          );
        }
    );
  }


  Widget build(BuildContext context) {
    final fundi = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Fundi Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
        title: Text('Technician, ${fundi?['lname']}', style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Roboto', fontSize: 22,color: Colors.white),),
        automaticallyImplyLeading: false,
        // centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white,),
            onPressed: () {
              // Navigate to notifications
              Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => const FundiNotificationsPage(),
                  )
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row with Name + Badge
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'New Jobs awaits',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Row with two cards side by side
            Row(
              children: [
                // Wallet card
                Expanded(
                  child: Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '96 Credits',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // Rating card
                Expanded(
                  child: Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Text(
                            'Ratings',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Row(
                            children: const [
                              Icon(Icons.star, color: Colors.amber, size: 14),
                              Icon(Icons.star, color: Colors.amber, size: 14),
                              Icon(Icons.star, color: Colors.amber, size: 14),
                              Icon(Icons.star, color: Colors.grey, size: 14),
                              Icon(Icons.star, color: Colors.grey, size: 14),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Center(
              child: Text(
                'New Job Requests',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _jobs.isEmpty
                ? const Padding(
              padding: EdgeInsets.only(top: 200.0),
              child: Column(
                children: [
                  Icon(Icons.work_outline,
                      size: 50, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    'No new job requests available',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
                : SizedBox(
              height: 400, // 👈 give bounded height
              child: ListView.builder(
                itemCount: _jobs.length,
                itemBuilder: (context, index) {
                  final job = _jobs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(job['category'] ?? 'Job'),
                      subtitle: Text(job['location'] ?? ''),
                      trailing:
                      const Icon(Icons.arrow_forward_ios),
                      onTap: () => _showJobDetails(job),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}

class AcceptJob extends StatefulWidget {
  const AcceptJob ({super.key});

  @override
  State<AcceptJob> createState() => _AcceptJobState();
}

class _AcceptJobState extends State<AcceptJob> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text('Coming soon!')
          ],
        ),
      ),
    );
  }

}