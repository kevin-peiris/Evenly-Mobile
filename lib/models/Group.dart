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
}
