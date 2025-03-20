import 'package:app/features/notification/presentation/widgets/notification_contents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              'Notifications',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            centerTitle: false,
            actions: [
              IconButton(
                  onPressed: () => {Navigator.pop(context)},
                  icon: SvgPicture.asset(
                    "assets/svg/x.svg",
                    color: Colors.black54,
                  ))
            ]),
        body: const NotificationContents(),
      ),
    );
  }
}
