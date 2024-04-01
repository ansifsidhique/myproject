import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myproject/Screens/addtoCart.dart';
import 'package:myproject/Screens/viewProd.dart';

class ProduView extends StatefulWidget {
  const ProduView({super.key, required this.catid});
  final String catid;

  @override
  State<ProduView> createState() => _ProduViewState();
}

class _ProduViewState extends State<ProduView> {
  @override
  Widget build(BuildContext context) {
    // print(widget.catid);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade300,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddTo(),
                    ));
                  },
                  icon: Icon(Icons.shopping_cart)),
            ),
          ],
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("items")
                .where("catid", isEqualTo: widget.catid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1 / 1.4,
                            crossAxisCount: 2),
                    itemBuilder: (context, intex) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (builder) => ViewProductScreen(
                                    document: snapshot.data!.docs[intex].id,
                                  )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(10)),

                          // margin: const EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data!.docs[intex]["image"]),
                                          fit: BoxFit.cover)),
                                ),
                                Text(snapshot.data!.docs[intex]["name"]),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Description",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                          snapshot.data!.docs[intex]
                                              ["discription"],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                          textAlign: TextAlign.center)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return SizedBox();
              }
            }));
  }
}
