import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myproject/Screens/address/address_page.dart';
import 'package:myproject/Screens/loginpage.dart';
import 'package:myproject/Screens/shoppingPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, this.docid}) : super(key: key);
  final docid;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void updateName(String newName) async {
    try {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("details")
          .doc(widget.docid)
          .update({"name": newName});
      // print("Name updated successfully!");
    } catch (e) {

      // print("Error updating name: $e");
    }
  }

  imagePic() {
    ImagePicker imagePicker = ImagePicker();
  }

  TextEditingController popupController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("user")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("details")
              .snapshots(),
          builder: (context, snapshot) {
            // popupController = TextEditingController(
            //     text: snapshot.data!.docs[0]['name']);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            //   return const Center(child: Text('No data available'));
            // }
            if (snapshot.hasData) {
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      title: Text(snapshot.data!.docs[0]['name']),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Edit Name'),
                              content: TextField(
                                controller: popupController,
                                onChanged: (value) {
                                  updateName(value);
                                  // Update the name in real-time as the user types
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    String newName = popupController
                                        .text; // Get the new name from the TextField
                                    await FirebaseFirestore.instance
                                        .collection("user")
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .collection("details")
                                        .doc(snapshot.data!.docs[0].id)
                                        .update({'name': newName});

                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Save'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('Email'),
                      subtitle: Text(snapshot.data!.docs[0]["email"]),
                    ),
                    ListTile(
                      title: const Text('Phone Number'),
                      subtitle: Text(snapshot.data!.docs[0]['phone']),
                    ),
                    ListTile(
                      title: const Text('Shipping Address'),
                      subtitle: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser!.uid
                        ).collection("address").snapshots(),
                        builder: (context,snapshot) {
                          return Text("");
                        }
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => AddressPage()));
                        },
                      ),
                    ),
                    // const Divider(),
                    // const ListTile(
                    //   title: Text('Payment Method'),
                    //   subtitle: Text('Credit Card ending in 1234'),
                    // ),
                    // ListTile(
                    //   title: const Text('Billing Address'),
                    //   subtitle: const Text('456 Park Ave, City, Country'),
                    //   trailing: IconButton(
                    //     icon: const Icon(Icons.edit),
                    //     onPressed: () {
                    //       // Navigate to edit billing address screen
                    //     },
                    //   ),
                    // ),
                    const Divider(),
                    // Order History
                    ListTile(
                      title: const Text('Order History'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => const ShopingPage()));
                        // Navigate to order history screen
                      },
                    ),
                    // List of orders can be displayed here

                    // Settings


                    // Security
                    // ListTile(
                    //   title: const Text('Change Password'),
                    //   onTap: () {
                    //     // Navigate to change password screen
                    //   },
                    // ),
                    ListTile(
                      title: const Text('Log Out'),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => Loginpage()));

                        // Perform log out action
                      },
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}
