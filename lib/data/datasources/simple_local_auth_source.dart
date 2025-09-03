import 'package:f_shared_prefs/domain/entities/user.dart';
import 'package:get/get.dart';

import '../../core/i_local_preferences.dart';
import 'i_local_auth_source.dart';

class SimpleLocalAuthSource implements ILocalAuthSource {
  final ILocalPreferences _source = Get.find();

  @override
  Future<String> getLoggedUser() async {
    return await _source.retrieveData<String>('user') ?? "noUser";
  }

  @override
  Future<User> getUserFromEmail(email) async {
    String user = await _source.retrieveData<String>('user') ?? "";
    String password = await _source.retrieveData<String>('password') ?? "";
    if (user == email) {
      return User(email: user, password: password);
    }
    throw "User not found";
  }

  @override
  Future<bool> isLogged() async {
    return await _source.retrieveData<bool>('logged') ?? false;
  }

  @override
  Future<void> logout() async {
    await _source.storeData('logged', false);
  }

  @override
  Future<void> signup(email, password) async {
    await _source.storeData('user', email);
    await _source.storeData('password', password);
  }

  @override
  Future<void> setLoggedIn() async {
    await _source.storeData('logged', false);
  }
}
