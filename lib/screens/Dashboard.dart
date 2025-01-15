import 'package:flutter/material.dart';
import '../models/User.dart';

class Dashboard extends StatefulWidget {
  final User loginUser;
  const Dashboard({super.key, required this.loginUser});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Dynamically create the list of screens
    final List<Widget> screens = [

      Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
              children: [
                Text(
                  'Welcome, ${widget.loginUser.name}!',
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
        ),

      ),

      const Center(
        child: Text(
          'Profile',
          style: TextStyle(fontSize: 24),
        ),
      ),
      const Center(
        child: Text(
          'Settings',
          style: TextStyle(fontSize: 24),
        ),
      ),
    ];

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
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Define action for the button
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Action'),
              content: const Text('Floating Action Button Pressed!'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.people,
          color: Colors.white,
        ),
      ),
    );
  }
}
