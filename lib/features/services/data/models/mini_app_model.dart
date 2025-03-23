class MiniAppModel {
  final int siteMiniAppId;
  final int siteId;
  final String slug;
  final String description;
  final String shortDescription;
  final String linkUrl;
  final String imageUrl;
  final bool isActive;
  final DateTime createdAt;
  final int createdBy;
  final DateTime updatedAt;
  final int updatedBy;
  final DateTime? deletedAt;

  MiniAppModel({
    required this.siteMiniAppId,
    required this.siteId,
    required this.slug,
    required this.description,
    required this.shortDescription,
    required this.linkUrl,
    required this.imageUrl,
    required this.isActive,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
    this.deletedAt,
  });

  factory MiniAppModel.fromJson(Map<String, dynamic> json) {
    return MiniAppModel(
      siteMiniAppId: json['site_mini_app_id'],
      siteId: json['site_id'],
      slug: json['slug'],
      description: json['description'] ?? '-',
      shortDescription: json['short_description'] ?? '-',
      linkUrl: json['link_url'] ?? '',
      imageUrl: json['image_url'] ?? 'https://github.com/thyms-c.png',
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      createdBy: json['created_by'],
      updatedAt: DateTime.parse(json['updated_at']),
      updatedBy: json['updated_by'],
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }
}
