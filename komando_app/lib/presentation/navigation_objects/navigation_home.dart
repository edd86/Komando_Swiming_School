import 'package:flutter/material.dart';
import 'package:komando_app/config/routes/app_routes.dart';

class NavigationHomeObject {
  String title;
  String subtitle;
  IconData iconLeading;
  IconData iconTrailing;
  bool isRestricted;
  String route;

  NavigationHomeObject({
    required this.title,
    required this.subtitle,
    required this.iconLeading,
    required this.iconTrailing,
    required this.isRestricted,
    required this.route,
  });

  static List<NavigationHomeObject> navigator = [
    NavigationHomeObject(
      title: "Registro de Usuarios",
      subtitle: "Crea una cuenta para acceder a los servicios.",
      iconLeading: Icons.person_add_alt_1,
      iconTrailing: Icons.navigate_next,
      isRestricted: true,
      route: AppRoutes.registerUser,
    ),
    NavigationHomeObject(
      title: 'Usuarios',
      subtitle: 'Muestra a todos los usuarios Registrados en el Sistema',
      iconLeading: Icons.verified_user,
      iconTrailing: Icons.navigate_next,
      isRestricted: false,
      route: AppRoutes.usersPage,
    ),
    NavigationHomeObject(
      title: "Registro Estudiantes",
      subtitle: "Ingresa los datos de tus estudiantes.",
      iconLeading: Icons.person_add_alt_1_rounded,
      iconTrailing: Icons.navigate_next,
      isRestricted: true,
      route: AppRoutes.registerStudent,
    ),
  ];
}
