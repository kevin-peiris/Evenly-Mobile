import '../util/ExpenseUserType.dart';
import 'Expense.dart';
import 'User.dart';

class ExpenseUser {
  int id;
  User user;
  double amount;
  Expense expense;
  ExpenseUserType expenseUserType;

  ExpenseUser({
    required this.id,
    required this.user,
    required this.amount,
    required this.expense,
    required this.expenseUserType,
  });
}


