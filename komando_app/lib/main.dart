import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:komando_app/firebase_options.dart';
import 'package:komando_app/config/routes/app_routes.dart';
import 'package:komando_app/config/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Komando App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeKomandoApp(context),
      routes: AppRoutes.routes(context),
      initialRoute: AppRoutes.login,
    );
  }
}
