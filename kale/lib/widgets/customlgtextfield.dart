import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyLGTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;
  final TextInputType inputType;

  const MyLGTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: SizedBox(
        width: 350,
        height: 50,

        child:
          TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: inputType,
            decoration: InputDecoration(
              fillColor: HexColor('D1E5D3'),

                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                filled: true,
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.grey,
                height:3.5))),
          ),
    );
  }
}
