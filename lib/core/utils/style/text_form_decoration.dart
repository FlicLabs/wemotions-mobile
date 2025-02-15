import 'package:flutter/material.dart';

InputDecoration textFormFieldDecoration({
  String hintText = '',
  Color fillColor = Colors.white,
  Color borderColor = Colors.grey,
  Color focusedBorderColor = Colors.blue,
  Color errorColor = Colors.red,
  double borderRadius = 10.0,
}) {
  return InputDecoration(
    hintText: hintText,
    filled: true,
    fillColor: fillColor,
    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    hintStyle: TextStyle(
      fontFamily: 'sofia',
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: Colors.grey.shade500,
    ),
    errorStyle: const TextStyle(
      fontFamily: 'sofia',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.red,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: errorColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: focusedBorderColor, width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: borderColor.withOpacity(0.3), width: 1),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: borderColor.withOpacity(0.1)),
    ),
  );
}
