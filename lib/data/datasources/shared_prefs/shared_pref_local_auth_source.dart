import 'package:f_shared_prefs/domain/entities/user.dart';

import '../i_local_auth_source.dart';

class SharedPrefLocalAuthSource implements ILocalAuthSource {
  @override
  Future<String> getLoggedUser() {
    // TODO: implement getLoggedUser
    throw UnimplementedError();
  }

  @override
  Future<User> getUserFromEmail(email) {
    // TODO: implement getUserFromEmail
    throw UnimplementedError();
  }

  @override
  Future<bool> isLogged() {
    // TODO: implement isLogged
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> signup(email, password) {
    // TODO: implement signup
    throw UnimplementedError();
  }
}
