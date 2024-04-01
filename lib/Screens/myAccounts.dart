import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject/Screens/loginpage.dart';
class MyAccountspage extends StatefulWidget {
  const MyAccountspage({super.key});

  @override
  State<MyAccountspage> createState() => _MyAccountspageState();
}

class _MyAccountspageState extends State<MyAccountspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
           children: [
             Container(
               height: 70,
               width: MediaQuery.of(context).size.width,
               child: Center(
                 child: Text("My Account",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
               ),
             ),
             ElevatedButton(onPressed: (){
               FirebaseAuth.instance.signOut();
               Navigator.of(context).push(MaterialPageRoute(builder: (builder){
                 return Loginpage() ;
               }));
             }, child: Text("logout"))
           ], 
          )
      ),

    );
  }
}
