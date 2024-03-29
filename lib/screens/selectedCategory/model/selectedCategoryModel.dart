class Category {
  final String id;
  final String name;
  final String slug;
  final String thumbnail_image_url;
  final String type;
  final String description;
  final String status;
  final int createdById;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int blogsCount;
  final int productsCount;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.thumbnail_image_url,
    required this.type,
    required this.description,
    required this.status,
    required this.createdById,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.blogsCount,
    required this.productsCount,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      thumbnail_image_url: json[' thumbnail_image_url'] ?? '',
      type: json['type'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      createdById: json['created_by_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      deletedAt: json['deleted_at'],
      blogsCount: json['blogs_count'] ?? 0,
      productsCount: json['products_count'] ?? 0,
    );
  }
}
