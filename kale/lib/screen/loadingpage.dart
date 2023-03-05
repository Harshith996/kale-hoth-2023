import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kale/widgets/custombutton.dart';
import 'package:kale/widgets/customlgtextfield.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: HexColor("#064635"),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
          shrinkWrap: true,
          reverse: true,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 110,
                ),
                  SizedBox(
                  height: 100,
                  width: 100,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(20))

                    ),
                    child: Image.asset('assets/logo.png')

                    ),
                  
                   
                ),
                SizedBox(
                  height: 20
                ),
                SizedBox(
                  height: 80,
                  width: 214,
                  child: DecoratedBox(
                    decoration: BoxDecoration(

                    ),
                    child: Image.asset('assets/light_logo_text.png'))),
                const SizedBox(height: 80),
                Stack(
                  children: [
                    Container(
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration (
                        color:HexColor("8cc092"),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 2),
                        child: Column(
                          children: [
                            SizedBox(
                              height:20
                            ),
                            SizedBox(
                              width: 250,
                              child: Text(
                                'Your UCLA Sustainability and Health Companion',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: HexColor('064635'),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 45),
                            WideDarkBackgroundButton(
                              displayText: 'Login', 
                              onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginBodyScreen(),
                                            ),),),
                            SizedBox(height: 40),
                            WideDarkBackgroundButton(
                              displayText: 'Register', 
                              onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignUpPage(),
                                            ),)
                              )
                            

                          
                        ],
                        ),
                      )

                    )

                  ],
                )
              ],
            )
          ],
        ),
        
        )

    );
  }
}