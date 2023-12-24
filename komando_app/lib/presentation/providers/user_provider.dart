import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:komando_app/data/models/data_models.dart';
import 'package:komando_app/helpers/helpers.dart';

final userConnectedProvider = StateProvider<User>(
  (ref) => User(
    id: '',
    name: 'name',
    age: 0,
    userName: 'userName',
    password: 'password',
    mobileNumber: 'mobileNumber',
    address: 'address',
    photo: 'https://placehold.co/600x800/png',
    isAdmin: false,
  ),
);

final usersListProvider = FutureProvider<List<User>>((ref) async {
  UserHelper userHelper = UserHelper();
  return await userHelper.getUsers();
});
