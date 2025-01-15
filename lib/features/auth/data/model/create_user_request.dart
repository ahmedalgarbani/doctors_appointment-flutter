
class Patient {
  int? id;
  String fullName;
  String birthDate;
  String gender;
  String address;
  String phoneNumber;
  String email;
  String joinDate;
  String? profilePicture;
  String? notes;
  String password;

  Patient({
    this.id,
    required this.fullName,
    required this.birthDate,
    required this.gender,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.joinDate,
    required this.password,
    this.profilePicture,
    this.notes,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      fullName: json['full_name'],
      birthDate: json['birth_date'],
      gender: json['gender'],
      address: json['address'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      joinDate: json['join_date'],
      profilePicture: json['profile_picture'],
      notes: json['notes'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'birth_date': birthDate,
      'gender': gender,
      'address': address,
      'phone_number': phoneNumber,
      'email': email,
      'join_date': joinDate,
      'profile_picture': profilePicture,
      'notes': notes,
      'password': password,
    };
  }

  toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'birth_date': birthDate,
      'gender': gender,
      'address': address,
      'phone_number': phoneNumber,
      'email': email,
      'join_date': joinDate,
      'profile_picture': profilePicture,
      'notes': notes,
      'password': password,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'],
      fullName: map['full_name'],
      birthDate: map['birth_date'],
      gender: map['gender'],
      address: map['address'],
      phoneNumber: map['phone_number'],
      email: map['email'],
      joinDate: map['join_date'],
      profilePicture: map['profile_picture'],
      notes: map['notes'],
      password: map['password'],
    );
  }
}
