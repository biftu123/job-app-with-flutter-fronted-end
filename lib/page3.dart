import 'package:flutter/material.dart';
import 'package:jobapp/logIn.dart';
import 'package:jobapp/signUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class page3 extends StatefulWidget {
  const page3({Key? key});

  @override
  State<page3> createState() => _page3State();
}

class _page3State extends State<page3> {
  late double containerHeight;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    containerHeight = screenSize.height * 0.6;

    return Scaffold(
      backgroundColor: Color.fromARGB(1, 228, 240, 225),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: containerHeight,
            child: Image.asset('assets/images/pag1.png'),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Find Your Dream Job',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
          Text(
              'we help you find dream job according \n to you skillset,location and preference to \n build your carrer ',
              style: TextStyle(color: Colors.grey, fontSize: 14)),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(

                  onPressed: ()async {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('entrypoint', true);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => LogIn()));
                  },
                  child: Text("LOGIN")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text("SIGNUP"))
            ],
          )
        ],
      ),
    );
  }
}
