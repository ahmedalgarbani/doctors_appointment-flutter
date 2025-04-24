import 'package:flutter/material.dart';

abstract class TextStyles {
  static const TextStyle Black20Bold =
      TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);
  static const TextStyle Bold19 =
      TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.bold);
  static const TextStyle Regular16 =
      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400);
  static const TextStyle Bold16 = TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontSize: 16,
      fontWeight: FontWeight.bold);
  static const TextStyle Bold12 = TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 12,
      fontWeight: FontWeight.bold);
}
