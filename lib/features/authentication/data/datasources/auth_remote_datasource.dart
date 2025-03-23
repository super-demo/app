import 'dart:convert';

import 'package:app/features/authentication/data/models/auth_token.dart';
import 'package:app/features/authentication/data/models/google_sign_token.dart';
import 'package:app/features/authentication/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRemoteDataSource {
  Future<AuthToken> signInWithGoogle();
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );
  final String baseUrl;
  final String appSecret;

  AuthRemoteDataSourceImpl({
    required this.baseUrl,
    required this.appSecret,
  });

  @override
  Future<AuthToken> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign-in was canceled');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final googleSignInResponse =
          await _authenticateWithBackend(googleAuth.accessToken!);

      final decodedJwt = _decodeJwt(googleSignInResponse.accessToken);
      if (decodedJwt == null) {
        throw Exception(
            'Login failed! An unexpected error occurred. Please try again.');
      }

      final userProfile = await getUserProfile(
        decodedJwt['user_id'],
        googleSignInResponse.accessToken,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', googleSignInResponse.accessToken);
      await prefs.setInt('expires_at', googleSignInResponse.expiresAt);
      await prefs.setInt('user_id', userProfile.userId);
      await prefs.setInt('user_level_id', userProfile.userLevelId);

      return AuthToken(
        accessToken: googleSignInResponse.accessToken,
        expiresAt: googleSignInResponse.expiresAt,
        userId: userProfile.userId,
        userLevelId: userProfile.userLevelId,
      );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<GoogleSignInToken> _authenticateWithBackend(String accessToken) async {
    final response = await http.post(
      Uri.parse('$baseUrl/authentications/user/sign/google'),
      headers: {
        'Content-Type': 'application/json',
        'App-Secret': appSecret,
      },
      body: jsonEncode({'access_token': accessToken}),
    );

    if (response.statusCode != 200) {
      final errorData = jsonDecode(response.body);
      if (errorData['status']?['code'] == 404002) {
        throw Exception('Sorry, we couldn\'t find your Google Account');
      }
      throw Exception('Login request failed');
    }

    final data = jsonDecode(response.body);
    return GoogleSignInToken.fromJson(data['data']);
  }

  Map<String, dynamic>? _decodeJwt(String token) {
    try {
      final decoded = JwtDecoder.decode(token);
      return decoded;
    } catch (error) {
      return null;
    }
  }

  Future<UserProfile> getUserProfile(int userId, String accessToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/$userId/profile'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch user profile');
    }

    final data = jsonDecode(response.body);
    return UserProfile.fromJson(data['data']);
  }

  Future<AuthToken?> getStoredAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final expiresAt = prefs.getInt('expires_at');
    final userId = prefs.getInt('user_id');
    final userLevelId = prefs.getInt('user_level_id');

    if (accessToken != null &&
        expiresAt != null &&
        userId != null &&
        userLevelId != null) {
      if (DateTime.now().millisecondsSinceEpoch < expiresAt * 1000) {
        return AuthToken(
          accessToken: accessToken,
          expiresAt: expiresAt,
          userId: userId,
          userLevelId: userLevelId,
        );
      }
    }
    return null;
  }
}
