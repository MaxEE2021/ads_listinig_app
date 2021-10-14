

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWidget extends StatelessWidget {
  // const CustomTextFieldWidget({Key? key}) : super(key: key);
  final String customHintText;
  final TextInputType textType;
  final bool isPassword;
  final int customMaxLines;
  final TextEditingController? customTextFieldController;

  const CustomTextFieldWidget ({
    this.customHintText="Hint Text",
    this.textType= TextInputType.text,
    this.isPassword=false,
    this.customMaxLines=1,
    this.customTextFieldController,
  });


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextField(
          controller: customTextFieldController,
          maxLines: customMaxLines,
          autofocus: false,
          keyboardType: textType,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: customHintText,
            hintStyle: TextStyle(color: Colors.black54),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black26,
                width: 2
              )
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black26,
                width: 2.5
              )
            ),
          ),
        ),
      ),
    );
  }
}