import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:komando_app/data/models/data_models.dart';
import 'package:komando_app/data/repository/schedule_repository.dart';
import 'package:komando_app/data/source/firebase_datasource.dart';

class ScheduleHelper {
  final FirebaseDataSource _source =
      FirebaseDataSourceImpl(FirebaseFirestore.instance);

  Future<List<Schedule>> getSchedules(String shift) async {
    ScheduleRepository repository = ScheduleRepositoryImpl(_source);
    List<Schedule> schedules = await repository.getSchedules();
    var filteredSchedules = schedules.where((schedule) => schedule.shift == shift).toList();
    filteredSchedules.sort(
      (a, b) => a.startTime.compareTo(b.startTime),
    );
    return filteredSchedules;
  }

  Future<void> saveSchedule(Schedule schedule) async {
    ScheduleRepository repository = ScheduleRepositoryImpl(_source);
    await repository.saveSchedule(schedule);
  }

  Future<void> deleteSchedule(Schedule schedule) async {
    ScheduleRepository repository = ScheduleRepositoryImpl(_source);
    await repository.deleteSchedule(schedule);
  }

  Future<Schedule> getScheduleByStartTime(int startTime) async {
    ScheduleRepository repo = ScheduleRepositoryImpl(_source);
    List<Schedule> schedules = await repo.getSchedules();
    return schedules.firstWhere((element) => element.startTime == startTime);
  }
}
