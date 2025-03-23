import 'package:app/core/constants/app_color.dart';
import 'package:app/features/notification/data/models/noti_model.dart';
import 'package:app/features/notification/presentation/bloc/noti_bloc.dart';
import 'package:app/features/notification/presentation/bloc/noti_event.dart';
import 'package:app/features/notification/presentation/bloc/noti_state.dart';
import 'package:app/features/notification/presentation/widgets/notification_card.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationContents extends StatefulWidget {
  const NotificationContents({super.key});

  @override
  _NotificationContentsState createState() => _NotificationContentsState();
}

class _NotificationContentsState extends State<NotificationContents> {
  @override
  void initState() {
    super.initState();
    // Load notifications when the widget initializes
    context.read<NotificationBloc>().add(FetchAllNotifications());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              return Column(
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
                            Tab(text: "All"),
                            Tab(text: "Recent"),
                            Tab(text: "Older"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        _buildTabContent(
                          state,
                          (state is NotificationLoaded)
                              ? state.allNotifications
                              : [],
                        ),
                        _buildTabContent(
                          state,
                          (state is NotificationLoaded)
                              ? state.recentNotifications
                              : [],
                        ),
                        _buildTabContent(
                          state,
                          (state is NotificationLoaded)
                              ? state.olderNotifications
                              : [],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(
      NotificationState state, List<NotificationModel> notifications) {
    if (state is NotificationInitial || state is NotificationLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is NotificationError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.message,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<NotificationBloc>().add(RefreshNotifications());
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    } else if (state is NotificationLoaded) {
      if (notifications.isEmpty) {
        return const Center(
          child: Text(
            'No notifications found',
            style: TextStyle(fontSize: 16),
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () async {
          context.read<NotificationBloc>().add(RefreshNotifications());
        },
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return NotificationCard(
              title: notification.action,
              shortDescription: notification.detail,
              date: notification.getFormattedDate(),
              imageUrl: notification.imageUrl,
            );
          },
        ),
      );
    }

    // Fallback
    return const SizedBox();
  }
}
