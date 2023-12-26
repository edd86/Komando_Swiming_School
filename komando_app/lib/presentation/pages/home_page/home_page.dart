// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komando_app/config/routes/app_routes.dart';
import 'package:komando_app/config/themes/app_theme.dart';
import 'package:komando_app/data/models/data_models.dart';
import 'package:komando_app/helpers/helpers.dart';
//import 'package:komando_app/helpers/student_helper.dart';
import 'package:komando_app/presentation/navigation_objects/navigation_home.dart';
import 'package:komando_app/presentation/providers/user_provider.dart';
import 'package:komando_app/presentation/utils/media_functions.dart';
import 'package:komando_app/presentation/widgets/widgets.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

TextStyle textCardStyle = GoogleFonts.robotoCondensed(
  color: AppTheme.secondaryColor,
  fontWeight: FontWeight.w600,
  fontSize: 12,
);

class HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    User userConnected = ref.watch(userConnectedProvider);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeInDown(
                  animate: true,
                  duration: const Duration(seconds: 2),
                  child: SizedBox(
                    height: size.height * .20,
                    width: size.width * .8,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: SizedBox(
                              width: 85,
                              child: Image.network(
                                userConnected.photo,
                                loadingBuilder:
                                    (context, child, loadingProgres) {
                                  if (loadingProgres == null) {
                                    return child;
                                  } else {
                                    return Center(
                                      child: CustomProgressIndicator(size: 20),
                                    );
                                  }
                                },
                              ),
                            ),
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (context) => CustomProgressIndicator(
                                  size: 70,
                                ),
                              );
                              final image = await captureImage();
                              if (image != null) {
                                UserHelper helper = UserHelper();
                                String url = await uploadUserImage(
                                    userConnected, File(image.path));
                                if (url != '') {
                                  helper.addImageToUser(userConnected, url);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    snackBarMessage(
                                        'Imagen Agregada, cambios al reiniciar.'),
                                  );
                                  Navigator.pop(context);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  snackBarMessage(
                                      'No se pudo Agregar la Imagen'),
                                );
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  userConnected.name,
                                  style: textCardStyle,
                                ),
                                Text(
                                  'Edad: ${userConnected.age}',
                                  style: textCardStyle,
                                ),
                                Text(
                                  'Teléfono: ${userConnected.mobileNumber}',
                                  style: textCardStyle,
                                ),
                                Text(
                                  userConnected.isAdmin
                                      ? 'Administrador: Si'
                                      : 'Administrador: No',
                                  style: textCardStyle,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                NavigationList(size: size)
              ],
            ),
          ),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton.extended(
          label: Text(
            'Cerrar Sesión',
            style: GoogleFonts.robotoCondensed(fontWeight: FontWeight.w600),
          ),
          icon: const Icon(Icons.exit_to_app_rounded),
          onPressed: () {
            ref.invalidate(userConnectedProvider);
            Navigator.popAndPushNamed(context, AppRoutes.login);
          },
        ),
        /* floatingActionButton: FloatingActionButton(
          onPressed: () async {
            StudentHelper helper = StudentHelper();
            List<Student> students = await helper.getStudents(9);
            students.forEach((element) {
              print(element.name);
            });
          },
          child: const Icon(Icons.textsms_sharp),
        ), */
      ),
    );
  }
}

class NavigationList extends ConsumerWidget {
  const NavigationList({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = ref.watch(userConnectedProvider);
    final navigationList = NavigationHomeObject.navigator;
    return Expanded(
      child: ListView.separated(
        itemCount: navigationList.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 5,
        ),
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: AppTheme.primaryColor,
            title: Text(NavigationHomeObject.navigator[index].title),
            subtitle: Text(NavigationHomeObject.navigator[index].subtitle),
            leading: Icon(NavigationHomeObject.navigator[index].iconLeading),
            trailing: Icon(NavigationHomeObject.navigator[index].iconTrailing),
            onTap: () {
              if (navigationList[index].isRestricted) {
                if (user.isAdmin) {
                  Navigator.pushNamed(
                      context, NavigationHomeObject.navigator[index].route);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(snackBarMessage(
                      'No tiene autorización para esta función'));
                }
              } else {
                Navigator.pushNamed(
                    context, NavigationHomeObject.navigator[index].route);
              }
            },
          );
        },
      ),
    );
  }
}
