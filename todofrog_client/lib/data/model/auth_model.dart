class UserLogin {
  UserLogin({
    required this.email,
    required this.password,
  });
  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }
  String email;
  String password;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }
}

class UserRegister {
  UserRegister({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.isActive,
  });
  factory UserRegister.fromJson(Map<String, dynamic> json) {
    return UserRegister(
      id: json['id'] as int?,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      isActive: json['is_active'] as bool?,
    );
  }
  int? id;
  String name;
  String email;
  String password;
  bool? isActive;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'is_active': isActive ?? true,
    };
  }
}
