
import 'package:komando_app/data/models/data_models.dart';
import 'package:komando_app/data/source/firebase_datasource.dart';

abstract class ScheduleRepository {
  Future<List<Schedule>> getSchedules();
  Future<bool> saveSchedule();
}

class ScheduleRepositoryImpl implements ScheduleRepository {

  final FirebaseDataSource _firebaseDataSource;

  ScheduleRepositoryImpl(this._firebaseDataSource);

  @override
  Future<List<Schedule>> getSchedules() async {
    return await _firebaseDataSource.getSchedules();
  }

  @override
  Future<bool> saveSchedule() {
    // TODO: implement saveSchedule
    throw UnimplementedError();
  }
  
}