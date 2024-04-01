import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  // final ImagePicker _picker = ImagePicker();
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Category").snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      controller: name,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Pick Image'),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Add Category'),
                    ),
                  ],
                ),
              ),
            );

          }
          else{
            return SizedBox();
          }

        },
      ),
    );
  }
}
