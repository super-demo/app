import 'package:app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:app/features/authentication/presentation/bloc/auth_state.dart';
import 'package:app/features/authentication/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO: Implement this screen (mock)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(SignOutEvent());
            },
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.status == AuthStatus.authenticated &&
              state.userProfile != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state.userProfile!.avatarUrl != null)
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(state.userProfile!.avatarUrl!),
                      radius: 40,
                    ),
                  const SizedBox(height: 16),
                  Text(
                    'Welcome, ${state.userProfile!.name}!',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(state.userProfile!.email),
                  const SizedBox(height: 16),
                  Text('User ID: ${state.userProfile!.userId}'),
                  Text('User Level: ${state.userProfile!.userLevelId}'),
                ],
              ),
            );
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          });
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
