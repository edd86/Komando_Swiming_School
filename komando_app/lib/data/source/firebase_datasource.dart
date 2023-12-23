
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:komando_app/data/models/data_models.dart';

abstract class FirebaseDataSource  {
  Future<List<User>> getUsers();
  Future<void> saveUser(User user);
  Future<List<Schedule>> getSchedules();
  Future<void> saveSchedule(Schedule schedule);
  Future<List<Student>> getStudents();
  Future<void> deleteSchedule(Schedule schedule);
  Future<void> addStudent(Student student, Schedule schedule);
}

class FirebaseDataSourceImpl implements FirebaseDataSource {
  final FirebaseFirestore _firestore;
  FirebaseDataSourceImpl(this._firestore);

  @override
  Future<List<User>> getUsers() async {
    List<User> users = [];
    final doc = await _firestore.collection('users').get();
    for (DocumentSnapshot document in doc.docs) {
      final id = <String, dynamic> {'id': document.id};
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      data.addAll(id);
      DocumentSnapshot docSchedule = await data['schedule'].get();
      users.add(User.fromJSON(data, docSchedule));
    }
    return users;
  }

  @override
  Future<void> saveUser(User user) async {
    await _firestore.collection('user').add(user.toJSON());
  }
  
  @override
  Future<List<Schedule>> getSchedules() async {
    List<Schedule> schedules = [];
    final doc = await _firestore.collection('schedule').get();
    for (DocumentSnapshot document in doc.docs) {
      final id = <String, dynamic> {'id': document.id};
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      data.addAll(id);
      schedules.add(Schedule.fromJSON(data));
    }
    return schedules;
  }
  
  @override
  Future<void> saveSchedule(Schedule schedule) async {
    await _firestore.collection('schedule').add(schedule.toJSON());
    //print('$doc');
  }
  
  @override
  Future<List<Student>> getStudents() async {
    List<Student> students = [];
    final docStudent = await _firestore.collection('student').get();
    for(DocumentSnapshot document in docStudent.docs){
      final id = <String, dynamic> {'id': document.id};
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      DocumentSnapshot docSchedule = await data['schedule'].get();
      data.addAll(id);
      //print('${docSchedule.data()}');
      students.add(Student.fromJSON(data, docSchedule));
    }
    return students;
  }
  
  @override
  Future<void> deleteSchedule(Schedule schedule) async{
    final docSchedule = _firestore.collection('schedule').doc(schedule.id);
    await docSchedule.delete();
  }
  
  @override
  Future<void> addStudent(Student student, Schedule schedule) async {
    DocumentReference reference = _firestore.collection('schedule').doc(schedule.id);
    final scheduleMaped = <String, dynamic> {'schedule': reference};
    final studentMaped = student.toJSON();
    studentMaped.addAll(scheduleMaped);
    await _firestore.collection('student').add(studentMaped);
  }
}