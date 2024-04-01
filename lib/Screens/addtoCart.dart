import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddTo extends StatefulWidget {
  const AddTo({super.key});

  @override
  State<AddTo> createState() => _AddToState();
}

class _AddToState extends State<AddTo> {
  var vatt;
  addData({required String docid, required String value}) async {
    FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart")
        .doc(docid)
        .update({"size": value});
  }

  deleteData({required docid}) async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart")
        .doc(docid)
        .delete();
  }

  String? selectedValue;
  num total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("user")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("cart")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, intex) {
                          total = total + snapshot.data!.docs[intex]["price"];
                          // print(total);

                          return SizedBox(
                            height: 204,
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(snapshot
                                              .data!.docs[intex]["image"]),
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    width: 100,
                                    height: 200,
                                  ),
                                  Expanded(
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(snapshot.data!.docs[intex]
                                                ["name"]),
                                            // SizedBox(width: 80,),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: null,
                                                    icon: Icon(
                                                        Icons.favorite_border)),
                                                IconButton(
                                                    onPressed: () {
                                                      deleteData(
                                                          docid: snapshot.data!
                                                              .docs[intex].id);
                                                    },
                                                    icon: Icon(Icons.delete)),
                                              ],
                                            )
                                          ],
                                        ),
                                        Text(snapshot.data!.docs[intex]["price"]
                                            .toString()),
                                        Row(
                                          children: [
                                            Text(
                                              "Size",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 19),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            DropdownMenu(
                                              initialSelection: Text(
                                                  "Size:${snapshot.data!.docs[intex]["size"]}"),
                                              hintText:
                                                  "Size:${snapshot.data!.docs[intex]["size"]}",
                                              dropdownMenuEntries: [
                                                DropdownMenuEntry(
                                                    value: "S", label: "S"),
                                                DropdownMenuEntry(
                                                    value: "M", label: "M"),
                                                DropdownMenuEntry(
                                                    value: "L", label: "L"),
                                                DropdownMenuEntry(
                                                    value: "XL", label: "xl"),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Qnty",
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            DropdownMenu(
                                                onSelected: (value) {
                                                  vatt = value;
                                                },
                                                initialSelection:
                                                    Text("Qunty:1"),
                                                hintText: "Qunty:1",
                                                // "Qunty:${snapshot.data!.docs[intex]["1"]}",
                                                dropdownMenuEntries: [
                                                  DropdownMenuEntry(
                                                      value: "1", label: '1'),
                                                  DropdownMenuEntry(
                                                      value: "2", label: '2'),
                                                  DropdownMenuEntry(
                                                      value: "3", label: '3'),
                                                  DropdownMenuEntry(
                                                      value: "4", label: '4'),
                                                  DropdownMenuEntry(
                                                      value: "5", label: '5'),
                                                ])
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.yellow,
                    child: Row(
                      children: [
                        const Text(
                          "Totel",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          selectionColor: Colors.white,
                        ),
                        Text(total.toString()),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return SizedBox();
            }
          }),
    );
  }
}
