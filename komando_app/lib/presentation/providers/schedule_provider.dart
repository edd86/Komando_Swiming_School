import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:komando_app/data/models/data_models.dart';
import 'package:komando_app/helpers/schedule_helper.dart';

final shiftProvider = StateProvider<String>((ref) => 'am');

final scheduleProvider = FutureProvider<List<Schedule>>((ref) async {
  final shift = ref.watch(shiftProvider);
  ScheduleHelper helper = ScheduleHelper();
  return await helper.getSchedules(shift);
});

final scheduleSelectedProvider = StateNotifierProvider<ScheduleSelectedTimeNotifier, int>((ref) => ScheduleSelectedTimeNotifier());

class ScheduleSelectedTimeNotifier extends StateNotifier<int> {
  ScheduleSelectedTimeNotifier() : super(9);

  void changeSelection(int selection) {
    state = selection;
  }
}

final scheduleStartTimeProvider = StateProvider<TimeOfDay>((ref) => TimeOfDay.now());

final scheduleEndTimeProvider = StateProvider<TimeOfDay>((ref) => TimeOfDay.now());

