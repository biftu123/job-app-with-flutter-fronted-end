// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class deviceInfo extends StatelessWidget {
  const deviceInfo({
    Key? key,
    required this.date,
    required this.Ipaddress,
    required this.platform,
    required this.device,
    required this.location,
  }) : super(key: key);

  final String date;
  final String Ipaddress;
  final String platform;
  final String device;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          device,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          platform,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Row(children: [
          Column(
            children: [
              Text(
                date,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              Text(
                Ipaddress,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Sign out',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          )
        ]),
      ],
    );
  }
}
