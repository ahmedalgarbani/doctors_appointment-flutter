import 'dart:convert';

import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final num? id;
  final String? userName;
  final String? profilePicture;
  final num? rating;
  final String? review;
  final DateTime? createdAt;

  const Review({
    this.id,
    this.userName,
    this.profilePicture,
    this.rating,
    this.review,
    this.createdAt,
  });

  factory Review.fromMap(Map<String, dynamic> data) => Review(
        id: data['id'] as num?,
        userName: data['user_name'] as String?,
        profilePicture: data['profile_picture'] as String?,
        rating: data['rating'] as num?,
        review: data['review'] as String?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_name': userName,
        'profile_picture': profilePicture,
        'rating': rating,
        'review': review,
        'created_at': createdAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Review].
  factory Review.fromJson(String data) {
    return Review.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Review] to a JSON string.
  String toJson() => json.encode(toMap());

  Review copyWith({
    num? id,
    String? userName,
    String? profilePicture,
    num? rating,
    String? review,
    DateTime? createdAt,
  }) {
    return Review(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      profilePicture: profilePicture ?? this.profilePicture,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      userName,
      profilePicture,
      rating,
      review,
      createdAt,
    ];
  }
}
