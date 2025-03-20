import 'package:app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:app/features/authentication/presentation/bloc/auth_state.dart';
import 'package:app/features/authentication/presentation/pages/home_page.dart';
import 'package:app/features/authentication/presentation/pages/login_screen.dart';
import 'package:app/features/authentication/presentation/pages/profile_page.dart';
import 'package:app/features/authentication/presentation/pages/services_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // To keep track of the selected tab

  // List of pages to navigate between
  static const List<Widget> _pages = <Widget>[
    HomePage(),
    ServicesPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  Widget _buildNavIcon({
    required String selectedIconPath,
    required String unselectedIconPath,
    required int index,
  }) {
    return SvgPicture.asset(
      _selectedIndex == index ? selectedIconPath : unselectedIconPath,
      height: 24,
      width: 24,
      color: _selectedIndex == index ? Colors.grey[800] : Colors.grey[600],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // If the user is not authenticated, redirect to LoginScreen
        if (state.status != AuthStatus.authenticated ||
            state.userProfile == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          });
          return const SizedBox.shrink();
        }

        // If authenticated, show the HomeScreen with the bottom navigation bar
        return Scaffold(
          body: _pages[_selectedIndex], // Display the selected page
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: _buildNavIcon(
                  selectedIconPath: 'assets/svg/home-filled.svg',
                  unselectedIconPath: 'assets/svg/home.svg',
                  index: 0,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _buildNavIcon(
                  selectedIconPath: 'assets/svg/layout-grid-filled.svg',
                  unselectedIconPath: 'assets/svg/layout-grid.svg',
                  index: 1,
                ),
                label: 'Services',
              ),
              BottomNavigationBarItem(
                icon: _buildNavIcon(
                  selectedIconPath: 'assets/svg/profile-1.svg',
                  unselectedIconPath: 'assets/svg/profile.svg',
                  index: 2,
                ),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.grey[800],
            unselectedItemColor: Colors.grey[600],
            selectedFontSize: 12,
            unselectedFontSize: 12,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
            
          ),
        );
      },
    );
  }
}
