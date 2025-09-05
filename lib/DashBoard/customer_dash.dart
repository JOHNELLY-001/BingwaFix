import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bingwa_fix/JobStatus/MyRequest.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // For GoogleMap, LatLng, CameraPosition, GoogleMapController
import 'package:geolocator/geolocator.dart'; // For Geolocator, Position, LocationPermission, LocationAccuracy
// import 'package:permission_handler/permission_handler.dart'; // For checking/requesting permissions


class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboard();
}

class _CustomerDashboard extends State<CustomerDashboard> {
  String? _selectedCategory;
  final TextEditingController _problemController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;


  final List<String> _serviceCategories = [
    'Plumbing',
    'Electrical',
    'Carpentry',
    'Painting',
    'AC Repair',
    'Electronics Repair',
    'Masonry'
  ];

  GoogleMapController ? mapController;
  LatLng ? currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _submitRequest(Map<String, dynamic> user) async {
    if (_selectedCategory == null ||
        _problemController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _selectedDate == null ||
        _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields'),
          backgroundColor: Colors.black54,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
          duration:Duration(seconds: 2),
          dismissDirection: DismissDirection.horizontal,),
      );
      return;
    }


    final apiUrl = "https://bingwa-fix-backend.vercel.app/api/requests";

    final requestBody = {
      "user_id": user["id"], // <-- From login response
      "category": _selectedCategory,
      "description": _problemController.text.trim(),
      "location": _locationController.text.trim(),
      "preferred_date": DateFormat('yyyy-MM-dd').format(_selectedDate!),
      "preferred_time": _selectedTime!.format(context),
      "phone": "+255 ${_phoneController.text.trim()}",
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestBody),
      );

      if (!mounted) return; // ✅ ensures the widget is still in the tree

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request submitted succefully'),
            backgroundColor: Colors.lightGreen,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
            duration:Duration(seconds: 2),
            dismissDirection: DismissDirection.up,),
        );

        if (!mounted) return; // ✅ ensures the widget is still in the tree

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MyRequestsPage(),
                settings: RouteSettings(arguments: {"id": user['id']})
            )
        );
      } else {
        final error = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${error["message"] ?? "Failed"}'),
            backgroundColor: Colors.black54,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
            duration:Duration(seconds: 2),
            dismissDirection: DismissDirection.horizontal,),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
          duration:Duration(seconds: 2),
          dismissDirection: DismissDirection.horizontal,),
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    //   Check permssion
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    //   Get current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });

    mapController?.animateCamera(
      CameraUpdate.newLatLng(currentLocation!),
    );

  }


  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Hello, ${user?['full_name']}', style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Roboto', fontSize: 22),),
        centerTitle: false,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, size: 35,), color: Colors.white,
            onPressed: () {
              // Navigate to notifications
            },
          ),
        ],
      ),
      body:  SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tell us what you need and we\'ll connect you with the right Fundi.',
              style: TextStyle(fontSize: 15, color: Colors.blueGrey),
            ),
            const SizedBox(height: 24),
            const Text(
              'Service Request Details',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Provide as much detail as possible for better matching',
              style: TextStyle(fontSize: 14, color: Colors.blueGrey),
            ),
            const SizedBox(height: 16),
            const Text(
              'Service Category',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              hint: const Text('Select the type of service needed', style: TextStyle(color: Colors.blueGrey, fontSize: 14),),
              items: _serviceCategories.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Problem Description',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _problemController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText:
                'Describe a short problem decription in details.',
                hintStyle: TextStyle(
                    fontSize: 14, color: Colors.blueGrey
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Location',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                  hintText: '(e.g: Ubungo-Riverside)',
                  hintStyle: TextStyle(
                      fontSize: 14, color: Colors.blueGrey
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: ElevatedButton(onPressed: () async { await _getCurrentLocation();
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      child: SizedBox(
                        height: 300,
                        child: currentLocation == null?
                        const Center(child: CircularProgressIndicator(),) :
                        GoogleMap(
                          initialCameraPosition: CameraPosition(target: currentLocation!, zoom: 15,),
                          myLocationEnabled: true, myLocationButtonEnabled: true,
                        ),
                      ),
                    ),
                  );
                  },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 06),
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Use current location", style: TextStyle(fontSize: 13),),
                  )
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Preferred Date & Time',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _selectDate(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      foregroundColor: Colors.blueGrey,
                    ),
                    child: Text(
                      _selectedDate == null
                          ? 'Pick a date'
                          : DateFormat('MMM dd, yyyy').format(_selectedDate!),
                      style: TextStyle(fontSize: 15,),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _selectTime(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      foregroundColor: Colors.blueGrey,
                    ),
                    child: Text(
                      _selectedTime == null
                          ? 'Pick time'
                          : _selectedTime!.format(context),
                      style: TextStyle(fontSize: 15,),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Contacts',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                prefixText: '+255 ',
                hintText: 'XXX XXX XXX',
                hintStyle: TextStyle(
                  fontSize: 14, color: Colors.blueGrey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _submitRequest(user ?? {} ),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueGrey
              ),
              child: const Text('Submit Request', style: TextStyle(fontSize: 18),),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _problemController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}