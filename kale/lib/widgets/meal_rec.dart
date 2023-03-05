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
  double boxHeight = 75;
  bool opened = false;
  double angle = 0;

  void _expandBox() {
    setState(() {
      if (opened) {
        opened = false;
        angle = 0;
        boxHeight = 75;
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
          width: 300,
          child: DecoratedBox(
              decoration: BoxDecoration(
                color: HexColor('064635'),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                child: Text(widget.displayText,
                    style: GoogleFonts.poppins
                    (
                      fontSize: 20, 
                      color: Colors.white
                    )),
              )),
        ));
  }
}