import 'dart:convert';

import 'package:equatable/equatable.dart';

class Hospital extends Equatable {
  final num? id;
  final String? name;
  final bool? status;
  final bool? showAtHome;

  const Hospital({this.id, this.name, this.status, this.showAtHome});

  factory Hospital.fromMap(Map<String, dynamic> data) => Hospital(
        id: data['id'] as num?,
        name: data['name'] as String?,
        status: data['status'] as bool?,
        showAtHome: data['show_at_home'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'status': status,
        'show_at_home': showAtHome,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Hospital].
  factory Hospital.fromJson(String data) {
    return Hospital.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Hospital] to a JSON string.
  String toJson() => json.encode(toMap());

  Hospital copyWith({
    num? id,
    String? name,
    bool? status,
    bool? showAtHome,
  }) {
    return Hospital(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      showAtHome: showAtHome ?? this.showAtHome,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, status, showAtHome];
}
