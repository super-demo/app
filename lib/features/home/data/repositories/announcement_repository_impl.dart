import 'package:app/core/services/api.dart';
import 'package:app/features/home/data/models/announcement_model.dart';

abstract class AnnouncementRepository {
  Future<List<Announcement>> getAnnouncementsBySiteId(int siteId);
  Future<Announcement> getAnnouncementById(int id);
}

class AnnouncementRepositoryImpl implements AnnouncementRepository {
  final ApiService apiService;

  AnnouncementRepositoryImpl({required this.apiService});

  @override
  Future<List<Announcement>> getAnnouncementsBySiteId(int siteId) async {
    try {
      final response = await apiService.get('announcements/list/$siteId');

      if (response['data'] != null) {
        final List<dynamic> announcementsJson = response['data'];
        return announcementsJson
            .map((json) => Announcement.fromJson(json))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching announcements: $e');
      throw Exception('Failed to fetch announcements');
    }
  }

  @override
  Future<Announcement> getAnnouncementById(int id) async {
    try {
      final response = await apiService.get('announcements/$id');

      if (response['data'] != null) {
        return Announcement.fromJson(response['data']);
      }
      throw Exception('Announcement not found');
    } catch (e) {
      print('Error fetching announcement: $e');
      throw Exception('Failed to fetch announcement');
    }
  }
}
