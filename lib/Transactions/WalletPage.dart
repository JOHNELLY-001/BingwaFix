import 'package:bingwa_fix/Notifications/FundiNotify.dart';
import 'package:flutter/material.dart';
import 'package:bingwa_fix/DashBoard/fundi_stack.dart';
import 'package:bingwa_fix/JobStatus/JobManager.dart';

class FundiWalletPage extends StatefulWidget {
  const FundiWalletPage({super.key});

  @override
  State<FundiWalletPage> createState() => _FundiWalletPageState();
}

class _FundiWalletPageState extends State<FundiWalletPage> {
  int credits = 96;
  int jobsThisMonth = 12;
  int creditsSpent = 12;
  int selectedAmount = 0;
  String? selectedPaymentMethod;
  final TextEditingController _customAmountController = TextEditingController();
  bool _showTopUpSection = false;

  final List<int> quickTopUpAmounts = [10, 20, 50, 100];
  final List<String> paymentMethods = [
    'M-Pesa',
    'Airtel Money',
    'Tigo Pesa',
    'Halopesa'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        leading: Icon(Icons.arrow_back_ios),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manage your funds for job acceptance',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),

            // Wallet Balance Section
            Row(
              children: [
                const Text(
                  'Credits ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  credits.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const Text(
              'Available Balance',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Jobs this month', jobsThisMonth.toString()),
                _buildStatItem('Credits spent', creditsSpent.toString()),
                _buildStatItem('Top Up', 'Transaction History'),
              ],
            ),
            const SizedBox(height: 30),

            // Top Up Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showTopUpSection = !_showTopUpSection;
                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('+ Add Credits'),
              ),
            ),
            const SizedBox(height: 20),

            // Top Up Section (Conditional)
            if (_showTopUpSection) ...[
              const Divider(),
              const SizedBox(height: 20),
              const Text(
                'Quick top-up amounts',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Quick Top Up Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: quickTopUpAmounts.map((amount) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAmount = amount;
                        _customAmountController.text = '';
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedAmount == amount
                            ? Colors.blue[100]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: selectedAmount == amount
                              ? Colors.blue
                              : Colors.transparent,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '$amount Credits',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selectedAmount == amount
                                ? Colors.blue
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Custom Amount
              const Text(
                'Custom Amount (Credits)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _customAmountController,
                decoration: InputDecoration(
                  hintText: 'Enter credits',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      selectedAmount = int.tryParse(value) ?? 0;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),

              // Payment Method
              const Text(
                'Payment Method',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedPaymentMethod,
                hint: const Text('Select payment method'),
                items: paymentMethods.map((String method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Lead Cost Information
              Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.blue),
                  const SizedBox(width: 8),
                  const Flexible(
                    child: Text(
                      'Each job you accept costs 1 credit. Amount: ',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Text(
                    '$selectedAmount credits = $selectedAmount job opportunities',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Payment Button
              ElevatedButton(
                onPressed: selectedPaymentMethod != null && selectedAmount > 0
                    ? () {
                  // Process payment
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Proceed to Payment'),
              ),
              const SizedBox(height: 20),

              // OR Divider
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('OR'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),

              // Contact Admin Option
              OutlinedButton.icon(
                onPressed: () {
                  // Contact admin logic
                },
                icon: const Icon(Icons.email),
                label: const Text('Contact Admin for Credit Top-up'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _customAmountController.dispose();
    super.dispose();
  }
}