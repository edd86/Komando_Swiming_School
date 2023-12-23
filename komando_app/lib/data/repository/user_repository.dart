
import 'package:komando_app/data/models/data_models.dart';
import 'package:komando_app/data/source/firebase_datasource.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();
  Future<void> saveUser(User user);
}

class UserRepositoryImpl implements UserRepository {

  final FirebaseDataSource _firebaseDataSource;

  UserRepositoryImpl(this._firebaseDataSource);

  @override
  Future<List<User>> getUsers() async {
    return await _firebaseDataSource.getUsers();
  }

  @override
  Future<void> saveUser(User user) async {
    return await _firebaseDataSource.saveUser(user);
  }
  
}