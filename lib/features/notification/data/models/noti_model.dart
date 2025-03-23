import 'package:intl/intl.dart';

class NotificationModel {
  final int notificationId;
  final int siteId;
  final String action;
  final String detail;
  final String imageUrl;
  final DateTime createdAt;
  final int createdBy;

  NotificationModel({
    required this.notificationId,
    required this.siteId,
    required this.action,
    required this.detail,
    required this.imageUrl,
    required this.createdAt,
    required this.createdBy,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['notification_id'],
      siteId: json['site_id'],
      action: json['action'],
      detail: json['detail'],
      imageUrl: json['image_url'] ??
          'https://github.com/thyms-c.png', // Default image
      createdAt: DateTime.parse(json['created_at']),
      createdBy: json['created_by'],
    );
  }

  String getFormattedDate() {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 7) {
      return DateFormat('MMM d, yyyy').format(createdAt);
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
}
