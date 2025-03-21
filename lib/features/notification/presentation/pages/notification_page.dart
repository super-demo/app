import 'package:app/features/notification/data/repositories/noti_repository_impl.dart';
import 'package:app/features/notification/presentation/bloc/noti_bloc.dart';
import 'package:app/features/notification/presentation/widgets/notification_contents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc(
        repository: context.read<NotificationRepository>(),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Text(
            'Notifications',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: SvgPicture.asset(
                "assets/svg/x.svg",
                color: Colors.black54,
              ),
            ),
          ],
        ),
        body: const NotificationContents(),
      ),
    );
  }
}
