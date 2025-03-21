import 'package:app/features/home/data/models/announcement_model.dart';

// Define the BannerInfo class with static values
class BannerInfo {
  final String url;
  final String title;
  final String subtitle;

  const BannerInfo({
    required this.url,
    required this.title,
    required this.subtitle,
  });

  // Static predefined banner values
  static const List<BannerInfo> values = [
    BannerInfo(
      url: 'shrine/vendors/0-0.jpg',
      title: 'SHRINE',
      subtitle: 'BETTER DRESSED, BETTER SERVED',
    ),
    BannerInfo(
      url: 'shrine/vendors/1-0.jpg',
      title: 'SHRINE',
      subtitle: 'BETTER THAN ONE-SIZE-FITS-ALL',
    ),
    BannerInfo(
      url: 'shrine/vendors/2-0.jpg',
      title: 'SHRINE',
      subtitle: 'BETTER LUCK TOMORROW',
    ),
    BannerInfo(
      url: 'shrine/vendors/3-0.jpg',
      title: 'SHRINE',
      subtitle: 'BETTER HORIZONS',
    ),
  ];

  // Static method to create BannerInfo from an Announcement
  static BannerInfo fromAnnouncement(Announcement announcement) {
    return BannerInfo(
      url: announcement.imageUrl,
      title: announcement.title,
      subtitle: announcement.shortDescription,
    );
  }
}
