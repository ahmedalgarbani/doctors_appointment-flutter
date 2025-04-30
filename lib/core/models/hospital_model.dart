import 'package:doctors_appointment/core/network/end_points.dart';

class Hospital {
  final int id;
  final String name;
  final String slug;
  final double price;
  final String transactionNumber;
  final List<Schedule> schedules;
  final String? logoUrl;

  Hospital({
    required this.id,
    required this.name,
    required this.slug,
    required this.price,
    required this.transactionNumber,
    required this.schedules,
    this.logoUrl,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      price: (json['pricing']['amount'] as num).toDouble(),
      transactionNumber: json['pricing']['transaction_number'] as String,
      schedules: (json['schedules'] as List<dynamic>)
          .map((schedule) => Schedule.fromJson(schedule))
          .toList(),
      logoUrl: json['logo_url'] != null
          ? '${EndPoints.imageBaseUrl}${json['logo_url']}'
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'price': price,
        'transaction_number': transactionNumber,
        'schedules': schedules.map((e) => e.toJson()).toList(),
        'logo_url': logoUrl,
      };
}

class Schedule {
  final int day;
  final String dayDisplay;
  final List<Shift> shifts;

  Schedule({
    required this.day,
    required this.dayDisplay,
    required this.shifts,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      day: json['day'] as int,
      dayDisplay: json['day_display'] as String,
      shifts: (json['shifts'] as List<dynamic>)
          .map((shift) => Shift.fromJson(shift))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'day': day,
        'day_display': dayDisplay,
        'shifts': shifts.map((e) => e.toJson()).toList(),
      };
}

class Shift {
  final String startTime;
  final String endTime;
  final int availableSlots;
  final int bookedSlots;
  final bool isAvailable;

  Shift({
    required this.startTime,
    required this.endTime,
    required this.availableSlots,
    required this.bookedSlots,
    required this.isAvailable,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      availableSlots: json['available_slots'] as int,
      bookedSlots: json['booked_slots'] as int,
      isAvailable: json['is_available'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'start_time': startTime,
        'end_time': endTime,
        'available_slots': availableSlots,
        'booked_slots': bookedSlots,
        'is_available': isAvailable,
      };
}
