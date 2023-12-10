// ignore_for_file: unrelated_type_equality_checks

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:komando_app/config/themes/app_theme.dart';
import 'package:komando_app/presentation/pages/register_student/schedule_widget.dart';
import 'package:komando_app/presentation/providers/providers.dart';

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
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInDown(child: const ScheduleWidget()),
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: AppTheme.primaryColor,
                    ),
                    onPressed: () {},
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
