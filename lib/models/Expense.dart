import 'ExpenseUser.dart';
import 'Group.dart';
import 'User.dart';

class Expense{
  int id;
  String description;
  DateTime date;
  List<ExpenseUser> expenseUsers;
  Group group;
  double amount;
  User createdById;

  Expense({
    required this.id,
    required this.description,
    required this.date,
    required this.expenseUsers,
    required this.group,
    required this.amount,
    required this.createdById,
  });
}

