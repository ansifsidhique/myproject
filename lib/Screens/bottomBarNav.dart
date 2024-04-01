import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:myproject/Screens/myHomeScreen.dart';
import 'package:myproject/Screens/persistant_cart.dart';
import 'package:myproject/Screens/profile_page.dart';

class BottonNavPAge extends StatefulWidget {
  const BottonNavPAge({super.key});

  @override
  State<BottonNavPAge> createState() => _BottonNavPAgeState();
}

class _BottonNavPAgeState extends State<BottonNavPAge> {
  List myScreens = [
    const MyHomeScreen(),
    // const MyAccountspage(),
    const PersistantCart(),
    const ProfilePage()
  ];
  int intex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          index: intex,
          height: 55,
          backgroundColor: Colors.white,
          color: Colors.grey,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (value) {
            setState(() {
              intex = value;
            });
          },
          items: const [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            //  Icon(
            //   Icons.add,
            //   color: Colors.white,
            // ),
            Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            Icon(
              Icons.person_outline,
              color: Colors.white,
            ),
          ]),
      body: myScreens[intex],
    );
  }
}
