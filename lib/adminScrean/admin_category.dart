import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:myproject/Screens/CtogeryProd.dart';
import 'package:myproject/adminScrean/adding%20Screen/category_Adding.dart';

class AdminCat extends StatefulWidget {
  const AdminCat({super.key});

  @override
  State<AdminCat> createState() => _AdminCatState();
}

class _AdminCatState extends State<AdminCat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Catogery").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) {
                          return ProduView(
                            catid: snapshot.data!.docs[index]["name"],
                          );
                        }));
                      },
                      title: Center(
                          child: Text(snapshot.data!.docs[index]["name"])),
                    );
                  });
            } else {
              return const SizedBox();
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => const AdminScreen()));
        },
        child: const Text("Add"),
      ),
    );
  }
}
