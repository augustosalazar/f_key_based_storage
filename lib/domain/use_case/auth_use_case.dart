import 'package:f_shared_prefs/domain/repositories/i_auth_repo.dart';
import 'package:loggy/loggy.dart';
import '../../data/datasources/local_preferences.dart';

class AuthUseCase {
  final _sharedPreferences = LocalPreferences();
  final IAuthRepo _authenticationRepo;

  AuthUseCase(this._authenticationRepo);

  Future<bool> get init async =>
      await _sharedPreferences.retrieveData<bool>('logged') ?? false;

  Future<void> login(email, password) async {
    var savedUser = await _sharedPreferences.retrieveData<String>('user') ?? "";
    var savedPassword =
        await _sharedPreferences.retrieveData<String>('password') ?? "";
    if (savedUser == email && savedPassword == password) {
      await _sharedPreferences.storeData('logged', true);
      return Future.value(true);
    }
    throw "Login nok";
  }

  Future<void> signup(email, password) async {
    _sharedPreferences.storeData('user', email).then((value) async =>
        _sharedPreferences
            .storeData('password', password)
            .then((value) => logInfo("Save ok")));
    throw "User already exists";
  }

  Future<void> logout() async {
    await _sharedPreferences.storeData('logged', false);
  }
}
