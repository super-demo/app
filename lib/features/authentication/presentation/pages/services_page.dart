import 'package:app/features/authentication/presentation/widgets/services_contents.dart';
import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'All Services',
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: const ServicesContents(),
      ),
    );
  }
}
