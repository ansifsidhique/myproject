import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myproject/Screens/address/address_page.dart';
import 'package:myproject/Screens/addtoCart.dart';
import 'package:myproject/Screens/persistant_cart.dart';

import 'package:myproject/Screens/shoppingPage.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class ViewProductScreen extends StatefulWidget {
  const ViewProductScreen({
    super.key,
    required this.document,
  });

  final String document;

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  bool isincart = false;

  var cartitems;

  Future<void> checkCartStatus() async {
    try {
      var querysnapshot =
          await cartitems.where("name", isEqualTo: widget.document).get();
      setState(() {
        isincart = querysnapshot.docs.isNotEmpty;
      });
    } catch (e) {
      print(e);
    }
  }

  String change = "add to cart";

  itemBooking(
      {required String name,
      required String image,
      required size,
      required int price}) async {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("booking");
    cartitems = collectionReference;
    await collectionReference.add({
      "name": name,
      "image": image,
      "size": size,
      "price": price,
      "address": "",
      "user name": "",
      "zip code": "",
      "city": ""
    });
  }

  addTocart(
      {required String name,
      required String image,
      required size,
      required int price}) async {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart");

    await collectionReference
        .add({"name": name, "image": image, "size": size, "price": price});

    //  Map <String,dynamic> data={
    //    "name":name,"image":image
    //  };
    // await collectionReference.doc("cart").set(data,SetOptions(merge: true)).then((value) =>
    // change="add to cart").catchError((error){
    //   change="go to cart";
    // });
  }

  updateAddress({
    required String fullname,
    required String address,
    required String zipcode,
    required String city,
  }) async {
    var collectionReference = await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("booking")
        .get();
    var bookingsid = collectionReference.docs.last.id;
// var lastbooking =  bookings.docs.last.id;
// print("======= $lastbooking");
//   var data = await collectionReference.get();

    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("booking")
        .doc(bookingsid)
        .update({
      "address": address,
      "user name": fullname,
      "zip code": zipcode,
      "city": city
    });
  }

  String selectedsize = "S";

  var SelectedIndex = 0;

  final List<String> sizes = ["S", "M", "L", "XL", "XXL"];

  @override
  Widget build(BuildContext context) {
    // change = "add to cart";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        actions: [

          PersistentShoppingCart().showCartItemCountWidget(
              cartItemCountWidgetBuilder: (itemCount) => IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (b){
                  return  const PersistantCart();
                }));
              }, icon: Badge(
                label: Text(itemCount.toString(),
                ),
                child: const Icon (Icons.shopping_bag_outlined),
              )),)
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("items")
              .doc(widget.document)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(snapshot.data!["image"]))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10),
                      child: Text(
                        snapshot.data!["name"],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0, top: 20),
                      child: Text(
                        "Select Size",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: sizes.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                SelectedIndex = index;
                                selectedsize = sizes[index];
                                setState(() {});
                              },
                              child: Container(
                                margin: const EdgeInsets.all(3),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black),
                                  color: index == SelectedIndex
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                child: Center(
                                    child: Text(
                                  sizes[index],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Description",
                              style: TextStyle(
                                  wordSpacing: 2,
                                  letterSpacing: 2,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection("items")
                                          .doc(widget.document)
                                          .snapshots(),
                                      builder: (context, snapshot) => Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              "Description",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(snapshot.data!["discription"]),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.arrow_forward_ios))
                          ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () {
                              showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => AlertDialog(
                                  title: const Text("Confirm Order"),
                                  content: const SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        Text(
                                            "Do you want to confirm your order")
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("go back")),
                                    TextButton(
                                        onPressed: () {
                                          print(FirebaseAuth
                                              .instance.currentUser?.uid);
                                          itemBooking(
                                            image: snapshot.data!["image"],
                                            name: snapshot.data!["name"],
                                            price: snapshot.data!["price"],
                                            size: selectedsize,
                                          );
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) => Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Expanded(
                                                  child: StreamBuilder(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection("user")
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                          .collection("address")
                                                          .snapshots(),
                                                      builder: (context,
                                                          AsyncSnapshot
                                                              snapshot) {
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return const Center(
                                                              child:
                                                                  CircularProgressIndicator());
                                                        }
                                                        if (snapshot.hasData) {
                                                          return ListView
                                                              .builder(
                                                                  itemCount:
                                                                      snapshot
                                                                          .data!
                                                                          .docs
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8.0),
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width,

                                                                            child:
                                                                                InkWell(

                                                                              onTap: () {
                                                                                updateAddress(address: snapshot.data!.docs[index]["address"], zipcode: snapshot.data!.docs[index]["zip code"], fullname: snapshot.data.docs[index]["full name"], city: snapshot.data.docs[index]["city"]);
                                                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) {
                                                                                  return const ShopingPage();
                                                                                }));
                                                                                print("clik");
                                                                                print(snapshot.data!.docs[index]["address"]);
                                                                              },
                                                                              child: Card(
                                                                                  child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text("Name: " + snapshot.data!.docs[index]["full name"]),
                                                                                    Text(
                                                                                      "Address: " + snapshot.data!.docs[index]["address"],
                                                                                      maxLines: 4,
                                                                                    ),


                                                                                    Text("Zip code: " + snapshot.data!.docs[index]["zip code"].toString()),
                                                                                    Text("city :" + snapshot.data!.docs[index]["city"])



                                                                                  ],
                                                                                ),
                                                                              )),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    );
                                                                  });
                                                        } else {
                                                          return Center(
                                                            child: Row(
                                                              children: [
                                                                const Text(
                                                                    "you don't have address"),
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pushReplacement(
                                                                          context,
                                                                          MaterialPageRoute(builder:
                                                                              (builder) {
                                                                        return const AddressPage();
                                                                      }));
                                                                    },
                                                                    child: const Text(
                                                                        "add address"))
                                                              ],
                                                            ),
                                                          );
                                                        }
                                                      }),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (builder) {
                                                      return const AddressPage();
                                                    }));
                                                  },
                                                  child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 50,
                                                      child: const Card(
                                                        child: Center(
                                                          child: Text(
                                                              "Add Address"),
                                                        ),
                                                      )),
                                                )
                                              ],
                                            ),
                                          );
                                          // Fluttertoast.showToast(
                                          //     msg:
                                          //         "booking succesfully completed");
                                          // Navigator.pushReplacement(context,
                                          //     MaterialPageRoute(
                                          //         builder: (builder) {
                                          //   return BookingPage(
                                          //       document: snapshot.data!.id);
                                          // }));
                                          // Navigator.of(context).pushReplacement(
                                          //     MaterialPageRoute(
                                          //   builder: (context) => BookingPage(
                                          //     document: snapshot.data!.id,
                                          //   ), // Assuming AddTo is your destination page
                                          // ));
                                        },
                                        child: const Text("yes"))
                                  ],
                                ),
                              );
                            },
                            child: const Text("Booking Confirm"))),
                    const SizedBox(
                      height: 10,
                    ),

                    PersistentShoppingCart().showAndUpdateCartItemWidget(
                        inCartWidget: const Text("removed"),
                        notInCartWidget: const Text("Add to cart"),
                        product: PersistentShoppingCartItem(
                            productId: snapshot.data!["image"],
                            productName: snapshot.data!["name"],
                            unitPrice: double.parse(
                                snapshot.data!["price"].toString()),
                            productDescription: snapshot.data!["discription"],
                            // quantity: int.parse(snapshot.data!["qnty"].toString())

                            quantity: 1))
                  ]);
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}
