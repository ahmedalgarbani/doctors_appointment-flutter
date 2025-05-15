class UserProfile {
  final int id;
  final String username;
  final String email;
  final String mobileNumber;
  final String? birthDate;
  final String gender;
  final double? weight;
  final double? height;

  final int? age;
  final String bloodGroup;
  final String firstName;
  final String lastName;
  final String address;
  final String city;
  final String state;
  final String? joinDate;

  UserProfile({
    required this.id,
    required this.username,
    required this.email,
    required this.mobileNumber,
    this.birthDate,
    required this.gender,
    this.weight,
    this.height,
    this.age,
    required this.bloodGroup,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.city,
    required this.state,
    this.joinDate,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final data = json['result'] ?? json;

    return UserProfile(
      id: data['id'] ?? 0,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      mobileNumber: data['mobile_number']?.toString() ?? '',
      birthDate: data['birth_date'],
      gender: data['gender'] ?? '',
      weight: (data['weight'] as num?)?.toDouble(),
      height: (data['height'] as num?)?.toDouble(),
      age: data['age'],
      bloodGroup: data['blood_group'] ?? '',
      firstName: data['first_name'] ?? '',
      lastName: data['last_name'] ?? '',
      address: data['address'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      joinDate: data['join_date'],
    );
  }

  Map<String, dynamic> toJson() {
    String? formatDate(String? dateStr) {
      if (dateStr == null) return null;
      try {
        final dt = DateTime.parse(dateStr);
        return dt.toIso8601String().split('T').first;
      } catch (_) {
        return null;
      }
    }

    return {
      'username': username,
      'email': email,
      'mobile_number': mobileNumber,
      'birth_date': formatDate(birthDate),
      'gender': gender,
      'weight': weight,
      'height': height,
      'age': age,
      'blood_group': bloodGroup,
      'first_name': firstName,
      'last_name': lastName,
      'address': address,
      'city': city,
      'state': state,
      'join_date': formatDate(joinDate),
    };
  }

  UserProfile copyWith({
    int? id,
    String? username,
    String? email,
    String? mobileNumber,
    String? birthDate,
    String? gender,
    double? weight,
    double? height,
    int? age,
    String? bloodGroup,
    String? firstName,
    String? lastName,
    String? address,
    String? city,
    String? state,
    String? joinDate,
  }) {
    return UserProfile(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      age: age ?? this.age,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      joinDate: joinDate ?? this.joinDate,
    );
  }
}
