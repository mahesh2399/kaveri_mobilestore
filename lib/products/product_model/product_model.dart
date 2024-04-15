// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final String thumbnail_image_url;
  final int salePrice;
  final int discount;
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
    required this.thumbnail_image_url,
    required this.salePrice,
    required this.discount,
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
      salePrice: int.parse(json['sale_price'] ?? '0'),
      discount: int.parse(json['discount'] ?? '0'),
      isFeatured: json['is_featured'] ?? '',
      stockStatus: json['stock_status'] ?? '',
      variations: json['variations'] ?? {},
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, slug: $slug, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, blogsCount: $blogsCount, productsCount: $productsCount, thumbnailImage: $thumbnailImage, thumbnail_image_url: $thumbnail_image_url, salePrice: $salePrice, discount: $discount, isFeatured: $isFeatured, stockStatus: $stockStatus, variations: $variations)';
  }
}

class ProductsForCart {
   String name;
   String imageUrl;
   int price;
   int availableQuantity;
   int wantedQuantity;//quantity needed for the user 
   int discount;
   int tax;

  ProductsForCart(
      {required this.name,
      required this.imageUrl,
      required this.price,
      required this.availableQuantity,
      required this.discount,
      required this.wantedQuantity,
      required this.tax});
}

class CartModel {
  final List<ProductsForCart> productsList;
  final int subTotal;
  final int tax;
   double grandTotal;
  CartModel(
      {required this.productsList,
      required this.subTotal,
      required this.tax,
      required this.grandTotal});
}
