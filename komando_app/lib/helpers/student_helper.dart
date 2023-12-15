import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:komando_app/data/models/data_models.dart';
import 'package:komando_app/data/repository/student_repository.dart';
import 'package:komando_app/data/source/firebase_datasource.dart';
import 'package:komando_app/helpers/schedule_helper.dart';

class StudentHelper {
  final FirebaseDataSource _dataSource =
      FirebaseDataSourceImpl(FirebaseFirestore.instance);

  Future<List<Student>> getStudents(int schedule) async {
    StudentRepository repository = StudentRepositoryImpl(_dataSource);
    List<Student> students = await repository.getStudents();
    var filteredStudents = students
        .where((student) => student.schedule!.startTime == schedule)
        .toList();
    filteredStudents.sort(
      (a, b) => a.name.compareTo(b.name),
    );
    return filteredStudents;
  }

  Future<bool> addStudent(String name, int age, String phone, String ci, DateTime dateIn, int startTime) async {
    StudentRepository repository = StudentRepositoryImpl(_dataSource);
    ScheduleHelper scheduleHelper = ScheduleHelper();
    Schedule schedule = await scheduleHelper.getScheduleByStartTime(startTime);
    Student newStudent = Student(name: name, age: age, ci: ci, dateIn: dateIn, mobilePhone: phone);
    try {
      await repository.addStudent(newStudent, schedule);
      return true;
    } catch(e) {
      print(e.toString());
      return false;
    }
  } 
}
