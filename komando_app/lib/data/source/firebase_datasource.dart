

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:komando_app/data/models/data_models.dart';

abstract class FirebaseDataSource  {
  Future<List<User>> getUsers();
  Future<bool> saveUser(User user);
  Future<List<Schedule>> getSchedules();
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
      users.add(User.fromJSON(data));
    }
    return users;
  }

  @override
  Future<bool> saveUser(User user) {
    // TODO: implement saveUser
    throw UnimplementedError();
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
  
}