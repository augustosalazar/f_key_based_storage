import 'package:f_shared_prefs/core/local_preferences_secured.dart';
import 'package:f_shared_prefs/domain/repositories/i_auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'core/i_local_preferences.dart';
import 'core/local_preferences_shared.dart';
import 'data/datasources/i_local_auth_source.dart';
import 'data/datasources/shared_pref_local_auth_source.dart';
import 'data/repositories/auth_repo.dart';
import 'domain/use_case/auth_use_case.dart';
import 'ui/controllers/auth_controller.dart';
import 'ui/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );

  //Get.put<ILocalPreferences>(LocalPreferencesShared());
  Get.put<ILocalPreferences>(LocalPreferencesSecured());
  Get.put<ILocalAuthSource>(SharedPrefLocalAuthSource());
  Get.put<IAuthRepo>(AuthRepo(Get.find()));
  Get.put(AuthUseCase(Get.find()));
  Get.put(AuthController(Get.find()));
  runApp(const MyApp());
}
