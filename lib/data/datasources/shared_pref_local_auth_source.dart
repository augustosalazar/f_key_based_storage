import 'package:f_shared_prefs/domain/entities/user.dart';
import 'package:get/get.dart';

import '../../core/i_local_preferences.dart';
import 'i_local_auth_source.dart';
import '../../core/local_preferences_shared.dart';

class SharedPrefLocalAuthSource implements ILocalAuthSource {
  final ILocalPreferences _sharedPreferences = Get.find();

  @override
  Future<String> getLoggedUser() async {
    return await _sharedPreferences.retrieveData<String>('user') ?? "noUser";
  }

  @override
  Future<User> getUserFromEmail(email) async {
    String user = await _sharedPreferences.retrieveData<String>('user') ?? "";
    String password =
        await _sharedPreferences.retrieveData<String>('password') ?? "";
    if (user == email) {
      return User(email: user, password: password);
    }
    throw "User not found";
  }

  @override
  Future<bool> isLogged() async {
    return await _sharedPreferences.retrieveData<bool>('logged') ?? false;
  }

  @override
  Future<void> logout() async {
    await _sharedPreferences.storeData('logged', false);
  }

  @override
  Future<void> signup(email, password) async {
    await _sharedPreferences.storeData('user', email);
    await _sharedPreferences.storeData('password', password);
  }

  @override
  Future<void> setLoggedIn() async {
    await _sharedPreferences.storeData('logged', false);
  }
}
