// lib/features/notification/presentation/bloc/notification_event.dart
import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class FetchAllNotifications extends NotificationEvent {}

class FetchRecentNotifications extends NotificationEvent {}

class FetchOlderNotifications extends NotificationEvent {}

class RefreshNotifications extends NotificationEvent {}
