import 'package:flutter/material.dart';
import 'package:jobapp/controller/logInNotifier.dart';
import 'package:jobapp/mainScreen.dart';
import 'package:provider/provider.dart';
import 'package:jobapp/signUp.dart';

class logIn extends StatefulWidget {
  const logIn({Key? key});

  @override
  State<logIn> createState() => _logInState();
}

class _logInState extends State<logIn> {
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
        title: Text(
          'LOGIN',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<logInNotfier>(
        builder: (context, logInNotifier, _) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey, // Assign the key to the Form
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "WELCOME BACK",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text("Fill in the login form"),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
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
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: logInNotifier.obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
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
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle form submission logic (e.g., register user)
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => mainScreen()));
                      }
                    },
                    child: Text('SignUp'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ));
                        },
                        child: Text('Sign Up'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
