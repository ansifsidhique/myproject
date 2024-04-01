import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject/Screens/bottomBarNav.dart';

import 'package:myproject/Screens/registrationPage.dart';

import 'package:myproject/adminScrean/adminHome.dart';

class MySplash extends StatefulWidget {
  const MySplash({super.key});

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      Timer(Duration(seconds: 5), () {
        if (FirebaseAuth.instance.currentUser!.uid ==
            "yqSOrdWCcdaFq5Gw6z63T8eUYZ42") {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const AdminTabPage(),
          ));
        } else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (builder) => const BottonNavPAge()));
        }
      });
    } else {
      Timer(Duration(seconds: 5), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (builder) => RegistrationPage()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(child: Image.asset("assets/crtimage.jpg")),
      ),
    );
  }
}
