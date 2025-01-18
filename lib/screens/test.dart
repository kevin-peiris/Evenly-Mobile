import 'package:flutter/material.dart';
import '../models/User.dart';
import '../models/Group.dart'; // Assuming you have the Group model in this path.

class Dashboard extends StatefulWidget {
  final User loginUser;
  const Dashboard({super.key, required this.loginUser});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _groupNameController = TextEditingController();
  List<User> currentUsers = []; // Retrieved users to select as group members.
  List<User> selectedMembers = []; // Members selected for the new group.

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    // Mock Firebase retrieval for demonstration
    var userSnapshot = await db.child("users").get();

    if (userSnapshot.exists) {
      final Map<dynamic, dynamic> usersData =
      userSnapshot.value as Map<dynamic, dynamic>;
      final List<User> users = usersData.values.map((data) {
        return User.fromJson(data);
      }).toList();

      setState(() {
        currentUsers = users;
      });
    }
  }

  void createGroup() {
    String groupName = _groupNameController.text.trim();
    if (groupName.isEmpty || selectedMembers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide a group name and members')),
      );
      return;
    }

    Group newGroup = Group(
      id: DateTime.now().millisecondsSinceEpoch, // Unique ID
      name: groupName,
      admin: widget.loginUser,
      members: selectedMembers,
    );

    // Add logic to save the group to your database here
    print(newGroup);

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Group "$groupName" created successfully!')),
    );
  }

  void showGroupCreationDialog() {
    selectedMembers.clear(); // Clear previously selected members.
    _groupNameController.clear(); // Clear the input field.

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create a New Group'),
        content: SizedBox(
          height: 300,
          child: Column(
            children: [
              // Group Name Input
              TextField(
                controller: _groupNameController,
                decoration: const InputDecoration(
                  labelText: 'Group Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // User Selection
              Expanded(
                child: ListView.builder(
                  itemCount: currentUsers.length,
                  itemBuilder: (context, index) {
                    final user = currentUsers[index];
                    return CheckboxListTile(
                      title: Text(user.name),
                      subtitle: Text(user.email), // Assuming User has an email.
                      value: selectedMembers.contains(user),
                      onChanged: (bool? isSelected) {
                        setState(() {
                          if (isSelected == true) {
                            selectedMembers.add(user);
                          } else {
                            selectedMembers.remove(user);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: createGroup,
            child: const Text('Create'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
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
        child: const Text('Dashboard Content'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showGroupCreationDialog,
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.people,
          color: Colors.white,
        ),
      ),
    );
  }
}
