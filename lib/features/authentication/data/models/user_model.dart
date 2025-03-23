class UserProfile {
  final int userId;
  final String name;
  final String email;
  final String? avatarUrl;
  final int userLevelId;

  UserProfile({
    required this.userId,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.userLevelId,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
      userLevelId: json['user_level_id'],
    );
  }
}
