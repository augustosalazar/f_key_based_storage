import 'package:f_shared_prefs/ui/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthenticationController());
  runApp(const MyApp());
}
