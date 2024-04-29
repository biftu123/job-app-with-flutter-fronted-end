import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jobapp/controller/logInNotifier.dart';
import 'package:jobapp/model/request/loginrequst.dart';
import 'package:provider/provider.dart';
import 'package:jobapp/signUp.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>(); // Key for the Form widget

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LOGIN',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading:IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Get.back(),
      ),
      ),
      body: Consumer<logInNotfier>(
        builder: (context, logInNotifier, _) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey, // Assign the key to the Form
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "WELCOME BACK",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const Text("Fill in the login form"),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: password,
                    obscureText: logInNotifier.obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 2,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          logInNotifier.obscureText =
                              !logInNotifier.obscureText;
                        },
                        icon: Icon(logInNotifier.obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Please enter at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle form submission logic (e.g., register user)
                        Login model =
                            Login(email: email.text, password: password.text);
                        logInNotifier.userlogin(model);
                      } else {
                         Get.snackbar('Failedlogin', "your are Failed login",
            snackPosition:
                SnackPosition.TOP, // Optional: Set position (default is BOTTOM)
            backgroundColor: Color.fromRGBO(
                243, 33, 33, 1), // Optional: Set background color
            duration: Duration(seconds: 2));
                      }
                    },
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Get.off(SignUp());
                        },
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
