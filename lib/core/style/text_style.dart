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

  static const TextStyle SemiBold14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  // حجم 12 - نص عادي
  static const TextStyle Regular12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  // حجم 14 - نص عادي
  static const TextStyle Regular14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}
