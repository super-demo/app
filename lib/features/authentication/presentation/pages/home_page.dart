import 'package:app/features/authentication/presentation/widgets/home_contents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Kasetsart University',
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                'assets/svg/bell.svg',
                color: Colors.grey[700],
              ),
              onPressed: () {
                // context.read<AuthBloc>().add(SignOutEvent());
              },
            ),
          ],
        ),
        body: const HomeContents(),
      ),
    );
  }
}
