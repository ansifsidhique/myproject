import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShopingPage extends StatefulWidget {
  const ShopingPage({super.key});

  @override
  State<ShopingPage> createState() => _ShopingPageState();
}

class _ShopingPageState extends State<ShopingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:const Text("Order Summery",style: TextStyle(fontSize: 20,
          fontWeight: FontWeight.bold),)
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("user")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("booking")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasData){
              return   Padding(
                  padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length ,
                    itemBuilder: (context, index) => Card(
                      color: Colors.grey.shade600,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 13.0,top: 8,bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween
                          ,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  snapshot.data!.docs[index]["name"],style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                                Row(
                                  children: [
                                    const Text("\$  :"),
                                    Text(snapshot.data!.docs[index]["price"].toString()),
                                  ],
                                )],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(

                                height: 90,
                                width: 90,
                                child: CircleAvatar(
                                  backgroundImage:NetworkImage(snapshot.data!.docs[index]["image"]) ,
                                  // child:Image(image: ) ,
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                  ));
            }
            else{
              return const SizedBox();
            }
          }


        ));
  }
}
