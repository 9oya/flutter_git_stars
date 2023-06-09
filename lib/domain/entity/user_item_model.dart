class UserItemModel {
  final int id;
  final String login;
  final String avatarUrl;

  UserItemModel({
    required this.id,
    required this.login,
    required this.avatarUrl,
  });

  factory UserItemModel.fromJson(Map<String, dynamic> json) {
    return UserItemModel(
      id: json['id'],
      login: json['login'],
      avatarUrl: json['avatar_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'avatar_url': avatarUrl,
    };
  }
}
