import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:socialverse/export.dart';

class CircularClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(20), // Rounded corners
    ));

    double ovalWidth = size.width * 0.9;
    double ovalHeight = size.height * 0.9;
    Offset center = Offset(size.width / 2, size.height / 2 + 10);

    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: ovalWidth, height: ovalHeight),
      Radius.circular(20),
    ));

    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CircularClipper oldClipper) => false;
}

class SmallerCircularClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(20), // Rounded corners
    ));

    double ovalWidth = size.width * 0.8;
    double ovalHeight = size.height * 0.8;
    Offset center = Offset(size.width / 2, size.height / 2 + 10);

    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: ovalWidth, height: ovalHeight),
      Radius.circular(20),
    ));

    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(SmallerCircularClipper oldSmClipper) => false;
}