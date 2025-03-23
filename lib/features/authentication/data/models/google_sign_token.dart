class GoogleSignInToken {
  final String accessToken;
  final int expiresAt;

  GoogleSignInToken({
    required this.accessToken,
    required this.expiresAt,
  });

  factory GoogleSignInToken.fromJson(Map<String, dynamic> json) {
    return GoogleSignInToken(
      accessToken: json['access_token'],
      expiresAt: json['expires_at'],
    );
  }
}
