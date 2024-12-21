import 'package:doctors_appointment/core/assets_helper/app_image.dart';
import 'package:doctors_appointment/core/assets_helper/app_vectors.dart';
import 'package:doctors_appointment/core/models/doctor_model.dart';
import 'package:doctors_appointment/core/models/specialist_model.dart';
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:flutter/material.dart';

abstract class DumyData {
  static final List<SpecialistModel> specialist = [
    SpecialistModel(
        color: Color(0xffFF4769),
        title: "Heart",
        doctorNumber: 526,
        imagePath: AppVectors.specialitiesHeart),
    SpecialistModel(
        color: AppColor.primaryColor,
        title: "Brain",
        doctorNumber: 85,
        imagePath: AppVectors.specialitiesBrain),
    SpecialistModel(
        color: Color(0xff528EFE),
        title: "Dentis",
        doctorNumber: 55,
        imagePath: AppVectors.specialitiesDentis),
    SpecialistModel(
        color: Color(0xffFFD05B),
        title: "eye",
        doctorNumber: 33,
        imagePath: AppVectors.specialitiesEye),
    SpecialistModel(
        color: AppColor.primaryColor.withOpacity(.6),
        title: "knee",
        doctorNumber: 122,
        imagePath: AppVectors.specialitiesKnee),
    SpecialistModel(
        color: Color(0xffFF4769).withOpacity(.4),
        title: "urology",
        doctorNumber: 45,
        imagePath: AppVectors.specialitiesUrology),
  ];

  static const List<DoctorModel> doctorlist = [
    DoctorModel(
        name: "Ahmed AlGarbani",
        imagePath: AppImage.doctor02,
        Speciality: "EYe"),
    DoctorModel(
        name: "Mosa Alroini",
        imagePath: AppImage.doctor03,
        Speciality: "Urology"),
    DoctorModel(
        name: "Abdullah Zakaria",
        imagePath: AppImage.doctor04,
        Speciality: "Knee"),
    DoctorModel(
        name: "Yasser Alonais",
        imagePath: AppImage.doctor05,
        Speciality: "Dentis"),
    DoctorModel(
        name: "Ammar Yasset",
        imagePath: AppImage.doctor06,
        Speciality: "Brain"),
  ];
}
