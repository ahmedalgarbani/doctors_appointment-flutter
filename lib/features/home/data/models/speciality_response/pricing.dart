import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'hospital.dart';

class Pricing extends Equatable {
  final num? id;
  final Hospital? hospital;
  final String? amount;
  final String? transactionNumber;

  const Pricing({
    this.id,
    this.hospital,
    this.amount,
    this.transactionNumber,
  });

  factory Pricing.fromMap(Map<String, dynamic> data) => Pricing(
        id: data['id'] as num?,
        hospital: data['hospital'] == null
            ? null
            : Hospital.fromMap(data['hospital'] as Map<String, dynamic>),
        amount: data['amount'] as String?,
        transactionNumber: data['transaction_number'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'hospital': hospital?.toMap(),
        'amount': amount,
        'transaction_number': transactionNumber,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Pricing].
  factory Pricing.fromJson(String data) {
    return Pricing.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Pricing] to a JSON string.
  String toJson() => json.encode(toMap());

  Pricing copyWith({
    num? id,
    Hospital? hospital,
    String? amount,
    String? transactionNumber,
  }) {
    return Pricing(
      id: id ?? this.id,
      hospital: hospital ?? this.hospital,
      amount: amount ?? this.amount,
      transactionNumber: transactionNumber ?? this.transactionNumber,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, hospital, amount, transactionNumber];
}
