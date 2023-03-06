import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kale/utils/shared_prefs.dart';
import 'package:kale/widgets/meal_rec.dart';
import 'package:kale/widgets/navbar.dart';
import 'package:intl/intl.dart';
import '../utils/apis.dart';
import '../utils/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

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
String d1 = "", d2 = "", d3 = "", d4 = "", d5 = "", dh = "";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController Pcontroller = PageController();
  int activeIndex = 0;
  bool isOnHome = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecs(SharedPrefs().id).whenComplete(() => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#8cc092"),
      body: PageView(
        controller: Pcontroller,
        onPageChanged: (index) => setState(() {
          activeIndex = index;
          isOnHome = !isOnHome;
        }),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                SizedBox(
                    width: 335,
                    height: 100,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: HexColor('064635'),
                            borderRadius: const BorderRadius.all(
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
                                              fontSize: 18,
                                              color: Colors.white)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 5, 30, 10),
                                      child: Text('Sidharth ',
                                          style: GoogleFonts.poppins(
                                              fontSize: 30,
                                              color: Colors.white)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(width: 30),
                            SizedBox(
                                width: 110,
                                height: 70,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: HexColor("#fcba03"),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(dt.day.toString(),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text(', ',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600)),
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
                const SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Select your meal: ',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    MealRec(
                      displayText: "Breakfast",
                      dish_one: "",
                      dish_two: "Dish 2",
                      dish_three: "Dish 3",
                      dish_four: "Dish 4",
                      dish_five: "Dish 5",
                      diningHall: "Epicuria",
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MealRec(
                      displayText: "Lunch",
                      dish_one: "",
                      dish_two: "Dish 2",
                      dish_three: "Dish 3",
                      dish_four: "Dish 4",
                      dish_five: "Dish 5",
                      diningHall: "Epicuria",
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MealRec(
                      displayText: "Dinner",
                      dish_one: d1,
                      dish_two: d2,
                      dish_three: d3,
                      dish_four: d4,
                      dish_five: d5,
                      diningHall: dh,
                    )
                  ],
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),
                SingleChildScrollView(
                  child: Column(children: []),
                )
              ],
            ),
          ),
          Column(children: [
            const SizedBox(height: 60),
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
          items: const [
            Icon(Icons.home, color: Colors.white),
          ]),
    );
  }

  Future getRecs(int user_id) async {
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    final form = [];
    form.add("user_id=$user_id");
    final body = form.join('&');

    final response = await http.post(Uri.parse(APIs.url_get_user_preference),
        headers: headers, body: body);
    final responseJSON = json.decode(response.body);
    if (responseJSON['error'] == false) {
      // SharedPrefs().id = responseJSON['user_id'];
      // SharedPrefs().phone_number = responseJSON['phone_number'];
      // SharedPrefs().first_name = responseJSON['first_name'];
      // SharedPrefs().last_name = responseJSON['last_name'];
      // SharedPrefs().gender = responseJSON['gender'];
      // ignore: use_build_context_synchronously
      String diningHall = responseJSON['dinner_dining_hall'];
      setState(() {
        dh = diningHall;
        d1 = responseJSON['dish_1'];
        d2 = responseJSON['dish_2'];
        d3 = responseJSON['dish_3'];
        d4 = responseJSON['dish_4'];
        d5 = responseJSON['dish_5'];
      });
      print("Sweet");
    }
  }
}
