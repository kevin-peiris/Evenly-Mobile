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
  int selectedIndex = 0;
  TextEditingController groupController = TextEditingController();
  List<User> currentUsers = [];
  List<Group> currentGroups = [];

  int groupId = 0;
  String groupName = "";
  List<User> groupMembers = [];

  late DatabaseReference db;

  @override
  void initState() {
    super.initState();
    db = FirebaseDatabase.instance.ref();
    loadData();
  }

  Future<void> loadData() async {
    final User loginUser = widget.loginUser;

    try {
      final usersSnapshot = await db.child("users").get();
      final groupsSnapshot = await db.child("groups").get();

      if (!usersSnapshot.exists) {
        showAlert("Error", "No users found.");
        return;
      }

      final Map<dynamic, dynamic> usersData =
          usersSnapshot.value as Map<dynamic, dynamic>;
      final List<User> users = usersData.values.map((data) {
        return User.fromJson(data);
      }).toList();

      users.removeWhere((user) => user.id == loginUser.id);

      setState(() {
        currentUsers = users;
      });

      if (!groupsSnapshot.exists) {
        return;
      }

      final Map<dynamic, dynamic> groupsData =
          groupsSnapshot.value as Map<dynamic, dynamic>;
      final List<Group> groups = groupsData.values.map((data) {
        return Group.fromJson(data);
      }).toList();

      groups.removeWhere((group) => group.admin.id != loginUser.id && !group.members.any((member) => member.id == loginUser.id));

      setState(() {
        currentGroups = groups;
      });

    } catch (error) {
      showAlert("Error", "Failed to load data: $error");
    }
  }

  Future<void> createGroup() async {
    final User loginUser = widget.loginUser;

    try {
      final group = {
        "id": DateTime.now().millisecondsSinceEpoch,
        "name": groupName,
        "admin": loginUser.toJson(),
        "members": groupMembers.map((member) => member.toJson()).toList(),
      };

      await db.child("groups").push().set(group);

      showAlert("Success", "Group created successfully!");
    } catch (error) {
      showAlert("Error", "Failed to create group: $error");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
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
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: currentGroups.length,
                        itemBuilder: (context, index) {
                          Group group = currentGroups[index];
                          //bool isSelected = selectedMembers.contains(user);

                          return ListTile(
                            leading: CircleAvatar(
                              child: Icon(Icons.group),
                            ),
                            title: Text(group.name),
                            //subtitle: Text(user.email,style: TextStyle(fontSize: 8),),
                          );
                        },
                      ),
                    ),
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
      body: screens[selectedIndex],
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
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await loadData();

          showDialog(
            context: context,
            builder: (context) {
              TextEditingController groupNameController =
                  TextEditingController();
              List<User> filteredUsers = currentUsers;
              List<User> selectedMembers = [widget.loginUser];

              return StatefulBuilder(
                builder: (context, setDialogState) {
                  return AlertDialog(
                    title: const Text('Create a New Group'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: groupNameController,
                          decoration: const InputDecoration(
                            labelText: 'Group Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          onChanged: (query) {
                            setDialogState(() {
                              filteredUsers = currentUsers
                                  .where((user) => user.email
                                      .toLowerCase()
                                      .contains(query.toLowerCase()))
                                  .toList();
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Search Users by Email',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            itemCount: filteredUsers.length,
                            itemBuilder: (context, index) {
                              User user = filteredUsers[index];
                              bool isSelected = selectedMembers.contains(user);

                              return ListTile(
                                leading: CircleAvatar(
                                  child: Text(user.name[0]),
                                ),
                                title: Text(user.name),
                                subtitle: Text(
                                  user.email,
                                  style: TextStyle(fontSize: 8),
                                ),
                                trailing: Checkbox(
                                  value: isSelected,
                                  onChanged: (value) {
                                    setDialogState(() {
                                      if (value == true) {
                                        selectedMembers.add(user);
                                      } else {
                                        selectedMembers.remove(user);
                                      }
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      // Create Group Button
                      TextButton(
                        onPressed: () async {
                          if (groupNameController.text.isEmpty) {
                            showAlert('Error', 'Group name cannot be empty.');
                            return;
                          }
                          if (selectedMembers.isEmpty) {
                            showAlert('Error',
                                'Please select at least one group member.');
                            return;
                          }

                          groupName = groupNameController.text.trim();
                          groupMembers = selectedMembers;

                          await createGroup();
                          await loadData();

                          Navigator.pop(context);
                          showAlert('Success', 'Group "$groupName" created!');
                        },
                        child: const Text('Create'),
                      ),

                      // Cancel Button
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.people, color: Colors.white),
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
