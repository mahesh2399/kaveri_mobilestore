class Product {
  final String id;
  final String name;
  final List<dynamic> slug;
  final String description;
  final String? createdAt;
  final String? updatedAt;
  final int? blogsCount;
  final int productsCount;
  final String? thumbnailImage;
  final String? thumbnail_image_url;
  final String? salePrice;
  final String? discount;
  final String? isFeatured;
  final String stockStatus;
  final Map<String, dynamic>? variations;

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
     this.createdAt,
     this.updatedAt,
     this.blogsCount,
    required this.productsCount,
     this.thumbnailImage,
     this.thumbnail_image_url,
     this.salePrice,
     this.discount,
     this.isFeatured,
    required this.stockStatus,
     this.variations,
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
      thumbnail_image_url: json['thumbnail_image_url'] ?? '',
      salePrice: json['sale_price'] ?? '',
      discount: json['discount'] ?? '',
      isFeatured: json['is_featured'] ?? '',
      stockStatus: json['stock_status'] ?? '',
      variations: json['variations'] ?? {},
    );
  }
}
