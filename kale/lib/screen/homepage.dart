import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kale/widgets/meal_rec.dart';
import 'package:kale/widgets/navbar.dart';
import 'package:intl/intl.dart';
import '../utils/models.dart';

var dt = DateTime.now();

const List<String> months = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];
List<Meal> meals = <Meal>[
  Meal(id: 1, name: "Chicken", health_index: 2, carbon_index: 0),
  Meal(id: 2, name: "Sandwich", health_index: 2, carbon_index: 1),
  Meal(id: 3, name: "Pork", health_index: 0, carbon_index: -1),
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController Pcontroller = PageController();
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#8cc092"),
      body: PageView(
        controller: Pcontroller,
        onPageChanged: (index) => setState(() => activeIndex = index),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              SizedBox(
                  width: 335,
                  height: 100,
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: HexColor('064635'),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          )),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 14, 20, 0),
                                    child: Text('Good Morning, ',
                                        style: GoogleFonts.poppins(
                                            fontSize: 18, color: Colors.white)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 5, 30, 10),
                                    child: Text('Sidharth ',
                                        style: GoogleFonts.poppins(
                                            fontSize: 30, color: Colors.white)),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(width: 30),
                          SizedBox(
                              width: 110,
                              height: 70,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: HexColor("#fcba03"),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(dt.day.toString(),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600)),
                                          Text(', ',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600)),
                                          Text(
                                            months[dt.month - 1],
                                            style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            DateFormat('EEEE').format(dt),
                                            style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ))),
              const SizedBox(height: 60),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  MealRec(
                    displayText: "Breakfast",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MealRec(
                    displayText: "Lunch",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MealRec(
                    displayText: "Dinner",
                  )
                ],
              )
            ],
          ),
          Column(
            children: [
              SizedBox(height: 60),
              Text(
                "Page 2",
                style: GoogleFonts.poppins(fontSize: 40, color: Colors.black),
              )
            ],
          ),
          Column(children: [
            SizedBox(height: 60),
            Text(
              "Page 3",
              style: GoogleFonts.poppins(fontSize: 40, color: Colors.black),
            )
          ]),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
          height: 75,
          backgroundColor: HexColor("#8cc092"),
          color: HexColor("#064635"),
          animationDuration: const Duration(milliseconds: 250),
          onTap: (index) {
            Pcontroller.animateToPage(index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn);
          },
          items: [
            Icon(Icons.home, color: Colors.white),
            Icon(Icons.public, color: Colors.white),
            Icon(Icons.person, color: Colors.white)
          ]),
    );
  }
}
