import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/local_preferences.dart';

class Authentication {
  final _sharedPreferences = LocalPreferences();

  Future<bool> get init async =>
      await _sharedPreferences.retrieveData<bool>('logged') ?? false;

  Future<bool> login(user, password) async {
    var savedUser = await _sharedPreferences.retrieveData<String>('user') ?? "";
    var savedPassword =
        await _sharedPreferences.retrieveData<String>('password') ?? "";
    if (savedUser == user && savedPassword == password) {
      await _sharedPreferences.storeData<bool>('logged', true);
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<void> signup(user, password) async {
    _sharedPreferences.storeData<String>('user', user).then((value) async =>
        _sharedPreferences
            .storeData<String>('password', password)
            .then((value) => print("Save ok")));
  }

  void logout() async {
    await _sharedPreferences.storeData<bool>('logged', false);
  }
}
