import 'package:flutter/material.dart';

class page2 extends StatefulWidget {
  const page2({Key? key});

  @override
  State<page2> createState() => _page2State();
}

class _page2State extends State<page2> {
  late double containerHeight;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    containerHeight = screenSize.height * 0.6;

    return Scaffold(
      backgroundColor: Color.fromARGB(1, 228, 240, 225),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: containerHeight,
              child: Image.asset('assets/images/page1.jpg'),
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
                style: TextStyle(color: Colors.grey, fontSize: 14))
          ],
        ),
      ),
    );
  }
}
