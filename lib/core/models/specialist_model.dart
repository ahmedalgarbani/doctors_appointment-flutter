import 'package:flutter/material.dart';

class SpecialistModel {
  final String title;
  final int doctorNumber;
  final Color color;
  final String imagePath;

  SpecialistModel(
      {required this.title,
      required this.doctorNumber,
      required this.color,
      required this.imagePath});
}
