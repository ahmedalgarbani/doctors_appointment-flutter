import 'package:doctors_appointment/features/edit_profile/presentation/view/widgets/address_section.dart';
import 'package:doctors_appointment/features/edit_profile/presentation/view/widgets/medical_info_section.dart';
import 'package:doctors_appointment/features/edit_profile/presentation/view/widgets/personal_info_section.dart';
import 'package:doctors_appointment/features/edit_profile/presentation/view/widgets/profile_image.dart';
import 'package:flutter/material.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تعديل الملف الشخصي"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            ProfileImage(),
            SizedBox(height: 30),
            PersonalInfoSection(),
            SizedBox(height: 30),
            AddressSection(),
            SizedBox(height: 30),
            MedicalInfoSection(),
          ],
        ),
      ),
    );
  }
}
