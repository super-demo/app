import 'package:app/core/services/api.dart';
import 'package:app/features/notification/data/models/noti_model.dart';

abstract class NotificationRepository {
  Future<List<NotificationModel>> getAllNotifications();
  Future<List<NotificationModel>> getRecentNotifications();
  Future<List<NotificationModel>> getOlderNotifications();
}

class NotificationRepositoryImpl implements NotificationRepository {
  final ApiService apiService;

  NotificationRepositoryImpl({required this.apiService});

  @override
  Future<List<NotificationModel>> getAllNotifications() async {
    try {
      final response = await apiService.get('notifications/list');

      if (response['data'] != null && response['data'] is List) {
        return (response['data'] as List)
            .map((item) => NotificationModel.fromJson(item))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching notifications: $e');
      return [];
    }
  }

  @override
  Future<List<NotificationModel>> getRecentNotifications() async {
    try {
      final allNotifications = await getAllNotifications();
      final now = DateTime.now();

      // Filter notifications from the last 3 days
      return allNotifications
          .where((notification) =>
              now.difference(notification.createdAt).inDays <= 3)
          .toList();
    } catch (e) {
      print('Error fetching recent notifications: $e');
      return [];
    }
  }

  @override
  Future<List<NotificationModel>> getOlderNotifications() async {
    try {
      final allNotifications = await getAllNotifications();
      final now = DateTime.now();

      // Filter notifications older than 3 days
      return allNotifications
          .where((notification) =>
              now.difference(notification.createdAt).inDays > 3)
          .toList();
    } catch (e) {
      print('Error fetching older notifications: $e');
      return [];
    }
  }
}
