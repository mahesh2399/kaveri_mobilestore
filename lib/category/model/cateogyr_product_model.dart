// List.from(json['data']).map((e)=>CategoryProduct.fromJson(e)).toList();

class CategoryProduct {
  CategoryProduct({
    required this.id,
    required this.name,
    required this.slug,
    
    this.description,
    this.categoryImageId,
    this.categoryIconId,
    required this.status,
    required this.type,
    this.commissionRate,
    this.parentId,
    required this.createdById,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.blogsCount,
    required this.productsCount,
    required this.thumbnailImage,
    required this.thumbnailImageUrl,
    this.categoryIcon,
    required this.subcategories,
    this.parent,
    required this.shortDescription,
    required this.unit,
    required this.weight,
    required this.quantity,
    required this.salePrice,
    required this.discount,
    required this.isFeatured,
    required this.shippingDays,
    required this.isCod,
    required this.isFreeShipping,
    required this.isSaleEnable,
    required this.isReturn,
    required this.isTrending,
    required this.isApproved,
    required this.saleStartsAt,
    required this.saleExpiredAt,
    required this.sku,
    required this.isRandomRelatedProducts,
    required this.stockStatus,
    required this.metaTitle,
    required this.metaDescription,
    required this.productThumbnailId,
    required this.productMetaImageId,
    required this.sizeChartImageId,
    required this.estimatedDeliveryText,
    required this.returnPolicyText,
    required this.safeCheckout,
    required this.secureCheckout,
    required this.socialShare,
    required this.encourageOrder,
    required this.encourageView,
    required this.storeId,
    required this.taxId,
    required this.ordersCount,
    required this.reviewsCount,
    required this.canReview,
    required this.ratingCount,
    required this.orderAmount,
    required this.reviewRatings,
    required this.relatedProduct,
    required this.crossSellProducts,
    required this.productThumbnail,
    required this.productGalleries,
    required this.productMetaImage,
    required this.reviews,
    required this.store,
    required this.storeLogo,
    required this.storeCover,
    required this.vendor,
    required this.point,
    required this.wallet,
    required this.address,
    required this.vendorWallet,
    required this.profileImage,
    required this.paymentAccount,
    required this.country,
    required this.state,
    required this.tax,
    required this.categories,
    required this.categoryImage,
    required this.tags,
    required this.attributes,
    required this.variations,
  });
  late final String id;
  late final String name;
  late final List<dynamic> slug;
  late final String? description;
  late final Null categoryImageId;
  late final Null categoryIconId;
  late final List<dynamic> status;
  late final String type;
  late final Null commissionRate;
  late final Null parentId;
  late final List<dynamic> createdById;
  late final String createdAt;
  late final String updatedAt;
  late final Null deletedAt;
  late final int blogsCount;
  late final int productsCount;
  late final String thumbnailImage;
  late final String thumbnailImageUrl;
  late final Null categoryIcon;
  late final List<dynamic> subcategories;
  late final Null parent;
  late final List<dynamic> shortDescription;
  late final List<dynamic> unit;
  late final List<dynamic> weight;
  late final List<dynamic> quantity;
  late final String salePrice;
  late final String discount;
  late final String isFeatured;
  late final List<dynamic> shippingDays;
  late final List<dynamic> isCod;
  late final List<dynamic> isFreeShipping;
  late final List<dynamic> isSaleEnable;
  late final List<dynamic> isReturn;
  late final List<dynamic> isTrending;
  late final List<dynamic> isApproved;
  late final List<dynamic> saleStartsAt;
  late final List<dynamic> saleExpiredAt;
  late final List<dynamic> sku;
  late final List<dynamic> isRandomRelatedProducts;
  late final String stockStatus;
  late final List<dynamic> metaTitle;
  late final List<dynamic> metaDescription;
  late final List<dynamic> productThumbnailId;
  late final List<dynamic> productMetaImageId;
  late final List<dynamic> sizeChartImageId;
  late final List<dynamic> estimatedDeliveryText;
  late final List<dynamic> returnPolicyText;
  late final List<dynamic> safeCheckout;
  late final List<dynamic> secureCheckout;
  late final List<dynamic> socialShare;
  late final List<dynamic> encourageOrder;
  late final List<dynamic> encourageView;
  late final List<dynamic> storeId;
  late final List<dynamic> taxId;
  late final List<dynamic> ordersCount;
  late final List<dynamic> reviewsCount;
  late final List<dynamic> canReview;
  late final List<dynamic> ratingCount;
  late final List<dynamic> orderAmount;
  late final List<dynamic> reviewRatings;
  late final List<dynamic> relatedProduct;
  late final List<dynamic> crossSellProducts;
  late final List<dynamic> productThumbnail;
  late final List<dynamic> productGalleries;
  late final List<dynamic> productMetaImage;
  late final List<dynamic> reviews;
  late final List<dynamic> store;
  late final List<dynamic> storeLogo;
  late final List<dynamic> storeCover;
  late final List<dynamic> vendor;
  late final List<dynamic> point;
  late final List<dynamic> wallet;
  late final List<dynamic> address;
  late final List<dynamic> vendorWallet;
  late final List<dynamic> profileImage;
  late final List<dynamic> paymentAccount;
  late final List<dynamic> country;
  late final List<dynamic> state;
  late final List<dynamic> tax;
  late final List<dynamic> categories;
  late final List<dynamic> categoryImage;
  late final List<dynamic> tags;
  late final List<dynamic> attributes;
  late final Variations variations;

  CategoryProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = List.castFrom<dynamic, dynamic>(json['slug']);
    description = null;
    categoryImageId = null;
    categoryIconId = null;
    status = List.castFrom<dynamic, dynamic>(json['status']);
    type = json['type'];
    commissionRate = null;
    parentId = null;
    createdById = List.castFrom<dynamic, dynamic>(json['created_by_id']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = null;
    blogsCount = json['blogs_count'];
    productsCount = json['products_count'];
    thumbnailImage = json['thumbnail_image'];
    thumbnailImageUrl = json['thumbnail_image_url'];
    categoryIcon = null;
    subcategories = List.castFrom<dynamic, dynamic>(json['subcategories']);
    parent = null;
    shortDescription =
        List.castFrom<dynamic, dynamic>(json['short_description']);
    unit = List.castFrom<dynamic, dynamic>(json['unit']);
    weight = List.castFrom<dynamic, dynamic>(json['weight']);
    quantity = List.castFrom<dynamic, dynamic>(json['quantity']);
    salePrice = json['sale_price'];
    discount = json['discount'];
    isFeatured = json['is_featured'];
    shippingDays = List.castFrom<dynamic, dynamic>(json['shipping_days']);
    isCod = List.castFrom<dynamic, dynamic>(json['is_cod']);
    isFreeShipping = List.castFrom<dynamic, dynamic>(json['is_free_shipping']);
    isSaleEnable = List.castFrom<dynamic, dynamic>(json['is_sale_enable']);
    isReturn = List.castFrom<dynamic, dynamic>(json['is_return']);
    isTrending = List.castFrom<dynamic, dynamic>(json['is_trending']);
    isApproved = List.castFrom<dynamic, dynamic>(json['is_approved']);
    saleStartsAt = List.castFrom<dynamic, dynamic>(json['sale_starts_at']);
    saleExpiredAt = List.castFrom<dynamic, dynamic>(json['sale_expired_at']);
    sku = List.castFrom<dynamic, dynamic>(json['sku']);
    isRandomRelatedProducts =
        List.castFrom<dynamic, dynamic>(json['is_random_related_products']);
    stockStatus = json['stock_status'];
    metaTitle = List.castFrom<dynamic, dynamic>(json['meta_title']);
    metaDescription = List.castFrom<dynamic, dynamic>(json['meta_description']);
    productThumbnailId =
        List.castFrom<dynamic, dynamic>(json['product_thumbnail_id']);
    productMetaImageId =
        List.castFrom<dynamic, dynamic>(json['product_meta_image_id']);
    sizeChartImageId =
        List.castFrom<dynamic, dynamic>(json['size_chart_image_id']);
    estimatedDeliveryText =
        List.castFrom<dynamic, dynamic>(json['estimated_delivery_text']);
    returnPolicyText =
        List.castFrom<dynamic, dynamic>(json['return_policy_text']);
    safeCheckout = List.castFrom<dynamic, dynamic>(json['safe_checkout']);
    secureCheckout = List.castFrom<dynamic, dynamic>(json['secure_checkout']);
    socialShare = List.castFrom<dynamic, dynamic>(json['social_share']);
    encourageOrder = List.castFrom<dynamic, dynamic>(json['encourage_order']);
    encourageView = List.castFrom<dynamic, dynamic>(json['encourage_view']);
    storeId = List.castFrom<dynamic, dynamic>(json['store_id']);
    taxId = List.castFrom<dynamic, dynamic>(json['tax_id']);
    ordersCount = List.castFrom<dynamic, dynamic>(json['orders_count']);
    reviewsCount = List.castFrom<dynamic, dynamic>(json['reviews_count']);
    canReview = List.castFrom<dynamic, dynamic>(json['can_review']);
    ratingCount = List.castFrom<dynamic, dynamic>(json['rating_count']);
    orderAmount = List.castFrom<dynamic, dynamic>(json['order_amount']);
    reviewRatings = List.castFrom<dynamic, dynamic>(json['review_ratings']);
    relatedProduct = List.castFrom<dynamic, dynamic>(json['related_product']);
    crossSellProducts =
        List.castFrom<dynamic, dynamic>(json['cross_sell_products']);
    productThumbnail =
        List.castFrom<dynamic, dynamic>(json['product_thumbnail']);
    productGalleries =
        List.castFrom<dynamic, dynamic>(json['product_galleries']);
    productMetaImage =
        List.castFrom<dynamic, dynamic>(json['product_meta_image']);
    reviews = List.castFrom<dynamic, dynamic>(json['reviews']);
    store = List.castFrom<dynamic, dynamic>(json['store']);
    storeLogo = List.castFrom<dynamic, dynamic>(json['store_logo']);
    storeCover = List.castFrom<dynamic, dynamic>(json['store_cover']);
    vendor = List.castFrom<dynamic, dynamic>(json['vendor']);
    point = List.castFrom<dynamic, dynamic>(json['point']);
    wallet = List.castFrom<dynamic, dynamic>(json['wallet']);
    address = List.castFrom<dynamic, dynamic>(json['address']);
    vendorWallet = List.castFrom<dynamic, dynamic>(json['vendor_wallet']);
    profileImage = List.castFrom<dynamic, dynamic>(json['profile_image']);
    paymentAccount = List.castFrom<dynamic, dynamic>(json['payment_account']);
    country = List.castFrom<dynamic, dynamic>(json['country']);
    state = List.castFrom<dynamic, dynamic>(json['state']);
    tax = List.castFrom<dynamic, dynamic>(json['tax']);
    categories = List.castFrom<dynamic, dynamic>(json['categories']);
    categoryImage = List.castFrom<dynamic, dynamic>(json['category_image']);
    tags = List.castFrom<dynamic, dynamic>(json['tags']);
    attributes = List.castFrom<dynamic, dynamic>(json['attributes']);
    variations = Variations.fromJson(json['variations']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['slug'] = slug;
    _data['description'] = description;
    _data['category_image_id'] = categoryImageId;
    _data['category_icon_id'] = categoryIconId;
    _data['status'] = status;
    _data['type'] = type;
    _data['commission_rate'] = commissionRate;
    _data['parent_id'] = parentId;
    _data['created_by_id'] = createdById;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['deleted_at'] = deletedAt;
    _data['blogs_count'] = blogsCount;
    _data['products_count'] = productsCount;
    _data['thumbnail_image'] = thumbnailImage;
    _data['thumbnail_image_url'] = thumbnailImageUrl;
    _data['category_icon'] = categoryIcon;
    _data['subcategories'] = subcategories;
    _data['parent'] = parent;
    _data['short_description'] = shortDescription;
    _data['unit'] = unit;
    _data['weight'] = weight;
    _data['quantity'] = quantity;
    _data['sale_price'] = salePrice;
    _data['discount'] = discount;
    _data['is_featured'] = isFeatured;
    _data['shipping_days'] = shippingDays;
    _data['is_cod'] = isCod;
    _data['is_free_shipping'] = isFreeShipping;
    _data['is_sale_enable'] = isSaleEnable;
    _data['is_return'] = isReturn;
    _data['is_trending'] = isTrending;
    _data['is_approved'] = isApproved;
    _data['sale_starts_at'] = saleStartsAt;
    _data['sale_expired_at'] = saleExpiredAt;
    _data['sku'] = sku;
    _data['is_random_related_products'] = isRandomRelatedProducts;
    _data['stock_status'] = stockStatus;
    _data['meta_title'] = metaTitle;
    _data['meta_description'] = metaDescription;
    _data['product_thumbnail_id'] = productThumbnailId;
    _data['product_meta_image_id'] = productMetaImageId;
    _data['size_chart_image_id'] = sizeChartImageId;
    _data['estimated_delivery_text'] = estimatedDeliveryText;
    _data['return_policy_text'] = returnPolicyText;
    _data['safe_checkout'] = safeCheckout;
    _data['secure_checkout'] = secureCheckout;
    _data['social_share'] = socialShare;
    _data['encourage_order'] = encourageOrder;
    _data['encourage_view'] = encourageView;
    _data['store_id'] = storeId;
    _data['tax_id'] = taxId;
    _data['orders_count'] = ordersCount;
    _data['reviews_count'] = reviewsCount;
    _data['can_review'] = canReview;
    _data['rating_count'] = ratingCount;
    _data['order_amount'] = orderAmount;
    _data['review_ratings'] = reviewRatings;
    _data['related_product'] = relatedProduct;
    _data['cross_sell_products'] = crossSellProducts;
    _data['product_thumbnail'] = productThumbnail;
    _data['product_galleries'] = productGalleries;
    _data['product_meta_image'] = productMetaImage;
    _data['reviews'] = reviews;
    _data['store'] = store;
    _data['store_logo'] = storeLogo;
    _data['store_cover'] = storeCover;
    _data['vendor'] = vendor;
    _data['point'] = point;
    _data['wallet'] = wallet;
    _data['address'] = address;
    _data['vendor_wallet'] = vendorWallet;
    _data['profile_image'] = profileImage;
    _data['payment_account'] = paymentAccount;
    _data['country'] = country;
    _data['state'] = state;
    _data['tax'] = tax;
    _data['categories'] = categories;
    _data['category_image'] = categoryImage;
    _data['tags'] = tags;
    _data['attributes'] = attributes;
    _data['variations'] = variations.toJson();
    return _data;
  }
}

class Variations {
  Variations({
    required this.id,
    required this.productId,
    this.variationKey,
    required this.sku,
    required this.code,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  late final String id;
  late final String productId;
  late final Null variationKey;
  late final String sku;
  late final String code;
  late final String price;
  late final String createdAt;
  late final String updatedAt;
  late final Null deletedAt;

  Variations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    variationKey = null;
    sku = json['sku'];
    code = json['code'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['product_id'] = productId;
    _data['variation_key'] = variationKey;
    _data['sku'] = sku;
    _data['code'] = code;
    _data['price'] = price;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['deleted_at'] = deletedAt;
    return _data;
  }
}
