import 'package:flutter/material.dart';
import 'package:komando_app/presentation/pages/pages.dart';


class AppRoutes {
  
  static const String login = '/login';

  static Map<String, WidgetBuilder> routes(BuildContext context) {
    return {
      // Login page route
      login: (context) => const LoginPage(),
    };
  }
}