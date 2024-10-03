import 'package:loggy/loggy.dart';
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
      await _sharedPreferences.storeData('logged', true);
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<void> signup(user, password) async {
    _sharedPreferences.storeData('user', user).then((value) async =>
        _sharedPreferences
            .storeData('password', password)
            .then((value) => logInfo("Save ok")));
  }

  void logout() async {
    await _sharedPreferences.storeData('logged', false);
  }
}
