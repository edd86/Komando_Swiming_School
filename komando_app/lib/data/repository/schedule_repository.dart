
import 'package:komando_app/data/models/data_models.dart';
import 'package:komando_app/data/source/firebase_datasource.dart';

abstract class ScheduleRepository {
  Future<List<Schedule>> getSchedules();
  Future<void> saveSchedule(Schedule schedule);
  Future<void> deleteSchedule(Schedule schedule);
}

class ScheduleRepositoryImpl implements ScheduleRepository {

  final FirebaseDataSource _firebaseDataSource;

  ScheduleRepositoryImpl(this._firebaseDataSource);

  @override
  Future<List<Schedule>> getSchedules() async {
    return await _firebaseDataSource.getSchedules();
  }

  @override
  Future<void> saveSchedule(Schedule schedule) async {
    await _firebaseDataSource.saveSchedule(schedule);
  }
  
  @override
  Future<void> deleteSchedule(Schedule schedule) async {
    return await _firebaseDataSource.deleteSchedule(schedule);
  }
  
}