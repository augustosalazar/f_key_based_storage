import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/authentication_controller.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  AuthenticationController controller = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('loginScaffold'),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Web-specific styling when the screen width is larger than 800 pixels
          return Center(
            child: Container(
              width: constraints.maxWidth > 800 ? 800 : double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: constraints.maxWidth > 800
                  ? BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    )
                  : null,
              child: _buildLoginForm(),
            ),
          );
        },
      ),
      backgroundColor: Colors.blueGrey[50], // Background for web separation
    );
  }

  Widget _buildLoginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Login with email",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  key: const Key('loginEmail'),
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter email";
                    } else if (!value.contains('@')) {
                      return "Enter valid email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  key: const Key('loginPassword'),
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: "Password"),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter password";
                    } else if (value.length < 6) {
                      return "Password should have at least 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  key: const Key('loginSubmit'),
                  onPressed: () async {
                    // dismiss keyboard
                    FocusScope.of(context).unfocus();
                    final form = _formKey.currentState;
                    if (form!.validate()) {
                      var value = await controller.login(
                          _emailController.text, _passwordController.text);
                      if (value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('User ok')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('User problem')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Validation nok')));
                    }
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
        TextButton(
          key: const Key('loginCreateUser'),
          onPressed: () {
            Get.to(() => const SignUpPage());
          },
          child: const Text("Create user"),
        ),
      ],
    );
  }
}
