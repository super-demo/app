import 'package:app/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:app/features/authentication/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthState()) {
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<SignOutEvent>(_onSignOut);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
  }

  Future<void> _onSignInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AuthStatus.authenticating));

      final authToken = await authRepository.signInWithGoogle();

      final userProfile = await authRepository.getUserProfile(
        authToken.userId,
        authToken.accessToken,
      );

      emit(state.copyWith(
        status: AuthStatus.authenticated,
        userProfile: userProfile,
        accessToken: authToken.accessToken,
        errorMessage: null,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> _onSignOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await authRepository.signOut();
      emit(AuthState(status: AuthStatus.unauthenticated));
    } catch (error) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Failed to sign out: ${error.toString()}',
      ));
    }
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final authToken = await authRepository.checkAuthStatus();

      if (authToken != null) {
        final userProfile = await authRepository.getUserProfile(
          authToken.userId,
          authToken.accessToken,
        );

        emit(state.copyWith(
          status: AuthStatus.authenticated,
          userProfile: userProfile,
          accessToken: authToken.accessToken,
        ));
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      }
    } catch (error) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Failed to check auth status: ${error.toString()}',
      ));
    }
  }
}
