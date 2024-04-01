class Product {
  final String id;
  final String name;
  final List<dynamic> slug;
  final String description;
  final String createdAt;
  final String updatedAt;
  final int blogsCount;
  final int productsCount;
  final String thumbnailImage;
  final String thumbnailImageUrl;
  final String salePrice;
  final String discount;
  final String isFeatured;
  final String stockStatus;
  final Map<String, dynamic> variations;

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.blogsCount,
    required this.productsCount,
    required this.thumbnailImage,
    required this.thumbnailImageUrl,
    required this.salePrice,
    required this.discount,
    required this.isFeatured,
    required this.stockStatus,
    required this.variations,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? [],
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      blogsCount: json['blogs_count'] ?? 0,
      productsCount: json['products_count'] ?? 0,
      thumbnailImage: json['thumbnail_image'] ?? '',
      thumbnailImageUrl: json['thumbnail_image_url'] ?? '',
      salePrice: json['sale_price'] ?? '',
      discount: json['discount'] ?? '',
      isFeatured: json['is_featured'] ?? '',
      stockStatus: json['stock_status'] ?? '',
      variations: json['variations'] ?? {},
    );
  }
}
