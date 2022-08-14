import 'package:account_picker/account_picker.dart';
import 'package:flutter/material.dart';

class CustomTextField1 extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  var checker=0;
   CustomTextField1({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: () async {
        if(checker==0){
          checker=1;
          final EmailResult? emailResult = await AccountPicker.emailHint();
          controller.text=emailResult!.email.toString().trim();
        }

      },
      decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          ))),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
