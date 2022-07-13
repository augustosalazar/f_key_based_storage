import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/use_case/authentication.dart';

class AuthenticationController extends GetxController {
  var _logged = false.obs;
  final Authentication _authentication = Get.find<Authentication>();

  void initializeRoute() async {
    logged = await _authentication.init;
  }

  AuthenticationController() {
    initializeRoute();
  }

  bool get logged => _logged.value;
  RxBool get xlogged => _logged;

  set logged(bool mode) {
    _logged.value = mode;
  }

  Future<bool> login(user, password) async {
    bool rta = await _authentication.login(user, password);
    if (rta) {
      logInfo("Login ok");
      _logged.value = true;
      return Future.value(true);
    }
    logInfo("Login nok");
    _logged.value = false;
    return Future.value(false);
  }

  Future<bool> signup(user, password) async {
    await _authentication.signup(user, password);
    return Future.value(true);
  }

  void logout() {
    _logged.value = false;
    _authentication.logout();
  }
}
