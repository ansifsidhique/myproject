import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myproject/Screens/bottomBarNav.dart';

import 'package:myproject/Screens/registrationPage.dart';
import 'package:myproject/adminScrean/AdminAddingData.dart';
import 'package:myproject/adminScrean/adminHome.dart';


class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController email = TextEditingController();
  TextEditingController passwordd = TextEditingController();

  log({ required emaill, required pass}) async {
    try {
      UserCredential store = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emaill, password: pass);
      if (store.user != null) {
       if(FirebaseAuth.instance.currentUser!.uid=="yqSOrdWCcdaFq5Gw6z63T8eUYZ42"){
         if (!mounted) return;
         Navigator.of(context).pushReplacement(MaterialPageRoute(
           builder: (context) =>const  AdminTabPage(),
         ));
       }else{
         if (!mounted) return;
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=> const BottonNavPAge()));

       }

      }
    } on FirebaseAuthException catch (error) {
      // print(error);
      if (error.code == "INVALID_LOGIN_CREDENTIALS") {
        Fluttertoast.showToast(
          msg: "enter currct email and password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
      if (error.code == "invalid-email") {
        Fluttertoast.showToast(
          msg: "please check your email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          decoration:const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF73AEF5), Color(0xFF61A4F1)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
             const SizedBox(height: 20.0),
              TextField(
                controller: email,
                decoration:const InputDecoration(
                  hintText: "Enter your email",
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
             const SizedBox(height: 20.0),
              TextField(
                obscureText: true,
                controller: passwordd,
                decoration:const InputDecoration(
                  hintText: "Enter your password",
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
             const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Navigate to forgot password screen
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
             const SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {

                    log(emaill: email.text, pass: passwordd.text);
                  },

                  style: ElevatedButton.styleFrom(
                    padding:const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    // primary: Colors.white,
                    // onPrimary: Color(0xFF61A4F1),
                  ),
                  child:const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegistrationPage(),
                      ));
                      // Fluttertoast.showToast(
                      //
                      //   toastLength: Toast.LENGTH_SHORT,
                      //   gravity: ToastGravity.BOTTOM,
                      //   timeInSecForIosWeb: 1,
                      //   backgroundColor: Colors.red,
                      //   textColor: Colors.white,
                      // );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}
