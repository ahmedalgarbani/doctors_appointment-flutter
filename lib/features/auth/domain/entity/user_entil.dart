class UserEntil {
  String? name;
  String? email;
  String? password;

  UserEntil({
    required this.name,
    required this.email,
    required this.password,
  });

  factory UserEntil.fromJson(Map<String, dynamic> json) {
    return UserEntil(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
