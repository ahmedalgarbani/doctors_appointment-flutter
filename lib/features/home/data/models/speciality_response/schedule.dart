import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'hospital.dart';
import 'shift.dart';

class Schedule extends Equatable {
  final num? id;
  final Hospital? hospital;
  final num? day;
  final String? dayName;
  final List<Shift>? shifts;

  const Schedule({
    this.id,
    this.hospital,
    this.day,
    this.dayName,
    this.shifts,
  });

  factory Schedule.fromMap(Map<String, dynamic> data) => Schedule(
        id: data['id'] as num?,
        hospital: data['hospital'] == null
            ? null
            : Hospital.fromMap(data['hospital'] as Map<String, dynamic>),
        day: data['day'] as num?,
        dayName: data['day_name'] as String?,
        shifts: (data['shifts'] as List<dynamic>?)
            ?.map((e) => Shift.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'hospital': hospital?.toMap(),
        'day': day,
        'day_name': dayName,
        'shifts': shifts?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Schedule].
  factory Schedule.fromJson(String data) {
    return Schedule.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Schedule] to a JSON string.
  String toJson() => json.encode(toMap());

  Schedule copyWith({
    num? id,
    Hospital? hospital,
    num? day,
    String? dayName,
    List<Shift>? shifts,
  }) {
    return Schedule(
      id: id ?? this.id,
      hospital: hospital ?? this.hospital,
      day: day ?? this.day,
      dayName: dayName ?? this.dayName,
      shifts: shifts ?? this.shifts,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, hospital, day, dayName, shifts];
}
