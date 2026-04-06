import 'package:f_shared_prefs/core/local_preferences_shared.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:f_shared_prefs/core/local_preferences_secured.dart';
import 'package:f_shared_prefs/features/auth/domain/repositories/i_auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'core/i_local_preferences.dart';
import 'features/auth/data/data_source/i_local_auth_source.dart';
import 'features/auth/data/data_source/simple_local_auth_source.dart';
import 'features/auth/data/repositories/auth_repo.dart';
import 'features/auth/domain/use_case/auth_use_case.dart';
import 'features/auth/ui/viewmodel/auth_controller.dart';
import 'features/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );

  if (!kIsWeb) {
    Get.put<ILocalPreferences>(LocalPreferencesSecured());
  } else {
    Get.put<ILocalPreferences>(LocalPreferencesShared());
  }
  Get.put<ILocalAuthSource>(SimpleLocalAuthSource());
  Get.put<IAuthRepo>(AuthRepo(Get.find()));
  Get.put(AuthUseCase(Get.find()));
  Get.put(AuthController(Get.find()));
  runApp(const MyApp());
}
