import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/app_theme.dart';
import 'controllers/auth_controller.dart';
import 'pages/authentication/login_page.dart';
import 'pages/home/content.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
