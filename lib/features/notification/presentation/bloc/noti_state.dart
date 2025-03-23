import 'package:app/features/notification/data/models/noti_model.dart';
import 'package:equatable/equatable.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationModel> allNotifications;
  final List<NotificationModel> recentNotifications;
  final List<NotificationModel> olderNotifications;

  const NotificationLoaded({
    required this.allNotifications,
    required this.recentNotifications,
    required this.olderNotifications,
  });

  @override
  List<Object> get props =>
      [allNotifications, recentNotifications, olderNotifications];
}

class NotificationError extends NotificationState {
  final String message;

  const NotificationError(this.message);

  @override
  List<Object> get props => [message];
}
