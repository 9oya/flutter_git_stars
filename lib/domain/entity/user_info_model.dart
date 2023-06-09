class UserInfoModel {
  final String name;
  final String createdAt;
  final String updatedAt;

  UserInfoModel({
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
