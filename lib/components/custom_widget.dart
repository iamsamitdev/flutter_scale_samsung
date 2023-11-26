// ignore_for_file: prefer_const_constructors, sort_child_properties_last, non_constant_identifier_names

import 'package:flutter/material.dart';

// Custom Button
Widget CustomButton(
  Function() onPressed,
  String buttonText,
  {
    Color? color,
    Color? textColor,
    width = 100.0,
    height = 40.0,
  }
){
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 18,
          color: textColor,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}


// Custom Text Field
Widget CustomTextField(
  BuildContext context,
  String hintText,
  Function onValidate,
  Function onSaved,
  {
    Icon? icon,
    String initialValue = '',
    bool autofocus = false,
    bool obscureText = false,
    var maxLines,
    var keyboardType = TextInputType.text,
  }
){
  return TextFormField(
    autofocus: autofocus,
    initialValue: initialValue,
    obscureText: obscureText,
    validator: (value) => onValidate(value.toString().trim()),
    onSaved: (value) => onSaved(value.toString().trim()),
    keyboardType: keyboardType,
    maxLines: maxLines,
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: icon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}