import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/User.dart';
import '../util/Routes.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "";
  String password = "";

  late DatabaseReference db;

  @override
  void initState() {
    super.initState();
    db = FirebaseDatabase.instance.ref().child("users");
  }

  void _showAlert(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _login() async {
    // try {
    //   if (email.isEmpty || password.isEmpty) {
    //     _showAlert("Incomplete Information", "Please fill all the fields.");
    //     return;
    //   }
    //
    //   final snapshot = await db.get();
    //
    //   if (!snapshot.exists) {
    //     _showAlert("Error", "No users found.");
    //     return;
    //   }
    //
    //   final Map<dynamic, dynamic> usersData = snapshot.value as Map<dynamic, dynamic>;
    //   final List<User> users = usersData.values.map((data) {
    //     return User.fromJson(data);
    //   }).toList();
    //
    //   //bool userFound = false;
    //   User? userFound;
    //
    //   for (var user in users) {
    //     if(user.email == email.trim() && user.password == password.trim()){
    //       userFound=user;
    //     }
    //   }
    //
    //   if (userFound!=null) {
    //     _showAlert("Success", "Logged in successfully!");
    //     print('Success, Logged in successfully!');
        Navigator.pushNamed(
          context,
          AppRoutes.dashboard,
          //arguments: userFound,
          arguments: new User(id: 101, name: 'name', email: 'email', password: 'password')
        );

    //   } else {
    //     _showAlert("Error", "Invalid email or password.");
    //     print('Error, Invalid email or password.');
    //   }
    // } catch (error) {
    //   _showAlert("Error", "Failed to login: $error");
    //   print('Error, Failed to login: $error');
    // }
  }

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
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Please Log in',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 30),

              // Email Input
              TextField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Email address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 15),
                ),
              ),
              const SizedBox(height: 20),

              // Password Input
              TextField(
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 15),
                ),
              ),
              const SizedBox(height: 10),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Forgot Password action
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Log In Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
