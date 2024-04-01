import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myproject/Screens/bottomBarNav.dart';
import 'package:myproject/Screens/loginpage.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameControlller = TextEditingController();
  TextEditingController emailControlller = TextEditingController();
  TextEditingController passwordControlller = TextEditingController();
  TextEditingController confremControlller = TextEditingController();
  TextEditingController phoneControlller = TextEditingController();
  bool hide = false;

  void useRegstra({required String email, required String password}) async {
    try {
      UserCredential userData = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance
          .collection("user")
          .doc(userData.user!.uid)
          .collection("details")
          .add({
        "name": nameControlller.text,
        "email": emailControlller.text,
        "phone": phoneControlller.text,
        "confirmpassword": confremControlller.text,
      });

      if (userData.user != null) {
        Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
          return const BottonNavPAge();
        }));
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "weak-password") {
        Fluttertoast.showToast(
          msg: "Password should be at least 6 characters long",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
      if (error.code == "invalid-email") {
        Fluttertoast.showToast(
          msg: "Enter a valid email",
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
      body: Container(
        decoration:const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF73AEF5), Color(0xFF61A4F1)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               const   Text(
                    'Create an Account',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Changing text color to white
                    ),
                  ),
                 const SizedBox(height: 20.0),
                  TextField(
                    controller: nameControlller,
                    decoration:const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                      fillColor: Colors.white, // Setting text field background color
                      filled: true, // Filling the text field with color
                    ),
                  ),
                 const SizedBox(height: 20.0),
                  TextField(
                    controller: emailControlller,
                    keyboardType: TextInputType.emailAddress,
                    decoration:const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                const  SizedBox(height: 20.0),
                  TextField(
                    controller: passwordControlller,
                    obscureText: hide,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border:const OutlineInputBorder(),
                      prefixIcon:const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hide = !hide;
                          });
                        },
                        icon: Icon(
                          hide ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                 const SizedBox(height: 20.0),
                  TextField(
                    controller: confremControlller,
                    obscureText: true,
                    decoration:const InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm your password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                 const SizedBox(height: 20.0),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: phoneControlller,
                    decoration:const InputDecoration(
                      labelText: 'Phone Number',
                      hintText: 'Enter your phone number',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                 const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () => useRegstra(
                      email: emailControlller.text,
                      password: passwordControlller.text,
                    ),

                    style: ElevatedButton.styleFrom(
                      padding:const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      // primary: Colors.white, // Changing button color to white
                    ),child:const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  ),
                 const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     const Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white, // Changing text color to white
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (builder) {
                              return const Loginpage();
                            }),
                          );
                        },
                        child:const Text(
                          "Login Page",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white, // Changing text color to white
                          ),
                        ),
                      ),
                    ],
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
