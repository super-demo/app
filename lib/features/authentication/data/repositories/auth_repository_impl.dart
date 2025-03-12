import 'package:app/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:app/features/authentication/data/models/auth_token.dart';
import 'package:app/features/authentication/data/models/user_model.dart';

class AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepository({required this.authRemoteDataSource});

  Future<AuthToken> signInWithGoogle() async {
    return await authRemoteDataSource.signInWithGoogle();
  }

  Future<void> signOut() async {
    await authRemoteDataSource.signOut();
  }

  Future<AuthToken?> checkAuthStatus() async {
    if (authRemoteDataSource is AuthRemoteDataSourceImpl) {
      return await (authRemoteDataSource as AuthRemoteDataSourceImpl)
          .getStoredAuthToken();
    }
    return null;
  }

  Future<UserProfile> getUserProfile(int userId, String accessToken) async {
    if (authRemoteDataSource is AuthRemoteDataSourceImpl) {
      return await (authRemoteDataSource as AuthRemoteDataSourceImpl)
          .getUserProfile(userId, accessToken);
    }
    throw Exception(
        'AuthRemoteDataSource implementation does not support getUserProfile');
  }
}
