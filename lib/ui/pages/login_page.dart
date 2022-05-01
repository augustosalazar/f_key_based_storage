import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthenticationController authenticationController = Get.find();
  TextEditingController nameController = TextEditingController();

  Future<void> loginUser() async {
    authenticationController.setLoggedIn(nameController.text);
    nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        TextField(
            textAlign: TextAlign.center,
            controller: nameController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Please enter your name',
            )),
        const SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: () {
            loginUser();
          },
          child: const Text('Login'),
        )
      ],
    ));
  }
}
