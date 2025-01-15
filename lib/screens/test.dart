import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '💲 Evenly',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        // Handle Login
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Handle Signup
                      },
                      child: const Text('Sign-up'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 60),
            // Main Content Section
            Expanded(
              child: Row(
                children: [
                  // Left Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Less stress when sharing\nexpenses on trips.',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Keep track of your shared expenses and balances with '
                              'housemates, trips, groups, friends, and family.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Icon(Icons.flight, color: Colors.green, size: 30),
                            SizedBox(width: 10),
                            Icon(Icons.home, color: Colors.blue, size: 30),
                            SizedBox(width: 10),
                            Icon(Icons.favorite, color: Colors.red, size: 30),
                            SizedBox(width: 10),
                            Icon(Icons.star, color: Colors.grey, size: 30),
                          ],
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: null,
                          child: Text('Sign-up'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Free for web.',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  // Right Content (Image)
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        'assets/images/home_image.png', // Replace with your image path
                        height: 200,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
