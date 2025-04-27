import 'package:flutter/material.dart';

class DoctorImage extends StatelessWidget {
  const DoctorImage(
      {super.key,
      required this.doctorImage,
      required this.doctorId,
      required int size});
  final String doctorImage;
  final int doctorId;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Hero(
          tag: 'doctor-${doctorId}',
          child: Image.network(
            doctorImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
