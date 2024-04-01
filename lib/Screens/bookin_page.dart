import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key, required this.document}) : super(key: key);
  final String document;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("items")
            .doc(widget.document)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text('No data available'),
            );
          }

          var data = snapshot.data!.data();
          if (data == null) {
            return Center(
              child: Text('No data available'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .34,
                    width: double.infinity,
                    child: Image(
                      image: NetworkImage(data['image']),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  data['name'] ?? 'No Name',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
