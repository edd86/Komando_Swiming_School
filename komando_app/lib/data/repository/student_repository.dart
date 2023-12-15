
import 'package:komando_app/data/models/data_models.dart';
import 'package:komando_app/data/source/firebase_datasource.dart';

abstract class StudentRepository {
  Future<List<Student>> getStudents();
  Future<void> addStudent(Student student, Schedule schedule);
}

class StudentRepositoryImpl implements StudentRepository {

  final FirebaseDataSource _firebaseDataSource;
  
  StudentRepositoryImpl(this._firebaseDataSource);

  @override
  Future<List<Student>> getStudents() async {
    return await _firebaseDataSource.getStudents();
  }
  
  @override
  Future<void> addStudent(Student student, Schedule schedule) async {
    await _firebaseDataSource.addStudent(student, schedule);
  }
  
}