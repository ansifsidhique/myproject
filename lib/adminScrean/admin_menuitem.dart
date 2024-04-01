import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myproject/Screens/bottomBarNav.dart';
import 'package:myproject/Screens/mySplashScreen.dart';

class AdminAddItems extends StatefulWidget {
  const AdminAddItems({super.key});

  @override
  State<AdminAddItems> createState() => _AdminAddItemsState();
}

class _AdminAddItemsState extends State<AdminAddItems> {
  storageFun() async {
    final responce =
    FirebaseStorage.instance.ref().child("myimg/${selectImage!.path}");
    // .putFile(selectImage!);
    var task = responce.putFile(selectImage!);
    await task.whenComplete(() async {
      String link = await responce.getDownloadURL();

      await FirebaseFirestore.instance.collection("items").add({
        "image": link,
        "name": namecon.text,
        "catid": catogerucon.text,
        "price": pricecon.text,
        "discription": discriptioncon.text
      });
    });
  }

  TextEditingController namecon = TextEditingController();
  TextEditingController pricecon = TextEditingController();
  TextEditingController discriptioncon = TextEditingController();
  TextEditingController catogerucon = TextEditingController();
  File? selectImage;

  getImage() async {
    ImagePicker image = ImagePicker();
    XFile? pickedImage = await image.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectImage = File(pickedImage.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        children: [
          TextField(
              decoration: const InputDecoration(labelText: "name"),
              controller: namecon),
          TextField(
              decoration: const InputDecoration(labelText: "price"),
              controller: pricecon),
          TextField(
              decoration: const InputDecoration(labelText: "discription"),
              controller: discriptioncon),
          TextField(
              decoration: const InputDecoration(labelText: "catogery"),
              controller: catogerucon),
          ElevatedButton(
              onPressed: () {
                getImage();
              },
              child: const Text("image pick")),
          selectImage == null
              ? const SizedBox()
              : Image(image: FileImage(selectImage!)),
          ElevatedButton(
              onPressed: () {
                if (namecon.text.isNotEmpty &&
                    pricecon.text.isNotEmpty &&
                    discriptioncon.text.isNotEmpty &&
                    catogerucon.text.isNotEmpty &&
                    selectImage != null) {
                  storageFun();
                }
              },
              child: const Text("submit")),
          ElevatedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const BottonNavPAge(),
              )),
              child: const Text("homepage")),
        ],
      ),
    );
  }
}
