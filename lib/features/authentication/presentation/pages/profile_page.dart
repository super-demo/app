import 'package:app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:app/features/authentication/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status != AuthStatus.authenticated ||
            state.userProfile == null) {
          return const SizedBox.shrink();
        }

        final userProfile = state.userProfile!;

        return Container(
          color: Colors.white,
          height: double.infinity,
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                // Header with curved bottom and illustration
                Stack(
                  children: [
                    Container(
                      height: 280,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(
                                0xFF29DAFC), // Start with the bright cyan-blue
                            Color.fromRGBO(
                                177, 241, 252, 1), // End with the darker blue
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    Positioned(
                      right: -12,
                      top: 107.8,
                      height: 200,
                      width: 200,
                      child: Lottie.asset("assets/lottie/profile.json"),
                    ),
                    Positioned(
                      left: 24,
                      top: 100,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Hello,',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 64,
                                height: 64,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors
                                      .black, // Placeholder for profile picture
                                ),
                                child: userProfile.avatarUrl != null
                                    ? CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            userProfile.avatarUrl!),
                                      )
                                    : const Icon(
                                        Icons.person,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${userProfile.name?.split(' ').first ?? 'User'} M.',
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 100),
                          // Profile Picture
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Account Info Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Account Info',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(
                        icon: 'assets/svg/call.svg',
                        label: 'Name',
                        value: userProfile.name ?? 'N/A',
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(
                        icon: 'assets/svg/message35.svg',
                        label: 'Email',
                        value: userProfile.email ?? 'N/A',
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(
                        icon: 'assets/svg/building.svg',
                        label: 'Organization',
                        value:
                            'Kasetsart University', // Hardcoded as per the screenshot
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 52),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sign Out',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.redAccent,
                        ),
                      ),
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/svg/log-out.svg',
                          height: 24,
                          width: 24,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          context.read<AuthBloc>().add(SignOutEvent());
                        },
                      ),
                    ],
                  ),
                ),
              ])),
        );
      },
    );
  }

  Widget _buildInfoRow({
    required String icon,
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          height: 22,
          width: 22,
          color: Colors.black54,
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
