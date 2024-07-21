// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class Messagetextfield extends StatelessWidget {
  const Messagetextfield({
    Key? key,
    required this.message,
    required this.suffixIcon,
    required this.onChanged,
   required this.onEditingComplete,
   required this.onTapOutside,
    required this.onSubmitted,
  }) : super(key: key);
  final TextEditingController message;
  final Widget suffixIcon;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(PointerDownEvent) ? onTapOutside;
  final void Function(String)?onSubmitted ;
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.orange,
      controller: message,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(6),
        filled: true,
        suffixIcon: suffixIcon,
        hintText:"type your message here",
         border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 2,
                        ),
                      )
      ),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onTapOutside: onTapOutside,
      onSubmitted: onSubmitted,
      
      
    );
  }
}
