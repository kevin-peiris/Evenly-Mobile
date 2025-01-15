import 'package:evenly/screens/Dashboard.dart';
import 'package:evenly/screens/Homepage.dart';
import 'package:evenly/screens/Login.dart';
import 'package:evenly/screens/Signup.dart';
import 'package:flutter/material.dart';

import '../models/User.dart';

class AppRoutes {
  static const String homepage = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String dashboard = '/dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homepage:
        return MaterialPageRoute(builder: (_) => Homepage());
      case login:
        return MaterialPageRoute(builder: (_) => Login());
      case signup:
        return MaterialPageRoute(builder: (_) => Signup());
      case dashboard:
        if (settings.arguments is User) {
          final User loginUser = settings.arguments as User;
          return MaterialPageRoute(
            builder: (_) => Dashboard(loginUser: loginUser),
          );
        }
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}