class UserInfoModel {
  final String? name;
  final String createdAt;
  final String updatedAt;
  final String followers;
  final String following;
  final String? email;

  UserInfoModel({
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.followers,
    required this.following,
    required this.email,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      followers: '0',
      following: '0',
      email: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'followers': followers,
      'following': following,
      'email': email,
    };
  }
}
