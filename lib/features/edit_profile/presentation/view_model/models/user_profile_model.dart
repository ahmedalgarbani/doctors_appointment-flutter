class UserProfileModel {
  String firstName;
  String lastName;
  String email;
  String phone;
  String address;
  String city;
  String state;
  DateTime birthDate;
  String gender;
  String age;
  String bloodGroup;
  String notes;
  String? imagePath;

  UserProfileModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.birthDate,
    required this.gender,
    required this.age,
    required this.bloodGroup,
    required this.notes,
    this.imagePath,
  });

  UserProfileModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? address,
    String? city,
    String? state,
    DateTime? birthDate,
    String? gender,
    String? age,
    String? bloodGroup,
    String? notes,
    String? imagePath,
  }) {
    return UserProfileModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      notes: notes ?? this.notes,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
