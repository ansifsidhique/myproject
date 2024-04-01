import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FullItems extends StatelessWidget {
  const FullItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("items").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data!.docs[index]["image"]),fit: BoxFit.cover)),
                          ) // Image(
                          //   image:
                          //       NetworkImage(snapshot.data!.docs[index]["image"]),
                          // ),
                        ],
                      ),
                    );
                  });
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}
