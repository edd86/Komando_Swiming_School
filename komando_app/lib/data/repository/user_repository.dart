
import 'package:komando_app/data/models/data_models.dart';
import 'package:komando_app/data/source/firebase_datasource.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();
  Future<bool> saveUser(User user);
}

class UserRepositoryImpl implements UserRepository {

  final FirebaseDataSource _firebaseDataSource;

  UserRepositoryImpl(this._firebaseDataSource);

  @override
  Future<List<User>> getUsers() async {
    return await _firebaseDataSource.getUsers();
  }

  @override
  Future<bool> saveUser(User user) {
    // TODO: implement saveUser
    throw UnimplementedError();
  }
  
}