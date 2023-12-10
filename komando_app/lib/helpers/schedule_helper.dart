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
}
