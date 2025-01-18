import 'user.dart';

class Group {
  int id;
  String name;
  User admin;
  List<User> members;

  Group({
    required this.id,
    required this.name,
    required this.admin,
    required this.members,
  });

  void addMember(User user) {
    members.add(user);
  }

  void removeMember(User user) {
    members.remove(user);
  }

  @override
  String toString() {
    return 'Group{id: $id, name: $name, admin: $admin, members: $members}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'admin': admin,
      'members': members,
    };
  }

  factory Group.fromJson(Map<dynamic, dynamic> json) {
    return Group(
      id: json['id'] ?? 0, // Default value if null
      name: json['name'] ?? '',
      admin: User.fromJson(json['admin']), // Parse the admin as a User object
      members: (json['members'] as List<dynamic>)
          .map((member) => User.fromJson(member))
          .toList(), // Parse each member as a User object
    );
  }


}
