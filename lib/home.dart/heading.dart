// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class heading extends StatelessWidget {
  const heading({
    Key? key,
    this.OnTap,
    required this.text,
  }) : super(key: key);
  final void Function()? OnTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: OnTap,
          child: Text(
            'view all',
            style: TextStyle(color: Colors.orange),
          ),
        )
      ],
    );
  }
}
