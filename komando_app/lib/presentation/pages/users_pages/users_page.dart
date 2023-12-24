// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komando_app/config/themes/app_theme.dart';
import 'package:komando_app/data/models/data_models.dart';
import 'package:komando_app/presentation/providers/providers.dart';
import 'package:komando_app/presentation/widgets/custom_progress_indicator.dart';

class UsersPage extends ConsumerWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersList = ref.watch(usersListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios Registrados'),
      ),
      body: usersList.when(
        data: (data) {
          if (data.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListView.builder(
                itemCount: data.length,
                itemExtent: 250,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(seconds: 3),
                      horizontalOffset: 500,
                      child: UserCard(data[index]),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Text('No Existen usuarios Registrados');
          }
        },
        error: (error, stackTrace) => Text('Error: $error'),
        loading: () => CustomProgressIndicator(
          size: 85,
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  User user;
  UserCard(
    this.user, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/images/komandos.png',
              ),
            ),
            Positioned(
              child: Text(
                'KOMANDO ESCUELA DE NATACIÓN',
                textAlign: TextAlign.center,
                style: GoogleFonts.robotoCondensed(
                  color: AppTheme.highlightColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: 10,
              child: Image.network(
                user.photo,
                width: 100,
                height: 160,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 6,
              child: Text(
                user.id!,
                textAlign: TextAlign.center,
                style: GoogleFonts.robotoCondensed(
                  color: AppTheme.secondaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
            Positioned(
              top: 35,
              left: 120,
              child: Container(
                width: 180,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(155, 63, 59, 59),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre: ${user.name}',
                      maxLines: 2,
                      style: GoogleFonts.robotoCondensed(
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Edad: ${user.age}',
                      style: GoogleFonts.robotoCondensed(
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Dirección: ${user.address}',
                      maxLines: 2,
                      style: GoogleFonts.robotoCondensed(
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Teléfono: ${user.mobileNumber}',
                      style: GoogleFonts.robotoCondensed(
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Administrador: ${user.isAdmin ? 'Si' : 'No'}',
                      style: GoogleFonts.robotoCondensed(
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    user.schedule != null
                        ? Text(
                            'Ingreso: ${user.schedule!.startTime}',
                            style: GoogleFonts.robotoCondensed(
                              color: AppTheme.secondaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.5,
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
