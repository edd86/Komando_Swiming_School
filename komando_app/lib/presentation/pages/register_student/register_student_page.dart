// ignore_for_file: unrelated_type_equality_checks, must_be_immutable, use_build_context_synchronously, unnecessary_null_comparison

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komando_app/config/themes/app_theme.dart';
import 'package:komando_app/data/models/data_models.dart';
import 'package:komando_app/helpers/helpers.dart';
import 'package:komando_app/presentation/pages/register_student/schedule_widget.dart';
import 'package:komando_app/presentation/providers/providers.dart';
import 'package:komando_app/presentation/widgets/widgets.dart';

class RegisterStudentPage extends ConsumerStatefulWidget {
  const RegisterStudentPage({super.key});

  @override
  RegisterStudentPageState createState() => RegisterStudentPageState();
}

enum Shifts { am, pm }

class RegisterStudentPageState extends ConsumerState<RegisterStudentPage> {
  Shifts shiftSelected = Shifts.am;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: FadeInLeft(
                  child: SegmentedButton<Shifts>(
                    segments: const [
                      ButtonSegment(
                          value: Shifts.am,
                          icon: Icon(Icons.sunny, size: 30),
                          label: Text('Mañana'),
                          tooltip: 'Horarios del turno de la mañana'),
                      ButtonSegment(
                          value: Shifts.pm,
                          icon: Icon(Icons.nightlight, size: 30),
                          label: Text('Tarde'),
                          tooltip: 'Horarios del turno de la tarde')
                    ],
                    selected: {shiftSelected},
                    onSelectionChanged: (shift) {
                      if (shift.first == Shifts.am) {
                        ref
                            .read(shiftProvider.notifier)
                            .update((state) => 'am');
                        setState(() {
                          shiftSelected = shift.first;
                        });
                      } else {
                        ref
                            .read(shiftProvider.notifier)
                            .update((state) => 'pm');
                        setState(() {
                          shiftSelected = shift.first;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInDown(child: const ScheduleWidget()),
                  IconButton(
                    icon: const Icon(
                      Icons.add_alarm,
                      color: AppTheme.primaryColor,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AddSchedulePage(),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.alarm_off,
                      color: AppTheme.primaryColor,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const RemoveSchedulePage(),
                      );
                    },
                  )
                ],
              ),
              const SizedBox(height: 15),
              const Expanded(child: StudentsList())
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.person_add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => StudentFormPage(),
            );
          },
        ),
      ),
    );
  }
}

class StudentsList extends ConsumerStatefulWidget {
  const StudentsList({super.key});

  @override
  StudentsListState createState() => StudentsListState();
}

TextStyle styleStudents = GoogleFonts.robotoCondensed(
  color: AppTheme.secondaryColor,
  fontSize: 15,
);

class StudentsListState extends ConsumerState<StudentsList> {
  @override
  Widget build(BuildContext context) {
    final students = ref.watch(studentsProviders);
    return students.when(
      data: (data) {
        if (data.isEmpty) {
          return const Center(
            child: Text('No hay estudiantes asignados a este turno'),
          );
        } else {
          return ListView.builder(
            itemCount: data.length,
            itemExtent: 110,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 400),
                child: SlideAnimation(
                  delay: const Duration(milliseconds: 500),
                  verticalOffset: 35.5,
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () {
                        //TODO: Lógica de selección de estudiante.
                        ref.read(studentSelectedProvider.notifier).state =
                            data[index];
                      },
                      child: Card(
                        elevation: 8,
                        shape: const RoundedRectangleBorder(
                          borderRadius: AppTheme.radius,
                        ),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: const BoxDecoration(
                            borderRadius: AppTheme.radius,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    NetworkImage(data[index].photo),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: SizedBox(
                                  width: 120,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nombre: ${data[index].name}',
                                        style: styleStudents,
                                        maxLines: 2,
                                      ),
                                      Text(
                                        'Edad: ${data[index].age}',
                                        style: styleStudents,
                                      ),
                                      Text(
                                        'Telf: ${data[index].mobilePhone}',
                                        style: styleStudents,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${data[index].dateIn.day} - ${data[index].dateIn.month} - ${data[index].dateIn.year}',
                                      style: styleStudents,
                                    ),
                                    Text(
                                      data[index].schedule.name,
                                      style: styleStudents,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      },
      loading: () => CustomProgressIndicator(
        size: 50,
      ),
    );
  }
}

class AddSchedulePage extends ConsumerWidget {
  AddSchedulePage({super.key});

  final TextEditingController _tfNameSchedule = TextEditingController();
  final TextEditingController _tfStudentLimitSchedule = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TimeOfDay startTime = ref.watch(scheduleStartTimeProvider);
    TimeOfDay endTime = ref.watch(scheduleEndTimeProvider);
    return AlertDialog(
      icon: const Icon(
        Icons.lock_clock,
        size: 35,
      ),
      title: const Text("Add Schedule"),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(127, 195, 252, 242),
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: TextField(
                  controller: _tfNameSchedule,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.sentences,
                  style: GoogleFonts.robotoCondensed(fontSize: 17),
                  decoration: const InputDecoration(
                    hintText: 'Nombre del Turno',
                    icon: Icon(Icons.text_fields),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(127, 195, 252, 242),
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: TextField(
                  controller: _tfStudentLimitSchedule,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.robotoCondensed(fontSize: 17),
                  decoration: const InputDecoration(
                    hintText: 'Límite de estudiantes',
                    icon: Icon(Icons.numbers),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text(
                      'Inicio: ${startTime.hour}:00',
                      style: GoogleFonts.robotoCondensed(
                        color: AppTheme.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () async {
                      TimeOfDay timePicked = (await showTimePicker(
                          context: context,
                          initialTime: startTime,
                          cancelText: 'Cancelar',
                          confirmText: 'Aceptar',
                          helpText: 'Seleccione Hora'))!;
                      if (timePicked != null && timePicked != startTime) {
                        ref.read(scheduleStartTimeProvider.notifier).state =
                            timePicked;
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            snackBarMessage('Seleccione una Hora'));
                      }
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Fin: ${endTime.hour}:00',
                      style: GoogleFonts.robotoCondensed(
                        color: AppTheme.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () async {
                      TimeOfDay timePicked = (await showTimePicker(
                          context: context, initialTime: startTime))!;
                      if (timePicked != endTime) {
                        ref.read(scheduleEndTimeProvider.notifier).state =
                            timePicked;
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            'Aceptar',
            style: GoogleFonts.robotoCondensed(
                color: AppTheme.secondaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            if (_tfNameSchedule.text.isNotEmpty &&
                _tfStudentLimitSchedule.text.isNotEmpty) {
              ScheduleHelper helper = ScheduleHelper();
              String nameSchedule = _tfNameSchedule.text;
              int numberSchedule = int.parse(_tfStudentLimitSchedule.text);
              Schedule schedule = Schedule(
                id: null,
                name: nameSchedule,
                startTime: ref.watch(scheduleStartTimeProvider).hour,
                endTime: ref.watch(scheduleEndTimeProvider).hour,
                studentsLimit: numberSchedule,
                shift: ref.watch(shiftProvider),
              );
              helper.saveSchedule(schedule);
              ref.invalidate(scheduleProvider);
              ScaffoldMessenger.of(context)
                  .showSnackBar(snackBarMessage('Horario agregador'));
              Navigator.pop(context);
            }
          },
        ),
        TextButton(
          child: Text(
            'Cancelar',
            style: GoogleFonts.robotoCondensed(
                color: AppTheme.secondaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}

class RemoveSchedulePage extends ConsumerWidget {
  const RemoveSchedulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final schedules = ref.watch(scheduleProvider);
    return AlertDialog(
      icon: const Icon(Icons.cleaning_services),
      title: const Text('Eliminar Horario'),
      content: SizedBox(
        height: size.height * .20,
        width: size.width * .70,
        child: schedules.when(
          data: (data) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final Schedule schedule = data[index];
                return ListTile(
                  title: Text(schedule.name),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text('Inicio: ${schedule.startTime}'),
                      ),
                      Flexible(
                        child: Text('Fin: ${schedule.endTime}'),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_forever),
                    onPressed: () async {
                      ScheduleHelper helper = ScheduleHelper();
                      await helper.deleteSchedule(schedule);
                      ref.invalidate(scheduleProvider);
                    },
                  ),
                );
              },
            );
          },
          error: (error, stackTrace) {
            return Text(error.toString());
          },
          loading: () => CustomProgressIndicator(
            size: 55,
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            'Aceptar',
            style: GoogleFonts.robotoCondensed(
              color: AppTheme.secondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class StudentFormPage extends ConsumerWidget {
  StudentFormPage({super.key});

  final TextEditingController _tfNameController = TextEditingController();
  final TextEditingController _tfAgeController = TextEditingController();
  final TextEditingController _tfMobileController = TextEditingController();
  final TextEditingController _tfCiController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    DateTime dateRegistered = ref.watch(studentDateProvider);

    return AlertDialog(
      icon: const Icon(
        Icons.person,
        size: 25,
      ),
      title: const Text('Agregar Estudiante'),
      content: SizedBox(
        height: size.height * .40,
        width: size.width * .6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              decoration: const BoxDecoration(
                borderRadius: AppTheme.radius,
                color: Color.fromARGB(127, 195, 252, 242),
              ),
              child: TextField(
                controller: _tfNameController,
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person_outline,
                    ),
                    hintText: 'Nombre Completo'),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              decoration: const BoxDecoration(
                borderRadius: AppTheme.radius,
                color: Color.fromARGB(127, 195, 252, 242),
              ),
              child: TextField(
                controller: _tfAgeController,
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.cake,
                    ),
                    hintText: 'Edad'),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              decoration: const BoxDecoration(
                borderRadius: AppTheme.radius,
                color: Color.fromARGB(127, 195, 252, 242),
              ),
              child: TextField(
                controller: _tfMobileController,
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.phone_android,
                    ),
                    hintText: 'Teléfono'),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              decoration: const BoxDecoration(
                borderRadius: AppTheme.radius,
                color: Color.fromARGB(127, 195, 252, 242),
              ),
              child: TextField(
                controller: _tfCiController,
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.card_membership,
                    ),
                    hintText: 'Cédula de Identidad'),
              ),
            ),
            TextButton(
              child: Text(
                'Fecha Inscripción: ${dateRegistered.day}-${dateRegistered.month}-${dateRegistered.year}',
                style: GoogleFonts.robotoCondensed(
                  color: AppTheme.secondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2050),
                  currentDate: dateRegistered,
                );
                if (newDate != null) {
                  ref.read(studentDateProvider.notifier).state = newDate;
                }
              },
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            'Aceptar',
            style: GoogleFonts.robotoCondensed(
              color: AppTheme.secondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          onPressed: () async {
            if (tfIsNotEmpty()) {
              String name = _tfNameController.text;
              int age = int.parse(_tfAgeController.text);
              String phone = _tfMobileController.text;
              String ci = _tfCiController.text;
              DateTime dateIn = ref.watch(studentDateProvider);
              int startTime = ref.watch(scheduleSelectedProvider);
              StudentHelper helper = StudentHelper();
              if (await helper.addStudent(
                  name, age, phone, ci, dateIn, startTime)) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(snackBarMessage('Estudiante Agregado'));
                ref.invalidate(studentsProviders);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(snackBarMessage('Llene todos los campos'));
              }
            }
          },
        ),
        TextButton(
          child: Text(
            'Cancelar',
            style: GoogleFonts.robotoCondensed(
              color: AppTheme.secondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  bool tfIsNotEmpty() {
    if (_tfNameController.text.isNotEmpty ||
        _tfAgeController.text.isNotEmpty ||
        _tfMobileController.text.isNotEmpty ||
        _tfCiController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
