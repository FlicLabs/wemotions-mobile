import 'package:flutter/material.dart';

/// Screen size utilities
class ScreenSize {
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
}

/// Spacing constants
class Spacing {
  /// Empty space
  static const SizedBox shrink = SizedBox.shrink();

  /// Horizontal spacing
  static const horizontal = _HorizontalSpacing();
  /// Vertical spacing
  static const vertical = _VerticalSpacing();
}

/// Private classes to group spacing
class _HorizontalSpacing {
  const _HorizontalSpacing();
  static const SizedBox w2 = SizedBox(width: 2);
  static const SizedBox w3 = SizedBox(width: 3);
  static const SizedBox w5 = SizedBox(width: 5);
  static const SizedBox w10 = SizedBox(width: 10);
  static const SizedBox w15 = SizedBox(width: 15);
  static const SizedBox w16 = SizedBox(width: 16);
  static const SizedBox w20 = SizedBox(width: 20);
}

class _VerticalSpacing {
  const _VerticalSpacing();
  static const SizedBox h2 = SizedBox(height: 2);
  static const SizedBox h5 = SizedBox(height: 5);
  static const SizedBox h7 = SizedBox(height: 7);
  static const SizedBox h8 = SizedBox(height: 8);
  static const SizedBox h10 = SizedBox(height: 10);
  static const SizedBox h15 = SizedBox(height: 15);
  static const SizedBox h16 = SizedBox(height: 16);
  static const SizedBox h20 = SizedBox(height: 20);
  static const SizedBox h24 = SizedBox(height: 24);
  static const SizedBox h26 = SizedBox(height: 26);
  static const SizedBox h30 = SizedBox(height: 30);
  static const SizedBox h32 = SizedBox(height: 32);
  static const SizedBox h40 = SizedBox(height: 40);
  static const SizedBox h60 = SizedBox(height: 60);
  static const SizedBox h80 = SizedBox(height: 80);
  static const SizedBox h90 = SizedBox(height: 90);
}
