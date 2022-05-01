import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  AuthenticationController authenticationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text('Welcome ${authenticationController.user}'),
        ElevatedButton(
          onPressed: () {
            authenticationController.setLoggedOut();
          },
          child: const Text('logout'),
        )
      ],
    ));
  }
}
