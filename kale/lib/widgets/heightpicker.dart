import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


enum HeightUnit { ft, cm }

class Height extends StatefulWidget {
  @override
  _HeightState createState() => _HeightState();
}

class _HeightState extends State<Height> {
  HeightUnit selectedUnit = HeightUnit.ft;
  TextEditingController heightController = TextEditingController();
  int ft = 0;
  int inches = 0;
  late String cm;

  cmToInches(inchess) {
    ft = inchess ~/ 12;
    inches = inchess % 12;
    print('$ft feet and $inches inches');
  }

  inchesToCm() {
    int inchesTotal = (ft * 12) + inches;
    cm = (inchesTotal * 2.54).toStringAsPrecision(5);
    heightController.text = cm;
  }

  void checkHeightUnit() {
    if (selectedUnit == HeightUnit.ft) {
      setState(() {
        int inchess = (double.parse(heightController.text) ~/ 2.54).toInt();
        cmToInches(inchess);
        heightController.text = '$ft\' $inches"';
      });
    } else if (selectedUnit == HeightUnit.cm) {
      setState(() {
        print(heightController.text);
        inchesToCm();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Row(
      children: [
        Container(
          width: 168,
          child: TextFormField(
            onTap: selectedUnit == HeightUnit.ft
                ? () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 200,
                            color: Colors.grey,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: CupertinoPicker(
                                    itemExtent: 32.0,
                                    onSelectedItemChanged: (int index) {
                                      print(index + 1);
                                      setState(() {
                                        ft = (index + 1);
                                        heightController.text =
                                            "$ft' $inches\"";
                                      });
                                    },
                                    children: List.generate(12, (index) {
                                      return Center(
                                        child: Text('${index + 1}'),
                                      );
                                    }),
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Center(
                                        child: Text('ft',
                                            style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 16,
                                              color: Colors.black,
                                            )))),
                                Expanded(
                                  child: CupertinoPicker(
                                    itemExtent: 32.0,
                                    onSelectedItemChanged: (int index) {
                                      print(index);
                                      setState(() {
                                        inches = (index);
                                        heightController.text =
                                            "$ft' $inches\"";
                                      });
                                    },
                                    children: List.generate(12, (index) {
                                      return Center(
                                        child: Text('$index'),
                                      );
                                    }),
                                  ),
                                ),
                                const Expanded(
                                  flex: 3,
                                  child: Center(
                                      child: Text('inches',
                                          style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 16,
                                            color: Colors.black,
                                          ))),
                                )
                              ],
                            ),
                          );
                        });
                  }
                : null,
            controller: heightController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            cursorColor: Color(0xFF4C4ED7),
            decoration: InputDecoration(
                hintText: selectedUnit == HeightUnit.ft ? "__' __\"" : '__',
                hintStyle: TextStyle(color: Color(0xFF4C4ED7)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFF7401))),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFF7401)))),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
            ],
          ),
        ),
        const SizedBox(width: 25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (heightController.text.isEmpty) {
                  selectedUnit = HeightUnit.ft;
                } else {
                  selectedUnit = HeightUnit.ft;
                  checkHeightUnit();
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: selectedUnit == HeightUnit.ft
                      ? Color(0xFFFF7401)
                      : Colors.transparent,
                ),
                color: Colors.transparent,
              ),
              width: 31,
              height: 31,
              child: Center(child: Text('ft', style: TextStyle(fontSize: 16))),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (heightController.text.isEmpty) {
                  selectedUnit = HeightUnit.cm;
                } else {
                  selectedUnit = HeightUnit.cm;
                  checkHeightUnit();
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: selectedUnit == HeightUnit.cm
                      ? Color(0xFFFF7401)
                      : Colors.transparent,
                ),
                color: Colors.transparent,
              ),
              width: 31,
              height: 31,
              child: Center(child: Text('cm', style: TextStyle(fontSize: 16))),
            ),
          ),
        ),
      ],
    )));
  }
}