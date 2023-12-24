import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komando_app/config/themes/app_theme.dart';
import 'package:komando_app/helpers/helpers.dart';
import 'package:komando_app/presentation/providers/providers.dart';
import 'package:komando_app/presentation/widgets/custom_progress_indicator.dart';
import 'package:komando_app/presentation/widgets/snackbar_messages.dart';

class RegisterUserPage extends ConsumerStatefulWidget {
  const RegisterUserPage({super.key});

  @override
  RegisterUserPageState createState() => RegisterUserPageState();
}

class RegisterUserPageState extends ConsumerState<RegisterUserPage> {
  final TextEditingController _tfNameController = TextEditingController();
  final TextEditingController _tfAgeController = TextEditingController();
  final TextEditingController _tfMobileNumberController =
      TextEditingController();
  final TextEditingController _tfAddressController = TextEditingController();
  final TextEditingController _tfUserNameController = TextEditingController();
  final TextEditingController _tfPasswordController = TextEditingController();
  int userAge = 0;
  int delay = 500;
  bool isNotVisible = true;
  bool isAdmin = false;
  bool isMorning = true;
  int startTime = 0;

  @override
  Widget build(BuildContext context) {
    final schedules = ref.watch(scheduleProvider);
    final scheduleValue = ref.watch(scheduleSelectedProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Usuario'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FadeIn(
                delay: Duration(milliseconds: delay),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(171, 67, 96, 137),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: TextField(
                    controller: _tfNameController,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    style: GoogleFonts.robotoCondensed(fontSize: 17),
                    decoration: const InputDecoration(
                      hintText: 'Nombre Completo',
                      icon: Icon(Icons.person),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              FadeIn(
                delay: Duration(milliseconds: delay * 2),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(171, 67, 96, 137),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: TextField(
                    controller: _tfAddressController,
                    keyboardType: TextInputType.streetAddress,
                    textCapitalization: TextCapitalization.words,
                    style: GoogleFonts.robotoCondensed(fontSize: 17),
                    decoration: const InputDecoration(
                      hintText: 'Dirección',
                      icon: Icon(Icons.home),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              FadeIn(
                delay: Duration(milliseconds: delay * 3),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(171, 67, 96, 137),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: TextField(
                    controller: _tfMobileNumberController,
                    keyboardType: TextInputType.phone,
                    style: GoogleFonts.robotoCondensed(fontSize: 17),
                    decoration: const InputDecoration(
                      hintText: 'Teléfono',
                      icon: Icon(Icons.phone_android_outlined),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              FadeIn(
                delay: Duration(milliseconds: delay * 4),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      width: 120,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(171, 67, 96, 137),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: TextField(
                        controller: _tfAgeController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.robotoCondensed(fontSize: 17),
                        decoration: const InputDecoration(
                          hintText: 'Edad',
                          icon: Icon(Icons.cake),
                        ),
                        onChanged: (value) => userAge = int.parse(value),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      width: 140,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(171, 67, 96, 137),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.add_circle),
                            onPressed: () {
                              setState(() {
                                userAge = userAge + 1;
                                _tfAgeController.text = userAge.toString();
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove_circle),
                            onPressed: () {
                              setState(() {
                                if (userAge > 0) {
                                  userAge--;
                                  _tfAgeController.text = userAge.toString();
                                }
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              FadeIn(
                delay: Duration(milliseconds: delay * 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      width: 160,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(171, 67, 96, 137),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: schedules.when(
                        data: (data) {
                          return DropdownButton(
                            dropdownColor: AppTheme.softColor,
                            value: scheduleValue,
                            hint: const Text('Turno'),
                            items: data
                                .map((schedule) => DropdownMenuItem(
                                      value: schedule.startTime,
                                      child: Text(
                                        schedule.name,
                                        style: GoogleFonts.robotoCondensed(
                                          color: AppTheme.highlightColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              startTime = value!;
                              ref
                                  .read(scheduleSelectedProvider.notifier)
                                  .changeSelection(startTime);
                            },
                          );
                        },
                        error: (error, stackTrace) => const Text('Error'),
                        loading: () => CustomProgressIndicator(size: 25),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isMorning ? Icons.sunny : Icons.nightlight,
                        color: AppTheme.softColor,
                      ),
                      onPressed: () {
                        isMorning = !isMorning;
                        if (isMorning) {
                          ref
                              .read(scheduleSelectedProvider.notifier)
                              .changeSelection(9);
                          ref
                              .read(shiftProvider.notifier)
                              .update((state) => 'am');
                        } else {
                          ref
                              .read(scheduleSelectedProvider.notifier)
                              .changeSelection(15);
                          ref
                              .read(shiftProvider.notifier)
                              .update((state) => 'pm');
                        }
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              FadeIn(
                delay: Duration(milliseconds: delay * 6),
                duration: const Duration(milliseconds: 800),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: AppTheme.radius,
                    color: AppTheme.primaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Datos de Acceso',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppTheme.secondaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(137, 195, 252, 242),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: TextField(
                          controller: _tfUserNameController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.name,
                          style: GoogleFonts.robotoCondensed(fontSize: 17),
                          decoration: const InputDecoration(
                            hintText: 'Nombre de Usuario',
                            icon: Icon(Icons.verified_user),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(137, 195, 252, 242),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: TextField(
                          controller: _tfPasswordController,
                          textAlign: TextAlign.center,
                          obscureText: isNotVisible,
                          keyboardType: TextInputType.visiblePassword,
                          style: GoogleFonts.robotoCondensed(fontSize: 17),
                          decoration: InputDecoration(
                            hintText: 'Contraseña',
                            icon: const Icon(Icons.lock_person),
                            suffixIcon: IconButton(
                              icon: isNotVisible
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() => isNotVisible = !isNotVisible);
                              },
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Administrador',
                            style: GoogleFonts.robotoCondensed(
                                fontSize: 18, color: AppTheme.secondaryColor),
                            textAlign: TextAlign.center,
                          ),
                          Checkbox(
                            value: isAdmin,
                            fillColor: const MaterialStatePropertyAll(
                                AppTheme.secondaryColor),
                            checkColor: AppTheme.softColor,
                            onChanged: (value) {
                              setState(() {
                                isAdmin = value!;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
// This code snippet creates a fade-in animation for an ElevatedButton widget. When the button is pressed, it checks if certain text fields are not empty and a start time is set. If the conditions are met, it retrieves values from the text fields and
              FadeIn(
                delay: Duration(
                  milliseconds: delay * 6,
                ),
                child: SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    label: const Text(
                      'Agregar Usuario',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    icon: const Icon(
                      Icons.save,
                      color: AppTheme.highlightColor,
                      size: 40,
                    ),
                    onPressed: () async {
                      if (textFieldsNotEmpty() && startTime != 0) {
                        String name = _tfNameController.text;
                        String address = _tfAddressController.text;
                        String mobile = _tfMobileNumberController.text;
                        int age = int.parse(_tfAgeController.text);
                        String userName = _tfUserNameController.text;
                        String password = _tfPasswordController.text;
                        UserHelper helper = UserHelper();
                        if (await helper.addUser(name, age, userName, password,
                            mobile, address, isAdmin, startTime)) {
                          mostrarMensaje('Usuario Agregado.');
                          ref.invalidate(usersListProvider);
                          navegarAtras();
                        } else {
                          mostrarMensaje('Usuario no Agregado.');
                        }
                      } else {
                        mostrarMensaje('Llene todos los campos y turno.');
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool textFieldsNotEmpty() {
    if (_tfNameController.text.isNotEmpty &&
        _tfAddressController.text.isNotEmpty &&
        _tfMobileNumberController.text.isNotEmpty &&
        _tfAgeController.text.isNotEmpty &&
        _tfUserNameController.text.isNotEmpty &&
        _tfPasswordController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void mostrarMensaje(String s) {
    ScaffoldMessenger.of(context).showSnackBar(snackBarMessage(s));
  }

  void navegarAtras() {
    Navigator.pop(context);
  }
}
