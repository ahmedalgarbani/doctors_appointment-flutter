
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/home/data/models/speciality_response/hospital.dart';
import 'package:flutter/material.dart';

import '../../../../home/data/models/speciality_response/doctor.dart';

class ChosenDoctor extends StatelessWidget {
  const ChosenDoctor({super.key, required this.bookeddoctor});

  final Map<String, dynamic> bookeddoctor;

  @override
  Widget build(BuildContext context) {
    final String hospitalName =
        (bookeddoctor['doctor'].hospitals as List<Hospital> ?? [])
                .where((hospital) =>
                    hospital.id == (bookeddoctor['hospital'] as Hospital).id)
                .map((hospital) => hospital.name ?? '')
                .firstOrNull ??
            '';
    final String doctorPrice = ((bookeddoctor['doctor'] as Doctor).pricing ??
                [])
            .where((price) =>
                price.hospital?.id == (bookeddoctor['hospital'] as Hospital).id)
            .map((price) => price.amount ?? '')
            .firstOrNull ??
        '';

    return Card(
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        subtitle: Text(
          hospitalName.isNotEmpty ? hospitalName : 'No hospital found',
          style: TextStyles.Bold12.copyWith(color: Colors.grey),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            bookeddoctor['doctor'].photo ?? '',
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          bookeddoctor['doctor'].fullName ?? '',
          style: TextStyles.Bold16.copyWith(color: Colors.black),
        ),
        trailing: Text(
          doctorPrice ?? '0.0',
          style: TextStyles.Bold16.copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
