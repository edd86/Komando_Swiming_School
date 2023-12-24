import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:komando_app/data/models/data_models.dart';
import 'package:komando_app/helpers/student_helper.dart';
import 'package:komando_app/presentation/providers/providers.dart';

final studentsProviders = FutureProvider<List<Student>>((ref) {
  final startTime = ref.watch(scheduleSelectedProvider);
  StudentHelper helper = StudentHelper();
  return helper.getStudents(startTime);
});

final studentDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final studentSelectedProvider = StateProvider<Student>(
  (ref) => Student(
    name: 'name',
    age: 0,
    dateIn: DateTime.now(),
    mobilePhone: 'mobilePhone',
    schedule: Schedule(
      name: 'name',
      startTime: 0,
      endTime: 0,
      studentsLimit: 0,
      shift: 'shift',
    ),
  ),
);
