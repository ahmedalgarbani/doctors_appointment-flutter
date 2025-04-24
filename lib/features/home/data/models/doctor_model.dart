class DoctorModel {
  final int? id;
  final String name;
  final String birthday;
  final String phoneNumber;
  final int specialtyId;
  final String? imagePath;
  final int gender;
  final String email;
  final int experienceYears;
  final String? subTitle;
  final String slug;
  final String? about;
  final int status;
  final int showAtHome;
  final String? specialtyName;

  const DoctorModel({
    this.id,
    required this.name,
    required this.birthday,
    required this.phoneNumber,
    required this.specialtyId,
    this.imagePath,
    required this.gender,
    required this.specialtyName,
    required this.email,
    required this.experienceYears,
    this.subTitle,
    required this.slug,
    this.about,
    required this.status,
    required this.showAtHome,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'],
      name: map['full_name'],
      specialtyName: map['specialty_name'],
      birthday: map['birthday'],
      phoneNumber: map['phone_number'],
      specialtyId: map['specialty_id'],
      imagePath: map['photo'],
      gender: map['gender'],
      email: map['email'],
      experienceYears: map['experience_years'],
      subTitle: map['sub_title'],
      slug: map['slug'],
      about: map['about'],
      status: map['status'],
      showAtHome: map['show_at_home'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': name,
      'birthday': birthday,
      'phone_number': phoneNumber,
      'specialty_id': specialtyId,
      'photo': imagePath,
      'gender': gender,
      'specialty_name': specialtyName,
      'email': email,
      'experience_years': experienceYears,
      'sub_title': subTitle,
      'slug': slug,
      'about': about,
      'status': status,
      'show_at_home': showAtHome,
    };
  }
}
