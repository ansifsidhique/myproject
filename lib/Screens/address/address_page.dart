import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  addAdress() async {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("address");
    await collectionReference.add({
      "full name": _fullNameController.text,
      "address": _addressController.text,
      "city": _cityController.text,
      "zip code": _zipCodeController.text,
      "country": _countryController.text
    });
  }

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Address'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("user")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("address")
              .snapshots(),
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  TextField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(labelText: 'Address'),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _cityController,
                    decoration: const InputDecoration(labelText: 'City'),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _zipCodeController,
                    decoration: const InputDecoration(labelText: 'ZIP Code'),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _countryController,
                    decoration: const InputDecoration(labelText: 'Country'),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      addAdress();
                      Navigator.pop(context);
                      // Save shipping address logic here
                      // For demonstration purposes, print the address
                      // print('Full Name: ${_fullNameController.text}');
                      // print('Address: ${_addressController.text}');
                      // print('City: ${_cityController.text}');
                      // print('ZIP Code: ${_zipCodeController.text}');
                      // print('Country: ${_countryController.text}');
                      // You can add logic to save this address to a database or perform further actions
                    },
                    child: const Text('Save Address'),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
