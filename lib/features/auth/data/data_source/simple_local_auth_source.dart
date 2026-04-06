import 'package:f_shared_prefs/features/auth/domain/entities/user.dart';
import 'package:get/get.dart';

import '../../../../core/i_local_preferences.dart';
import 'i_local_auth_source.dart';

class SimpleLocalAuthSource implements ILocalAuthSource {
  final ILocalPreferences _source = Get.find();

  @override
  Future<String> getLoggedUser() async {
    return await _source.getString('user') ?? "no user";
  }

  @override
  Future<User> getUserFromEmail(email) async {
    String user = await _source.getString('user') ?? "";
    String password = await _source.getString('password') ?? "";
    if (user == email) {
      return User(email: user, password: password);
    }
    throw "User not found";
  }

  @override
  Future<bool> isLogged() async {
    return await _source.getBool('logged') ?? false;
  }

  @override
  Future<void> logout() async {
    await _source.setBool('logged', false);
  }

  @override
  Future<void> signup(email, password) async {
    await _source.setString('user', email);
    await _source.setString('password', password);
  }

  @override
  Future<void> setLoggedIn() async {
    await _source.setBool('logged', true);
  }
}
