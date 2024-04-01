import 'package:flutter/material.dart';

class TextFieldDesign extends StatelessWidget {
  TextEditingController cntrl = TextEditingController();
  final String hintText;



  bool obscureText;
  Widget? prefixx;
  TextInputType? type;

  TextFieldDesign(
      {super.key,
      required this.cntrl,
      required this.hintText,
      this.prefixx,
      this.obscureText = false,
      this.type,   });

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.all(20.0),
      child: TextField(
        obscureText: obscureText,
        controller: cntrl,
        keyboardType: type,
        decoration: InputDecoration(
            suffixIcon: prefixx,
            hintText: hintText,
            border:
                OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black))
        ),
      ),
    );
  }
}
