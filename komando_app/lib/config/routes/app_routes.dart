import 'package:flutter/material.dart';
import 'package:komando_app/presentation/pages/pages.dart';
import 'package:komando_app/presentation/pages/register_student/student_details_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String registerStudent = '/registerStudent';
  static const String registerUser = '/registerUser';
  static const String usersPage = '/usersPage';
  static const String paymentsPage = '/patmentsPage';

  static Map<String, WidgetBuilder> routes(BuildContext context) {
    return {
      // Login page route
      login: (context) => LoginPage(),
      // Home page route
      home: (context) => const HomePage(),
      // Student Register
      registerStudent: (context) => const RegisterStudentPage(),
      // User Register
      registerUser: (context) => const RegisterUserPage(),
      // User Page
      usersPage: (context) => const UsersPage(),
      // Payaments Page
      paymentsPage: (context) => StudentDetailsPage()
    };
  }
}
