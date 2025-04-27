import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'hospital.dart';
import 'pricing.dart';
import 'review.dart';
import 'schedule.dart';

class 
Doctor extends Equatable {
  final num? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? fullName;
  final String? birthday;
  final String? photo;
  final num? gender;
  final num? experienceYears;
  final String? subTitle;
  final String? about;
  final bool? showAtHome;
  final List<Hospital>? hospitals;
  final List<Schedule>? schedules;
  final List<Pricing>? pricing;
  final List<Review>? reviews;
  final num? rating;

  const Doctor({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.fullName,
    this.birthday,
    this.photo,
    this.gender,
    this.experienceYears,
    this.subTitle,
    this.about,
    this.showAtHome,
    this.hospitals,
    this.schedules,
    this.pricing,
    this.reviews,
    this.rating,
  });

  factory Doctor.fromMap(Map<String, dynamic> data) => Doctor(
        id: data['id'] as num?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
        deletedAt: data['deleted_at'] as dynamic,
        fullName: data['full_name'] as String?,
        birthday: data['birthday'] as String?,
        photo: data['photo'] as String?,
        gender: data['gender'] as num?,
        experienceYears: data['experience_years'] as num?,
        subTitle: data['sub_title'] as String?,
        about: data['about'] as String?,
        showAtHome: data['show_at_home'] as bool?,
        hospitals: (data['hospitals'] as List<dynamic>?)
            ?.map((e) => Hospital.fromMap(e as Map<String, dynamic>))
            .toList(),
        schedules: (data['schedules'] as List<dynamic>?)
            ?.map((e) => Schedule.fromMap(e as Map<String, dynamic>))
            .toList(),
        pricing: (data['pricing'] as List<dynamic>?)
            ?.map((e) => Pricing.fromMap(e as Map<String, dynamic>))
            .toList(),
        reviews: (data['reviews'] as List<dynamic>?)
            ?.map((e) => Review.fromMap(e as Map<String, dynamic>))
            .toList(),
        rating: data['rating'] as num?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'deleted_at': deletedAt,
        'full_name': fullName,
        'birthday': birthday,
        'photo': photo,
        'gender': gender,
        'experience_years': experienceYears,
        'sub_title': subTitle,
        'about': about,
        'show_at_home': showAtHome,
        'hospitals': hospitals?.map((e) => e.toMap()).toList(),
        'schedules': schedules?.map((e) => e.toMap()).toList(),
        'pricing': pricing?.map((e) => e.toMap()).toList(),
        'reviews': reviews?.map((e) => e.toMap()).toList(),
        'rating': rating,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Doctor].
  factory Doctor.fromJson(String data) {
    return Doctor.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Doctor] to a JSON string.
  String toJson() => json.encode(toMap());

  Doctor copyWith({
    num? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    String? fullName,
    String? birthday,
    String? photo,
    num? gender,
    num? experienceYears,
    String? subTitle,
    String? about,
    bool? showAtHome,
    List<Hospital>? hospitals,
    List<Schedule>? schedules,
    List<Pricing>? pricing,
    List<Review>? reviews,
    num? rating,
  }) {
    return Doctor(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      fullName: fullName ?? this.fullName,
      birthday: birthday ?? this.birthday,
      photo: photo ?? this.photo,
      gender: gender ?? this.gender,
      experienceYears: experienceYears ?? this.experienceYears,
      subTitle: subTitle ?? this.subTitle,
      about: about ?? this.about,
      showAtHome: showAtHome ?? this.showAtHome,
      hospitals: hospitals ?? this.hospitals,
      schedules: schedules ?? this.schedules,
      pricing: pricing ?? this.pricing,
      reviews: reviews ?? this.reviews,
      rating: rating ?? this.rating,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      createdAt,
      updatedAt,
      deletedAt,
      fullName,
      birthday,
      photo,
      gender,
      experienceYears,
      subTitle,
      about,
      showAtHome,
      hospitals,
      schedules,
      pricing,
      reviews,
      rating,
    ];
  }

  get name => null;
}
