import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/app_theme.dart';
import 'auth/ui/viewmodel/auth_controller.dart';
import 'auth/ui/pages/login_page.dart';
import 'home/ui/pages/content.dart';

final messengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        scaffoldMessengerKey: messengerKey,
        debugShowCheckedModeBanner: false,
        title: 'Authentication Flow',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        home: GetX<AuthController>(
          builder: (controller) {
            if (controller.logged) {
              return const Content();
            }
            return const LoginPage();
          },
        ));
  }
}
