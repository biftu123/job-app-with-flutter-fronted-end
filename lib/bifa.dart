// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:flutter/material.dart';

class Bifa extends StatelessWidget {
  const Bifa({
    Key? key,
    required this.text,
  }) : super(key: key);
  // ignore: empty_constructor_bodies
  final String text;
  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/search.jpg'),
            SizedBox(
              height: 20,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
  }
}
