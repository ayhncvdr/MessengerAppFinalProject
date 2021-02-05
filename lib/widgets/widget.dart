import 'package:flutter/material.dart';

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.indigo),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.indigo),
      ));
}
