// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komando_app/config/routes/app_routes.dart';
import 'package:komando_app/config/themes/app_theme.dart';
import 'package:komando_app/helpers/login_helper.dart';
import 'package:komando_app/presentation/widgets/widgets.dart';

class LoginPage extends ConsumerStatefulWidget {
  LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _tfUserName = TextEditingController();
  final TextEditingController _tfPassword = TextEditingController();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        FadeIn(
          duration: const Duration(seconds: 5),
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              'assets/images/login_background.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          body: Center(
            child: FadeInRight(
              from: 550,
              duration: const Duration(seconds: 3),
              delay: const Duration(seconds: 2),
              child: Container(
                height: size.height * .6,
                width: size.width * .7,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  borderRadius: AppTheme.radius,
                  color: Color.fromARGB(127, 183, 243, 155),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.shadowColor,
                      blurRadius: 15,
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * .5 * .45,
                      child: Image.asset(
                        'assets/images/komandos.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: size.width * .7 * 8,
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 7),
                      decoration: const BoxDecoration(
                        borderRadius: AppTheme.radius,
                        color: AppTheme.secondaryColor,
                      ),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: _tfUserName,
                        cursorColor: AppTheme.highlightColor,
                        keyboardType: TextInputType.name,
                        style: GoogleFonts.robotoCondensed(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Nombre de Usuario',
                          prefixIcon: Icon(
                            Icons.person,
                            color: AppTheme.softColor,
                          ),
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.softColor),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * .7 * 8,
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 7),
                      decoration: const BoxDecoration(
                        borderRadius: AppTheme.radius,
                        color: AppTheme.secondaryColor,
                      ),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: _tfPassword,
                        obscureText: !isVisible,
                        keyboardType: TextInputType.text,
                        cursorColor: AppTheme.highlightColor,
                        style: GoogleFonts.robotoCondensed(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Contraseña',
                          prefixIcon:
                              const Icon(Icons.lock, color: AppTheme.softColor),
                          suffixIcon: IconButton(
                            icon: !isVisible
                                ? const Icon(
                                    Icons.visibility,
                                    color: AppTheme.primaryColor,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: AppTheme.softColor,
                                  ),
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                          ),
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.softColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: size.width * .7 * 8,
                      child: ElevatedButton(
                        child: const Text(
                          'Iniciar Sesión',
                          style: TextStyle(
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  CustomProgressIndicator(size: 100,));
                          if (_tfUserName.text.isNotEmpty &&
                              _tfPassword.text.isNotEmpty) {
                            LoginHelper helper = LoginHelper();
                            String userName = _tfUserName.text;
                            String password = _tfPassword.text;
                            if (await helper.login(userName, password, ref)) {
                              navegarHome();
                            } else {
                              noConnected();
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: size.width * .7 * 8,
                      child: ElevatedButton(
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          exit(0);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void noConnected() {
    ScaffoldMessenger.of(context).showSnackBar(
        snackBarMessage('Nombre de Usuario o Contraseña incorrectos'));
    Navigator.pop(context);
  }

  void navegarHome() {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.home, (route) => false);
  }
}
