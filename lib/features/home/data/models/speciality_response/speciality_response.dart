import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'doctor.dart';

class SpecialityResponse extends Equatable {
  final num? id;
  final String? name;
  final String? image;
  final bool? showAtHome;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Doctor>? doctors;

  const SpecialityResponse({
    this.id,
    this.name,
    this.image,
    this.showAtHome,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.doctors,
  });

  factory SpecialityResponse.fromMap(Map<String, dynamic> data) {
    return SpecialityResponse(
      id: data['id'] as num?,
      name: data['name'] as String?,
      image: data['image'] as String?,
      showAtHome: data['show_at_home'] as bool?,
      status: data['status'] as bool?,
      createdAt: data['created_at'] == null
          ? null
          : DateTime.parse(data['created_at'] as String),
      updatedAt: data['updated_at'] == null
          ? null
          : DateTime.parse(data['updated_at'] as String),
      doctors: (data['doctors'] as List<dynamic>?)
          ?.map((e) => Doctor.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'image': image,
        'show_at_home': showAtHome,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'doctors': doctors?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SpecialityResponse].
  factory SpecialityResponse.fromJson(String data) {
    return SpecialityResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SpecialityResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  SpecialityResponse copyWith({
    num? id,
    String? name,
    String? image,
    bool? showAtHome,
    bool? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Doctor>? doctors,
  }) {
    return SpecialityResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      showAtHome: showAtHome ?? this.showAtHome,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      doctors: doctors ?? this.doctors,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      image,
      showAtHome,
      status,
      createdAt,
      updatedAt,
      doctors,
    ];
  }
}
