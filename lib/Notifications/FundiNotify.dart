import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FundiNotificationsPage extends StatefulWidget {
  const FundiNotificationsPage({super.key});

  @override
  State<FundiNotificationsPage> createState() => _FundiNotificationsPageState();
}

class _FundiNotificationsPageState extends State<FundiNotificationsPage> {
  // This will be replaced with actual data fetching from your database
  final List<Map<String, dynamic>> _notifications = [
    {
      'type': 'job_request',
      'title': 'New Job Request',
      'message': 'You have a new plumbing job request in Sinza',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
      'read': false,
      'jobId': 'req_001',
    },
    {
      'type': 'job_accepted',
      'title': 'Job Accepted',
      'message': 'You accepted the electrical repair job in Kariakoo',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      'read': true,
      'jobId': 'job_045',
    },
    {
      'type': 'payment_received',
      'title': 'Payment Received',
      'message': 'TZS 25,000 received for completed job #045',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)),
      'read': true,
      'jobId': 'job_045',
    },
    {
      'type': 'rating_received',
      'title': 'New Rating',
      'message': 'You received 4.5 stars for your plumbing service',
      'timestamp': DateTime.now().subtract(const Duration(days: 2)),
      'read': false,
      'jobId': 'job_038',
    },
    {
      'type': 'system_alert',
      'title': 'System Maintenance',
      'message': 'Platform will be down for maintenance tomorrow 2AM-4AM',
      'timestamp': DateTime.now().subtract(const Duration(days: 3)),
      'read': true,
      'jobId': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
        },
            icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
            icon: const Icon(Icons.mark_as_unread),
            onPressed: _markAllAsRead,
            tooltip: 'Mark all as read',
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? const Center(
        child: Text(
          'No notifications yet',
          style: TextStyle(color: Colors.grey),
        ),
      )
          : RefreshIndicator(
        onRefresh: _refreshNotifications,
        child: ListView.builder(
          itemCount: _notifications.length,
          itemBuilder: (context, index) {
            final notification = _notifications[index];
            return _buildNotificationCard(notification);
          },
        ),
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    final icon = _getIconForType(notification['type']);
    final color = notification['read'] ? Colors.grey : Colors.blue;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          notification['title'],
          style: TextStyle(
            fontWeight: notification['read'] ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification['message']),
            const SizedBox(height: 4),
            Text(
              DateFormat('MMM dd, hh:mm a').format(notification['timestamp']),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: notification['read']
            ? null
            : const Icon(Icons.circle, color: Colors.blue, size: 8),
        onTap: () => _handleNotificationTap(notification),
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'job_request':
        return Icons.work_outline;
      case 'job_accepted':
        return Icons.thumb_up;
      case 'payment_received':
        return Icons.attach_money;
      case 'rating_received':
        return Icons.star;
      case 'system_alert':
        return Icons.warning;
      default:
        return Icons.notifications;
    }
  }

  Future<void> _refreshNotifications() async {
    // This will be replaced with actual database fetch
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['read'] = true;
      }
    });
  }

  void _handleNotificationTap(Map<String, dynamic> notification) {
    setState(() {
      notification['read'] = true;
    });

    // Handle navigation based on notification type
    switch (notification['type']) {
      case 'job_request':
      // Navigate to job details
        break;
      case 'job_accepted':
      // Navigate to active job
        break;
      case 'payment_received':
      // Navigate to wallet
        break;
      case 'rating_received':
      // Navigate to ratings
        break;
      default:
      // Do nothing for system alerts
        break;
    }
  }


}