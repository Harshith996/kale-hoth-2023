import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

/////////////////////////////////////////////////////
// Alert Dialog
showAlertDialog(BuildContext context, message) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text(
      "OK",
      style: TextStyle(color: Colors.white),
    ),
    onPressed: () {
      Navigator.of(context).pop(); // dismiss dialog
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Error",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0))),
    contentPadding: const EdgeInsets.all(20.0),
    backgroundColor: HexColor("#064635"),
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
