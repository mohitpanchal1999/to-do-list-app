import 'package:flutter/material.dart';

Text buildText(String text, Color color, double fontSize, FontWeight fontWeight,
    TextAlign textAlign, TextOverflow overflow ,{int maxLine = 2}) {
  return Text(
    text,
    textAlign: textAlign,
    overflow: overflow,maxLines: maxLine,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}