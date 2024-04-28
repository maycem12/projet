class UserM {
  String id, email, np, image;
  bool admin, enable, isdelete;
  static late UserM currentUser;
  UserM({
    required this.id,
    required this.email,
    required this.np,
    this.image = '',
    this.admin = false,
    this.enable = true,
    this.isdelete = false,
  });
  factory UserM.fromJson(Map<String, dynamic> json) {
    return UserM(
      email: json['email'],
      id: json['id'],
      np: json['np'],
      image: json['image'],
      admin: json['admin'],
      enable: json['enable'],
      isdelete: json['isdelete'] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'np': np,
      'image': image,
      'admin': admin,
      'enable': enable,
      'isdelete': isdelete,
    };
  }
}
