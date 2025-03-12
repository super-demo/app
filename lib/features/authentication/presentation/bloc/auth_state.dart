import 'package:app/features/authentication/data/models/user_model.dart';

enum AuthStatus {
  initial,
  authenticating,
  authenticated,
  unauthenticated,
  error
}

class AuthState {
  final AuthStatus status;
  final String? errorMessage;
  final UserProfile? userProfile;
  final String? accessToken;

  AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.userProfile,
    this.accessToken,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    UserProfile? userProfile,
    String? accessToken,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      userProfile: userProfile ?? this.userProfile,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}
