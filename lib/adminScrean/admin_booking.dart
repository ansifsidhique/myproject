import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminBooking extends StatefulWidget {
  const AdminBooking({Key? key}) : super(key: key);

  @override
  State<AdminBooking> createState() => _AdminBookingState();
}

class _AdminBookingState extends State<AdminBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collectionGroup("booking").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            var orders = snapshot.data!.docs;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                var order = orders[index];
                return ListTile(
                  title: Row(
                    children: [
                      SizedBox(
                          height: 80,
                          width: 60,
                          child: Image(
                            image: NetworkImage(
                              order["image"],
                              // placeholder: (context, url) => CircularProgressIndicator(),
                              // errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          )),
                     const SizedBox(
                          width:
                              20),
                      Text(

                        order["name"],
                        style:const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
