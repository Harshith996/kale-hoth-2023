import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kale/main.dart';
import 'package:kale/screen/homepage.dart';
import 'package:kale/utils/apis.dart';
import 'package:kale/utils/common_ui.dart';
import 'package:kale/widgets/customlgtextfield.dart';
import 'package:http/http.dart' as http;
import 'package:vertical_picker/vertical_picker.dart';
import 'dart:convert';

import '../widgets/custombutton.dart';
import '../widgets/customlgtextfield.dart';

const List<String> genders = <String>['Male', 'Female', 'Other'];

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final weightController = TextEditingController();
  final sexController = TextEditingController();
  final PageController controller = PageController();
  String? gender = null;

  int chosenHealthIndex = -2;
  int chosenSustainabilityPlan = -2;
  int feet = 0;
  int inches = 0;
  int selectedGenderIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 65),
        color: HexColor("#064635"),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            Container(
                decoration: BoxDecoration(
                    color: HexColor('#8cc092'),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: 60,
                                        width: 161,
                                        child: Image.asset(
                                            'assets/dark_logo_text.png')),
                                  ],
                                ),
                                SizedBox(height: 22),
                                Text('First Name: ',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15.5,
                                      color: HexColor("#404040"),
                                    )),
                                const SizedBox(height: 5),
                                MyLGTextField(
                                    controller: fnameController,
                                    hintText: 'John',
                                    obscureText: false,
                                    inputType: TextInputType.name),
                                const SizedBox(height: 25),
                                Text('Last Name:',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15.5,
                                      color: HexColor("#404040"),
                                    )),
                                const SizedBox(height: 5),
                                MyLGTextField(
                                    controller: lnameController,
                                    hintText: 'Doe',
                                    obscureText: false,
                                    inputType: TextInputType.name),
                                const SizedBox(height: 25),
                                Text('UCLA Email ID: ',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15.5,
                                      color: HexColor("#404040"),
                                    )),
                                const SizedBox(height: 5),
                                MyLGTextField(
                                    controller: emailController,
                                    hintText: 'johndoe@g.ucla.edu',
                                    obscureText: false,
                                    inputType: TextInputType.emailAddress),
                                const SizedBox(height: 27),
                                Text('Create your password: ',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15.5,
                                      color: HexColor("#404040"),
                                    )),
                                const SizedBox(height: 5),
                                MyLGTextField(
                                    controller: passwordController,
                                    hintText: '***************',
                                    obscureText: true,
                                    inputType: TextInputType.visiblePassword),
                                const SizedBox(height: 38),
                                WideDarkBackgroundButton(
                                    displayText: 'Sign Up',
                                    onTap: () {
                                      signupUser(
                                          emailController.text,
                                          fnameController.text,
                                          lnameController.text,
                                          passwordController.text,
                                          context,
                                          controller);
                                    }),
                              ]))
                    ],
                  ),
                )),
            Container(
              decoration: BoxDecoration(
                  color: HexColor('8cc092'),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(30, 29, 30, 30),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: 60,
                                      width: 161,
                                      child: Image.asset(
                                          'assets/dark_logo_text.png')),
                                ],
                              ),
                              SizedBox(height: 22),
                              Text('Height:',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15.5,
                                    color: HexColor("#404040"),
                                  )),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 60,
                                      ),
                                      SizedBox(
                                          width: 40,
                                          child: VerticalPicker(
                                              borderColor: HexColor('#064635'),
                                              items: List.generate(
                                                  10,
                                                  (index) => Center(
                                                        child: Text(
                                                            index.toString()),
                                                      )),
                                              onSelectedChanged:
                                                  (indexSelected) {
                                                feet = indexSelected;
                                              },
                                              itemHeight: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  15)),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text('ft',
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                          )),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      SizedBox(
                                          width: 40,
                                          child: VerticalPicker(
                                              borderColor: HexColor('#064635'),
                                              items: List.generate(
                                                  10,
                                                  (index) => Center(
                                                        child: Text(
                                                            index.toString()),
                                                      )),
                                              onSelectedChanged:
                                                  (indexSelected) {
                                                inches = indexSelected;
                                              },
                                              itemHeight: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  15)),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text('in',
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 23),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Weight:',
                                          style: GoogleFonts.poppins(
                                            fontSize: 15.5,
                                            color: HexColor("#404040"),
                                          )),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          SizedBox(width: 10),
                                          SizedBox(
                                              width: 84,
                                              child: MyLGTextField(
                                                  controller: weightController,
                                                  hintText: 'Eg: 120',
                                                  obscureText: false,
                                                  inputType:
                                                      TextInputType.number)),
                                          SizedBox(width: 10),
                                          Text('lbs',
                                              style: GoogleFonts.poppins(
                                                fontSize: 15,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 40),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Sex: ',
                                          style: GoogleFonts.poppins(
                                            fontSize: 15.5,
                                            color: HexColor("#404040"),
                                          )),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          SizedBox(width: 15),
                                          SizedBox(
                                              width: 95,
                                              child: DropdownButton<String>(
                                                isExpanded: true,
                                                value: gender,
                                                elevation: 16,
                                                dropdownColor:
                                                    HexColor('064635'),
                                                style: TextStyle(
                                                    color: HexColor('064635'),
                                                    fontSize: 18),
                                                underline: Container(
                                                  height: 1,
                                                  color: HexColor('064635'),
                                                ),
                                                hint: Text('Select sex',
                                                    style: GoogleFonts.poppins(
                                                        color:
                                                            HexColor('064635'),
                                                        fontSize: 15)),
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    gender = value!;
                                                    selectedGenderIndex =
                                                        genders.indexOf(value);
                                                  });
                                                },
                                                items: genders.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              )),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 24),
                              Text(
                                'Select your desired Health Plan:',
                                style: GoogleFonts.poppins(
                                    fontSize: 15.5, color: HexColor("#404040")),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          chosenHealthIndex = -1;
                                        });
                                      },
                                      child: chosenHealthIndex != -1
                                          ? SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: DecoratedBox(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Image.asset(
                                                        "assets/lovenull.png"),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: HexColor("F4EEA9"),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10)))))
                                          : SizedBox(
                                              height: 80,
                                              width: 80,
                                              child: DecoratedBox(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Image.asset(
                                                        "assets/lovenull.png"),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: HexColor("F4EEA9"),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10)))))),
                                  const SizedBox(width: 40),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          chosenHealthIndex = 0;
                                        });
                                      },
                                      child: chosenHealthIndex != 0
                                          ? SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: HexColor("F4EEA9"),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Image.asset(
                                                        "assets/lovehalf.png"),
                                                  )))
                                          : SizedBox(
                                              height: 80,
                                              width: 80,
                                              child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: HexColor("F4EEA9"),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Image.asset(
                                                        "assets/lovehalf.png"),
                                                  )))),
                                  SizedBox(width: 40),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          chosenHealthIndex = 1;
                                        });
                                      },
                                      child: chosenHealthIndex != 1
                                          ? SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: HexColor("F4EEA9"),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Image.asset(
                                                        "assets/lovefull.png"),
                                                  )))
                                          : SizedBox(
                                              height: 80,
                                              width: 80,
                                              child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: HexColor("F4EEA9"),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Image.asset(
                                                        "assets/lovefull.png"),
                                                  ))))
                                ],
                              ),
                              SizedBox(height: 24),
                              Text(
                                'Select your desire Sustainability Plan:',
                                style: GoogleFonts.poppins(
                                    fontSize: 15.5, color: HexColor("#404040")),
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          chosenSustainabilityPlan = -1;
                                        });
                                      },
                                      child: chosenSustainabilityPlan != -1
                                          ? SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: HexColor("F4EEA9"),
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Image.asset(
                                                      "assets/greennull.png")))
                                          : SizedBox(
                                              height: 80,
                                              width: 80,
                                              child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: HexColor("F4EEA9"),
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(10))),
                                                  child: Image.asset("assets/greennull.png")))),
                                  SizedBox(width: 40),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          chosenSustainabilityPlan = 0;
                                        });
                                      },
                                      child: chosenSustainabilityPlan != 0
                                          ? SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: HexColor("F4EEA9"),
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Image.asset(
                                                      "assets/greenhalf.png")))
                                          : SizedBox(
                                              height: 80,
                                              width: 80,
                                              child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: HexColor("F4EEA9"),
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(10))),
                                                  child: Image.asset("assets/greenhalf.png")))),
                                  const SizedBox(width: 40),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          chosenSustainabilityPlan = 1;
                                        });
                                      },
                                      child: chosenSustainabilityPlan != 1
                                          ? SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: HexColor("F4EEA9"),
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Image.asset(
                                                      "assets/greenfull.png")))
                                          : SizedBox(
                                              height: 80,
                                              width: 80,
                                              child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: HexColor("F4EEA9"),
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(10))),
                                                  child: Image.asset("assets/greenfull.png"))))
                                ],
                              ),
                            ])),
                    Row(
                      children: [
                        // SizedBox(
                        //   width: 170,
                        //   child: WideDarkBackgroundButton(
                        //     displayText: 'Back',
                        //     onTap: () => Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => const SignUpPage(),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                            width: 350,
                            child: WideDarkBackgroundButton(
                              displayText: 'Get Your Meal Plan',
                              onTap: () {
                                int height = (feet * 12) + (inches);
                                recordUserPreferences(
                                    1,
                                    height,
                                    weightController.text,
                                    selectedGenderIndex,
                                    chosenHealthIndex,
                                    chosenSustainabilityPlan,
                                    context);
                              },
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Future signupUser(
      String email,
      String first_name,
      String last_name,
      String password,
      BuildContext context,
      PageController pageController) async {
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    final form = [];
    form.add("email=$email");
    form.add("first_name=$first_name");
    form.add("last_name=$last_name");
    form.add("password=$password");
    final body = form.join('&');

    final response = await http.post(Uri.parse(APIs.url_signup),
        headers: headers, body: body);
    final responseJSON = json.decode(response.body);
    if (responseJSON['error'] == false) {
      // SharedPrefs().id = responseJSON['user_id'];
      // SharedPrefs().phone_number = responseJSON['phone_number'];
      // SharedPrefs().first_name = responseJSON['first_name'];
      // SharedPrefs().last_name = responseJSON['last_name'];
      // SharedPrefs().gender = responseJSON['gender'];
      // ignore: use_build_context_synchronously
      pageController.nextPage(
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);

      print("Sweet");
    } else {
      showAlertDialog(context, responseJSON['message']);
    }
  }

  Future recordUserPreferences(int user_id, int height, String weight, int sex,
      int health_index, int carbon_index, BuildContext context) async {
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    final form = [];
    form.add("user_id=$user_id");
    form.add("height=$height");
    form.add("weight=$weight");
    form.add("sex=$sex");
    form.add("health_index=$health_index");
    form.add("carbon_index=$carbon_index");
    final body = form.join('&');

    final response = await http.post(Uri.parse(APIs.url_record_user_preference),
        headers: headers, body: body);
    final responseJSON = json.decode(response.body);
    if (responseJSON['error'] == false) {
      // SharedPrefs().id = responseJSON['user_id'];
      // SharedPrefs().phone_number = responseJSON['phone_number'];
      // SharedPrefs().first_name = responseJSON['first_name'];
      // SharedPrefs().last_name = responseJSON['last_name'];
      // SharedPrefs().gender = responseJSON['gender'];
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => const Home(),
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 1000),
        ),
      );
      print("Sweet");
    } else {
      showAlertDialog(context, responseJSON['message']);
    }
  }
}
