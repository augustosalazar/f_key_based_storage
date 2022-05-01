import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationController extends GetxController {
  var _logged = false.obs;
  String _user = "";

  @override
  void onInit() {
    _readSharedPreferences();
    super.onInit();
  }

  String get user => _user;

  bool get getLogged => _logged.value;

  Future<void> setLoggedIn(userName) async {
    _logged.value = true;
    _user = userName;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('_logged', _logged.value);
    prefs.setString('_user', userName);
  }

  _readSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final sharedLogged = prefs.getBool('_logged') ?? false;
    _logged.value = sharedLogged;
  }

  Future<void> setLoggedOut() async {
    _logged.value = false;

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('_logged', _logged.value);
  }
}
