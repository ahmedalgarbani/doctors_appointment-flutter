class SpecialtyModel {
  final int id;
  final String name;
  final String? image;
  final int showAtHome;
  final int status;

  SpecialtyModel({
    required this.id,
    required this.name,
    this.image,
    this.showAtHome = 1,
    this.status = 1,
  });

  factory SpecialtyModel.fromMap(Map<String, dynamic> map) {
    return SpecialtyModel(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String?,
      showAtHome: map['show_at_home'] as int,
      status: map['status'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'show_at_home': showAtHome,
      'status': status,
    };
  }
}
