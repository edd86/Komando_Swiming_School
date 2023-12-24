import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:komando_app/data/models/data_models.dart';
import 'package:komando_app/data/repository/user_repository.dart';
import 'package:komando_app/data/source/firebase_datasource.dart';
import 'package:komando_app/helpers/helpers.dart';

class UserHelper {
  final FirebaseDataSource _dataSource =
      FirebaseDataSourceImpl(FirebaseFirestore.instance);

  Future<bool> addUser(String name, int age, String userName, String password,
      String mobileNumber, String address, bool isAdmin, int startTime) async {
    UserRepository repository = UserRepositoryImpl(_dataSource);
    ScheduleHelper scheduleHelper = ScheduleHelper();
    User newUser = User(
      name: name,
      age: age,
      userName: userName,
      password: password,
      mobileNumber: mobileNumber,
      address: address,
      isAdmin: isAdmin,
    );
    try {
      if (isAdmin) {
        await repository.saveUser(newUser);
        return true;
      } else {
        Schedule schedule =
            await scheduleHelper.getScheduleByStartTime(startTime);
        await repository.saveUser(newUser, schedule.id);
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<User>> getUsers() async {
    UserRepository userRepository = UserRepositoryImpl(_dataSource);
    final users = await userRepository.getUsers();
    return users;
  }
}
