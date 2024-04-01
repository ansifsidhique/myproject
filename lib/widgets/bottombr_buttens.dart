import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Buttens extends StatelessWidget {
  const Buttens({super.key,
    required this.icon,
    required this.onTap,});
  final void Function()? onTap;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 36,
          width: 36,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ));
  }
}

//
//  GestureDetector(
// onTap:onTap,
// child: SizedBox(
// height: 36,
// width: 36,
// child: Icon(icon,color: Colors.white,),
// ),
//
