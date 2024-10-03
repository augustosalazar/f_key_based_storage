import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/authentication_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthenticationController controller = Get.find();
    return Scaffold(
      key: const Key('signUpScaffold'),
      body: LayoutBuilder(
        builder: (context, constraints) {
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
                          offset: const Offset(0, 3),
                        ),
                      ],
                    )
                  : null,
              child: _buildSignUpForm(controller),
            ),
          );
        },
      ),
      backgroundColor: Colors.blueGrey[50], // Background for separation
    );
  }

  Widget _buildSignUpForm(AuthenticationController controller) {
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
                  "Create User",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  key: const Key('signUpEmail'),
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
                  key: const Key('signUpPassword'),
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
                  key: const Key('signUpSubmit'),
                  onPressed: () {
                    // Dismiss the keyboard
                    FocusScope.of(context).unfocus();
                    final form = _formKey.currentState;
                    form!.save();
                    if (form.validate()) {
                      controller
                          .signup(
                              _emailController.text, _passwordController.text)
                          .then((value) {
                        if (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('User ok')));
                          Get.back();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('User problem')));
                        }
                      });
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
      ],
    );
  }
}
