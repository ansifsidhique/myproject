import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:myproject/Screens/CtogeryProd.dart';
import 'package:myproject/Screens/addtoCart.dart';
import 'package:myproject/Screens/fullitems.dart';
import 'package:myproject/Screens/viewProd.dart';
import 'package:myproject/widgets/myContainerss.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  // List<String> imageList = ['img.png'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade500,

      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        actions: [
          StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var mydata = snapshot.data!.docs.length;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: mydata == 0
                      ? const SizedBox()
                      : Badge(
                          label: Text(mydata.toString()),
                          smallSize: 17,
                          child: IconButton(
                            icon: const Icon(Icons.shopping_cart),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const AddTo(),
                              ));
                            },
                          ),
                        ),
                );
              } else {
                return const SizedBox();
              }
            },
            stream: FirebaseFirestore.instance
                .collection("user")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("cart")
                .snapshots(),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("offerlist")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CarouselSlider.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index, realIndex) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              // decoration: BoxDecoration(color: Colors.amber),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(snapshot
                                              .data!.docs[index]["offim"])))),
                            );
                          },
                          options: CarouselOptions(autoPlay: true)),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 230,
              child: StreamBuilder(
                  //
                  stream: FirebaseFirestore.instance
                      .collection("Catogery")
                      .snapshots(),
                  //
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          //
                          //

                          itemCount: snapshot.data!.docs.length,

                          //
                          //
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, intex) {
                            return Row(
                              children: [
                                InkWell(
                                  child: Containerdesign(
                                    //
                                    //
                                    nametext: snapshot.data!.docs[intex]
                                        ["name"],
                                    image: snapshot.data!.docs[intex]["image"],
                                    // pricetext: snapshot.data!.docs[intex]
                                    //     ["price"],

                                    //
                                    //
                                  ),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (builder) => ProduView(
                                                  catid: snapshot.data!
                                                      .docs[intex]["name"],
                                                )));
                                  },
                                ),
                              ],
                            );
                          });
                    } else {
                      return const SizedBox();
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "popular items",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FullItems(),
                      ));
                    },
                    child: const Text(
                      "See all",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("items")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 1 / 1.3,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (builder) => ViewProductScreen(
                                          document:
                                              snapshot.data!.docs[index].id,
                                        )));
                              },
                              child: Card(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(snapshot
                                                    .data!
                                                    .docs[index]["image"]),
                                                fit: BoxFit.fill)),
                                        height: 100,
                                        width: 100,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return const SizedBox();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
