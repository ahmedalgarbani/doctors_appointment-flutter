import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'hospital.dart';

class Shift extends Equatable {
  final num? id;
  final Hospital? hospital;
  final String? startTime;
  final String? endTime;
  final num? availableSlots;
  final num? bookedSlots;
  final bool? isAvailable;

  const Shift({
    this.id,
    this.hospital,
    this.startTime,
    this.endTime,
    this.availableSlots,
    this.bookedSlots,
    this.isAvailable,
  });

  factory Shift.fromMap(Map<String, dynamic> data) => Shift(
        id: data['id'] as num?,
        hospital: data['hospital'] == null
            ? null
            : Hospital.fromMap(data['hospital'] as Map<String, dynamic>),
        startTime: data['start_time'] as String?,
        endTime: data['end_time'] as String?,
        availableSlots: data['available_slots'] as num?,
        bookedSlots: data['booked_slots'] as num?,
        isAvailable: data['is_available'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'hospital': hospital?.toMap(),
        'start_time': startTime,
        'end_time': endTime,
        'available_slots': availableSlots,
        'booked_slots': bookedSlots,
        'is_available': isAvailable,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Shift].
  factory Shift.fromJson(String data) {
    return Shift.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Shift] to a JSON string.
  String toJson() => json.encode(toMap());

  Shift copyWith({
    num? id,
    Hospital? hospital,
    String? startTime,
    String? endTime,
    num? availableSlots,
    num? bookedSlots,
    bool? isAvailable,
  }) {
    return Shift(
      id: id ?? this.id,
      hospital: hospital ?? this.hospital,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      availableSlots: availableSlots ?? this.availableSlots,
      bookedSlots: bookedSlots ?? this.bookedSlots,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      hospital,
      startTime,
      endTime,
      availableSlots,
      bookedSlots,
      isAvailable,
    ];
  }
}
