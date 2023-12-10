import 'package:flutter/material.dart';
import 'package:komando_app/config/routes/app_routes.dart';

class NavigationHomeObject {
  String title;
  String subtitle;
  IconData iconLeading;
  IconData iconTrailing;
  String route;

  NavigationHomeObject({
    required this.title,
    required this.subtitle,
    required this.iconLeading,
    required this.iconTrailing,
    required this.route,
  });

  static List<NavigationHomeObject> navigator = [
    NavigationHomeObject(
      title: "Registro Estudiantes",
      subtitle: "Ingresa los datos de tus estudiantes.",
      iconLeading: Icons.person_add_alt_1_rounded,
      iconTrailing: Icons.arrow_forward_ios,
      route: AppRoutes.registerStudent,
    )
  ];
}
