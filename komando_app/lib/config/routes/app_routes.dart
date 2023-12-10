import 'package:flutter/material.dart';
import 'package:komando_app/presentation/pages/pages.dart';


class AppRoutes {
  
  static const String home = '/';
  static const String login = '/login';
  static const String registerStudent = '/registerStudent';

  static Map<String, WidgetBuilder> routes(BuildContext context) {
    return {
      // Login page route
      login: (context) => LoginPage(),
      // Home page route
      home: (context) => const HomePage(),
      // Student Register
      registerStudent: (context) => const RegisterStudentPage()
    };
  }
}