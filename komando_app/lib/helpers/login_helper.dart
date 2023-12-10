import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:komando_app/data/models/data_models.dart';
import 'package:komando_app/data/repository/user_repository.dart';
import 'package:komando_app/data/source/firebase_datasource.dart';
import 'package:komando_app/presentation/providers/user_provider.dart';
import 'package:komando_app/presentation/utils/variables.dart';

class LoginHelper {
  Future<bool> login(String userName, String password, WidgetRef ref) async {
    bool exist = false;
    FirebaseDataSource source =
        FirebaseDataSourceImpl(FirebaseFirestore.instance);
    UserRepository repository = UserRepositoryImpl(source);
    List<User> users = await repository.getUsers();
    User userFound = users.firstWhere((user) => user.userName == userName,
        orElse: () => userEmpty);
    if (userFound.name != 'name') {
      if (userFound.password == password) {
        ref.read(userConnectedProvider.notifier).update((state) => userFound);
        exist = true;
      }
    }
    return exist;
  }
}
