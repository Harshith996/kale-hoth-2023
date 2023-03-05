import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class WideDarkBackgroundButton extends StatelessWidget {
  const WideDarkBackgroundButton({
    super.key,
    required this.displayText,
    required this.onTap,
  });
  final String displayText;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return (Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(300, 60),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          backgroundColor: HexColor("fcba03"),
          // padding: const EdgeInsets.fromLTRB(60, 20, 60, 20),
        ),
        child: Text(
          displayText,
          style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500),
        ),
      ),
    ));
  }
}
