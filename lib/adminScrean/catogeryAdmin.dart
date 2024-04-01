import 'package:flutter/material.dart';
import 'package:myproject/Screens/addtoCart.dart';

class CatyogryAdmin extends StatefulWidget {
  const CatyogryAdmin({super.key});

  @override
  State<CatyogryAdmin> createState() => _CatyogryAdminState();
}

class _CatyogryAdminState extends State<CatyogryAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(icon: Icon(Icons.shopping_cart)
              ,
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTo(),));
              },),
          ),
        ],
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: [
          Card(
            child: Text("hhh"),
          )
        ],
      ),
    );
  }
}
