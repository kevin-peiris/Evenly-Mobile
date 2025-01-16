import 'package:evenly/models/Group.dart';
import 'package:firebase_database/firebase_database.dart';
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

  List<User> currentUsers=[];

  int groupId= 0;
  String groupName= "";
  List<User> groupMembers=[];

  late DatabaseReference db;

  @override
  void initState() {
    super.initState();
    db = FirebaseDatabase.instance.ref();
  }

  Future<void> loadData() async {
    var userSnapshot = await db.child("users").get();

    if (userSnapshot.exists) {
      final Map<dynamic, dynamic> usersData = userSnapshot.value as Map<dynamic, dynamic>;
      final List<User> users = usersData.values.map((data) {
        return User.fromJson(data);
      }).toList();

      currentUsers=users;
    }
  }

  Future<void> createGroup() async {
    final User loginUser=widget.loginUser;

    try{
      var groupSnapshot = await db.child("groups").get();

      if (groupSnapshot.exists) {
        final Map<dynamic, dynamic> groupData = groupSnapshot.value as Map<dynamic, dynamic>;
        final List<Group> groups = groupData.values.map((data) {
          return Group.fromJson(data);
        }).toList();

        groupId=groups.last.id+1;
      }

      final group = {
        "id":groupId,
        "name": groupName,
        "admin": loginUser,
        "members": groupMembers,
      };

      print(group);

      // db.child("groups").push().set(group).then((_) {
      //   showAlert("Success", "Group created successfully!");
      // });

    }catch(error){
      showAlert("Error", "Failed create group: $error");
    }

  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void showAlert(String title, String content) {
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



  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, ${widget.loginUser.name}!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.black45,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildBalanceCard('Total Balance', '-\$9,400.00',
                          Colors.red, Colors.red.shade50),
                      const SizedBox(height: 10),
                      _buildBalanceCard('You Owe', '\$31,900.00', Colors.red,
                          Colors.red.shade50),
                      const SizedBox(height: 10),
                      _buildBalanceCard('You Are Owed', '\$22,500.00',
                          Colors.green, Colors.green.shade50),
                    ],
                  ),
              ),

              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                  ],
                ),
              )
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
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Create a new Group'),
              content: const Text(
                  'Create Groups and add Friends to share Expenses.'),
              actions: [
                TextButton(
                  onPressed: (createGroup),
                  child: const Text('Create'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
          loadData();
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.people,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildBalanceCard(
      String title, String amount, Color color, Color bgColor) {

    return Container(

      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: color),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$title $amount',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
