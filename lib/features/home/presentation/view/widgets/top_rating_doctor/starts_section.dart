import 'package:flutter/material.dart';

class StarsSection extends StatelessWidget {
  const StarsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) => const Icon(Icons.star_outlined, color: Colors.orange),
      ),
    );
  }
}


