import 'package:intl/intl.dart';

class Announcement {
  final int announcementId;
  final int siteId;
  final String title;
  final String shortDescription;
  final String imageUrl;
  final bool isPin;
  final DateTime createdAt;
  final int createdBy;

  Announcement({
    required this.announcementId,
    required this.siteId,
    required this.title,
    required this.shortDescription,
    required this.imageUrl,
    required this.isPin,
    required this.createdAt,
    required this.createdBy,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      announcementId: json['announcement_id'],
      siteId: json['site_id'],
      title: json['title'],
      shortDescription: json['short_description'],
      imageUrl: json['image_url'],
      isPin: json['is_pin'],
      createdAt: DateTime.parse(json['created_at']),
      createdBy: json['created_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'announcement_id': announcementId,
      'site_id': siteId,
      'title': title,
      'short_description': shortDescription,
      'image_url': imageUrl,
      'is_pin': isPin,
      'created_at': DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(createdAt),
      'created_by': createdBy,
    };
  }
}
