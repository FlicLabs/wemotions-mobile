import 'package:flutter/material.dart';

final textFormFieldDecoration = InputDecoration(
  hintText: '',
  filled: true,
  hintStyle: TextStyle(
    fontFamily: 'sofia',
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: Colors.grey.shade500,
  ),
  // errorStyle: TextStyle(
  //   fontFamily: 'sofia',
  //   fontSize: 12,
  //   fontWeight: FontWeight.w400,
  //   color: Colors.white,
  // ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.red),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.transparent),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.transparent),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.transparent),
  ),
);
