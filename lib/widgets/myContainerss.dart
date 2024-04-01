import 'package:flutter/material.dart';

class Containerdesign extends StatelessWidget {
  final String nametext;

  final String image;
  const Containerdesign(
      {required this.image,
      super.key,
      required this.nametext,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),

          // color: Colors.white,
          borderRadius: BorderRadius.circular(11)),
      // height: 220,
      // width: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            nametext,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
