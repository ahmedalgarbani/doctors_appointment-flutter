
import 'package:doctors_appointment/core/models/doctor_model.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/in_active_item.dart';
import 'package:flutter/material.dart';

class DoctorHorizantalListCard extends StatelessWidget {
  const DoctorHorizantalListCard({super.key, required this.doctorModel});
  final DoctorModel doctorModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      
      elevation: 1,
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 1,vertical: 0),
        trailing: UnActiveItem(icon: Icons.favorite_border),
        subtitle: Text(
          doctorModel.Speciality,
          style: TextStyles.Bold12.copyWith(color: Colors.grey),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            doctorModel.imagePath,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          doctorModel.name,
          style: TextStyles.Bold16.copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
