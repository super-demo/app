class AuthToken {
  final String accessToken;
  final int expiresAt;
  final int userId;
  final int userLevelId;

  AuthToken({
    required this.accessToken,
    required this.expiresAt,
    required this.userId,
    required this.userLevelId,
  });
}
