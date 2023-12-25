import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:komando_app/data/models/data_models.dart';

abstract class FirebaseDataSource {
  Future<List<User>> getUsers();
  Future<void> saveUser(User user, [String? id]);
  Future<List<Schedule>> getSchedules();
  Future<void> saveSchedule(Schedule schedule);
  Future<List<Student>> getStudents();
  Future<void> deleteSchedule(Schedule schedule);
  Future<void> addStudent(Student student, Schedule schedule);
  Future<void> addPayment(Payment payment);
  Future<List<Payment>> getPayments();
}

class FirebaseDataSourceImpl implements FirebaseDataSource {
  final FirebaseFirestore _firestore;
  FirebaseDataSourceImpl(this._firestore);

  @override
  Future<List<User>> getUsers() async {
    List<User> users = [];
    final doc = await _firestore.collection('users').get();
    for (DocumentSnapshot document in doc.docs) {
      final id = <String, dynamic>{'id': document.id};
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      data.addAll(id);
      if (data['schedule'] != null) {
        DocumentSnapshot docSchedule = await data['schedule'].get();
        users.add(User.fromJSON(data, docSchedule: docSchedule));
      } else {
        users.add(User.fromJSON(data));
      }
    }
    return users;
  }

  @override
  Future<void> saveUser(User user, [String? id]) async {
    if (id != null) {
      DocumentReference reference = _firestore.collection('schedule').doc(id);
      final scheduleMapped = <String, dynamic>{'schedule': reference};
      final userMapped = user.toJSON();
      userMapped.addAll(scheduleMapped);
      userMapped.remove('id');
      await _firestore.collection('users').add(userMapped);
    } else {
      final userMapped = user.toJSON();
      userMapped.remove('id');
      await _firestore.collection('users').add(userMapped);
    }
  }

  @override
  Future<List<Schedule>> getSchedules() async {
    List<Schedule> schedules = [];
    final doc = await _firestore.collection('schedule').get();
    for (DocumentSnapshot document in doc.docs) {
      final id = <String, dynamic>{'id': document.id};
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      data.addAll(id);
      schedules.add(Schedule.fromJSON(data));
    }
    return schedules;
  }

  @override
  Future<void> saveSchedule(Schedule schedule) async {
    await _firestore.collection('schedule').add(schedule.toJSON());
  }

  @override
  Future<List<Student>> getStudents() async {
    List<Student> students = [];
    final docStudent = await _firestore.collection('student').get();
    for (DocumentSnapshot document in docStudent.docs) {
      final id = <String, dynamic>{'id': document.id};
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      DocumentSnapshot docSchedule = await data['schedule'].get();
      data.addAll(id);
      students.add(Student.fromJSON(data, docSchedule));
    }
    return students;
  }

  @override
  Future<void> deleteSchedule(Schedule schedule) async {
    final docSchedule = _firestore.collection('schedule').doc(schedule.id);
    await docSchedule.delete();
  }

  @override
  Future<void> addStudent(Student student, Schedule schedule) async {
    DocumentReference reference =
        _firestore.collection('schedule').doc(schedule.id);
    final scheduleMapped = <String, dynamic>{'schedule': reference};
    final studentMapped = student.toJSON();
    studentMapped.addAll(scheduleMapped);
    studentMapped.remove('id');
    await _firestore.collection('student').add(studentMapped);
  }

  @override
  Future<void> addPayment(Payment payment) async {
    DocumentReference reference =
        _firestore.collection('student').doc(payment.student.id);
    final studentMapped = <String, dynamic>{'student': reference};
    final paymentMapped = payment.toJSON();
    paymentMapped.addAll(studentMapped);
    paymentMapped.remove('id');
    await _firestore.collection('payments').add(paymentMapped);
  }

  @override
  Future<List<Payment>> getPayments() async {
    List<Payment> payments = [];
    final docPayments = await _firestore.collection('payments').get();
    for (DocumentSnapshot doc in docPayments.docs) {
      final paymentId = <String, dynamic>{'id': doc.id};
      Map<String, dynamic> payment = doc.data() as Map<String, dynamic>;
      DocumentSnapshot docStudent = await payment['student'].get();
      final studentId = <String, dynamic>{'id': docStudent.id};
      Map<String, dynamic> student = docStudent.data() as Map<String, dynamic>;
      student.addAll(studentId);
      DocumentSnapshot docSchedule = await student['schedule'].get();
      payment.addAll(paymentId);
      payments.add(Payment.fromJSON(payment, student, docSchedule));
    }
    return payments;
  }
}
