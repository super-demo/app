class WorkspaceModel {
  final int siteId;
  final int siteTypeId;
  final String name;
  final String description;
  final String shortDescription;
  final String url;
  final String imageUrl;
  final DateTime createdAt;
  final int createdBy;
  final DateTime updatedAt;
  final int updatedBy;
  final DateTime? deletedAt;
  final int siteParentId;
  final String siteParentName;
  final int depth;
  final List<int>? path;

  WorkspaceModel({
    required this.siteId,
    required this.siteTypeId,
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.url,
    required this.imageUrl,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
    this.deletedAt,
    required this.siteParentId,
    required this.siteParentName,
    required this.depth,
    this.path,
  });

  factory WorkspaceModel.fromJson(Map<String, dynamic> json) {
    return WorkspaceModel(
      siteId: json['site_id'],
      siteTypeId: json['site_type_id'],
      name: json['name'],
      description: json['description'] ?? '-',
      shortDescription: json['short_description'] ?? '-',
      url: json['url'] ?? '',
      imageUrl: json['image_url'] ?? 'https://github.com/thyms-c.png',
      createdAt: DateTime.parse(json['created_at']),
      createdBy: json['created_by'],
      updatedAt: DateTime.parse(json['updated_at']),
      updatedBy: json['updated_by'],
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      siteParentId: json['site_parent_id'],
      siteParentName: json['site_parent_name'],
      depth: json['depth'],
    );
  }
}
