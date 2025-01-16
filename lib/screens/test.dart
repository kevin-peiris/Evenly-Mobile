import 'package:flutter/material.dart';
import '../models/User.dart';

class Dashboard extends StatelessWidget {
  final User loginUser;

  const Dashboard({super.key, required this.loginUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '💲 Evenly',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: Row(
        children: [
          // Groups Sidebar
          Container(
            width: 200,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'GROUPS',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 10),
                ...['Family', 'Office', 'Office Trip Nuwara']
                    .map(
                      (group) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        group,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
                    .toList(),
              ],
            ),
          ),

          // Dashboard Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dashboard Heading
                  const Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Balance Cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBalanceCard('Total Balance', '-\$9,400.00',
                          Colors.red, Colors.red.shade50),
                      _buildBalanceCard(
                          'You Owe', '\$31,900.00', Colors.red, Colors.red.shade50),
                      _buildBalanceCard('You Are Owed', '\$22,500.00',
                          Colors.green, Colors.green.shade50),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // You Owe Section
                  const Text(
                    'YOU OWE',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildOweRow('Kevin Peiris', 'You owe \$7,200.00', Colors.red),
                  _buildOweRow('Nadeeka Alwis', 'You owe \$14,000.00', Colors.red),
                  const SizedBox(height: 20),

                  // You Are Owed Section
                  const Text(
                    'YOU ARE OWED',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildOweRow('Kamal Perera', 'owes you \$2,000.00', Colors.green),
                  _buildOweRow('Namal Perera', 'owes you \$2,000.00', Colors.green),
                  _buildOweRow('Rashmi Senanayake', 'owes you \$4,000.00',
                      Colors.green),
                  _buildOweRow('Mahesh Kumara', 'owes you \$3,800.00', Colors.green),
                ],
              ),
            ),
          ),

          // Guide Section
          Container(
            width: 200,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Guide',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 10),
                ...[
                  'Create Groups and add Friends to share Expenses.',
                  'Track shared expenses and keep everyone informed.',
                  'Easily settle balances among group members.',
                  'Monitor payments made by group members in real time.',
                  'Invite friends to join and collaborate on group expenses.',
                ].map(
                      (guide) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      guide,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Create new Group'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(
      String title, String amount, Color color, Color bgColor) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            amount,
            style: TextStyle(
              fontSize: 18,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOweRow(String name, String detail, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$name - $detail',
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
