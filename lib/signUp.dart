import 'package:flutter/material.dart';
import 'package:jobapp/controller/logInNotifier.dart';
import 'package:jobapp/controller/signUpNotifier.dart';
import 'package:jobapp/logIn.dart';
import 'package:jobapp/model/request/signuprequstmodel.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>(); // Key for the Form widget
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loginnotifier = Provider.of<logInNotfier>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'SIGNUP',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Consumer<signUpNotfier>(builder: (context, signUpNotfier, child) {
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
                  Text("Fill in the signup form"),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
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
                    obscureText: signUpNotfier.obscureText,
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
                            signUpNotfier.obscureText =
                                !signUpNotfier.obscureText;
                          },
                          icon: signUpNotfier.obscureText
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
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
                        Signupmodel model = Signupmodel(
                            username: name.text,
                            email: email.text,
                            password: password.text);
                        signUpNotfier.userSignUp(context, model);
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
                      Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          loginnotifier.firsttime = !loginnotifier.firsttime;
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => LogIn()));
                        },
                        child: Text('Login'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
