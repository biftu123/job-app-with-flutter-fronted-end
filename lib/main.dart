import 'package:flutter/material.dart';
import 'package:jobapp/controller/logInNotifier.dart';
import 'package:jobapp/controller/onbordnotifier.dart';
import 'package:jobapp/controller/signUpNotifier.dart';
import 'package:jobapp/drawer/ZoomNotifier.dart';
import 'package:jobapp/onboard.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnbordNotifier()),
        ChangeNotifierProvider(create: (_) => logInNotfier()),
        ChangeNotifierProvider(create: (_) => signUpNotfier()),
        ChangeNotifierProvider(create: (_) => ZoomNotifier())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Onboard(),
      ),
    );
  }
}
