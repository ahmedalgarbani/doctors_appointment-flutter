import 'package:dio/dio.dart';

class Patient {
  int? id;
  String birthDate;
  String gender;
  String address;
  String phoneNumber;
  String email;
  String joinDate;
  String? profilePicture;
  String? notes;
  String? password;
  String first_name;
  String last_name;

  Patient({
    this.id,
    required this.first_name,
    required this.last_name,
    required this.birthDate,
    required this.gender,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.joinDate,
    this.password,
    this.profilePicture,
    this.notes,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as int?,
      first_name: json['first_name'] ?? "",
      last_name: json['last_name'] ?? "",
      birthDate: json['birth_date'] ?? "",
      gender: json['gender'] ?? "",
      address: json['address'] ?? "",
      phoneNumber: json['mobile_number']?.toString() ?? "",
      email: json['email'] ?? "",
      joinDate: json['join_date'] ?? "",
      profilePicture: json['profile_picture'] ?? "",
      notes: json['notes'] ?? "",
      password: json['password'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
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
      first_name: map['first_name'],
      last_name: map['last_name'],
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


  Future<FormData> toFormData() async {
    Map<String, dynamic> fields = {
      "username": email,
      "email": email,
      "password": password,
      "first_name": first_name,
      "last_name": last_name,
      "mobile_number": phoneNumber,
      "address": address,
      "birth_date": birthDate,
      "gender": gender,
      "join_date": joinDate,
      "weight":"155",
      "height":"66",
      "age":"99", 
      "blood_group":"A-"
    };

    if (profilePicture != null) {
      fields["profile_picture"] = await MultipartFile.fromFile(profilePicture!, filename: "profile.jpg");
    }

    return FormData.fromMap(fields);
  }
}