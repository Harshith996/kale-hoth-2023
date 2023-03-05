import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:math' as math;

class MealRec extends StatefulWidget {
  const MealRec({super.key, required this.displayText});
  final String displayText;

  @override
  State<MealRec> createState() => _MealRecState();
}

class _MealRecState extends State<MealRec> {
  double boxHeight = 100;
  bool opened = false;
  double angle = 0;

  void _expandBox() {
    setState(() {
      if (opened) {
        opened = false;
        angle = 0;
        boxHeight = 100;
      } else {
        opened = true;
        angle = math.pi / 2;
        boxHeight = 250;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _expandBox,
        child: SizedBox(
          height: boxHeight,
          width: 335,
          child: DecoratedBox(
              decoration: BoxDecoration(color: HexColor('0D9A75')),
              child: Text(widget.displayText,
                  style:
                      GoogleFonts.poppins(fontSize: 20, color: Colors.white))),
        ));
  }
}
