import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jobapp/controller/imageUploader.dart';
import 'package:jobapp/controller/logInNotifier.dart';
import 'package:jobapp/controller/onbordnotifier.dart';
import 'package:jobapp/controller/signUpNotifier.dart';
import 'package:jobapp/drawer/ZoomNotifier.dart';
import 'package:jobapp/logIn.dart';
import 'package:jobapp/mainScreen.dart';
import 'package:jobapp/onboard.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
Widget DefaultWidget = const Onboard();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final entrypoint = prefs.getBool('entrypoint') ?? false;
  final loggIn = prefs.getBool('loggIn') ?? false;
  if (entrypoint && !loggIn) {
    DefaultWidget = const LogIn();
    // ignore: curly_braces_in_flow_control_structures
  } else if (entrypoint && loggIn) {
    DefaultWidget = const mainScreen();
  } else
    () {
      DefaultWidget = const Onboard();
    };
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
        ChangeNotifierProvider(create: (_) => ZoomNotifier()),
         ChangeNotifierProvider(create: (_) => imageUploader()),
        
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultWidget ,
      ),
    );
  }
}
