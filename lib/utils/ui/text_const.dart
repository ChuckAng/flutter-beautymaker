import 'package:flutter/material.dart';

class TextConsts extends TextStyle {
  final Color color;
  final FontWeight fontWeight;
  final double size;
  final String fontFamily;

  const TextConsts(
      {this.color = Colors.black,
      this.fontWeight = FontWeight.w900,
      this.fontFamily = "Synemono",
      this.size = 20})
      : super(
          color: color,
          fontWeight: fontWeight,
          fontSize: size,
          fontFamily: fontFamily,
        );
}
