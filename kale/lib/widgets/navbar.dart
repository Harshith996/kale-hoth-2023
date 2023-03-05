import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomNavbar extends StatefulWidget {
  const CustomNavbar({super.key});

  @override
  State<CustomNavbar> createState() => _CustomNavbar();
}

class _CustomNavbar extends State<CustomNavbar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor("#064635"),
      child: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GNav(
        backgroundColor: Colors.grey,
        color: Colors.white,
        activeColor: Colors.white,
        tabBackgroundColor: Colors.black,
        iconSize: 20,
        padding: EdgeInsets.all(16.0),
        gap: 8,
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.menu,
            text: 'Menu',
          ),
          GButton(
            icon: Icons.settings,
            text: 'Profile',
          ),
          
        ]
      )
      
      ));
  }
}
