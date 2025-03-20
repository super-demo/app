import 'package:app/core/constants/app_color.dart';
import 'package:app/features/notification/presentation/widgets/notification_card.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

class NotificationContents extends StatefulWidget {
  const NotificationContents({super.key});

  @override
  _NotificationContentsState createState() => _NotificationContentsState();
}

class _NotificationContentsState extends State<NotificationContents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    ButtonsTabBar(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      backgroundColor: AppColors.kColorPrimary,
                      unselectedBackgroundColor: Colors.grey[300],
                      unselectedLabelStyle:
                          const TextStyle(color: Colors.black),
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: const [
                        Tab(
                          text: "All",
                        ),
                        Tab(
                          text: "Recent",
                        ),
                        Tab(
                          text: "Older",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    ListView(
                      children: const [
                        NotificationCard(
                            title: "New announcements title ",
                            shortDescription:
                                "New announcements short description short description short description short description",
                            date: "6 days ago",
                            imageUrl: "https://github.com/thyms-c.png"),
                        NotificationCard(
                            title: "New announcements title ",
                            shortDescription:
                                "New announcements short description ",
                            date: "6 days ago",
                            imageUrl: "https://github.com/thyms-c.png"),
                        NotificationCard(
                            title: "New announcements title ",
                            shortDescription:
                                "New announcements short description ",
                            date: "6 days ago",
                            imageUrl: "https://github.com/thyms-c.png"),
                      ],
                    ),
                    ListView(
                      children: const [
                        NotificationCard(
                            title: "New announcements title ",
                            shortDescription:
                                "New announcements short description ",
                            date: "6 days ago",
                            imageUrl: "https://github.com/thyms-c.png"),
                      ],
                    ),
                    ListView(
                      children: const [
                        NotificationCard(
                            title: "New announcements title ",
                            shortDescription:
                                "New announcements short description ",
                            date: "6 days ago",
                            imageUrl: "https://github.com/thyms-c.png"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
