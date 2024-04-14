import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaveri/brand/bloc/get_brands_bloc.dart';
import 'package:kaveri/cart/bloc/cart_bloc.dart';
import 'package:kaveri/category/model/cateogyr_product_model.dart';
import 'package:kaveri/common/widgets/custom_container_widget.dart';
import 'package:kaveri/constants/api_url.dart';
import 'package:kaveri/products/bloc/getproduct_bloc.dart';
import 'package:kaveri/products/product_model/product_model.dart';
import 'package:kaveri/common/card_product/card.dart';
import 'package:kaveri/common/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaveri/constants/custom_colorcode.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({
    super.key,
  });

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetBrandsBloc>(context).add(FetchBrandsEvent());

    BlocProvider.of<GetproductBloc>(context).add(FetchProductsEvent());
  }

  bool _showLess = false;
  bool _showAllProducts = false;
  void _toggleShowLess() {
    setState(() {
      _showLess = !_showLess;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  String searchText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HeaderWidget(),
              // SizedBox(height: ScreenUtil().setHeight(20)),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(25)),
                child: Row(
                  children: [
                    Text(
                      'Brand',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                child: Column(
                  children: [
                    BlocBuilder<GetBrandsBloc, GetBrandsState>(
                      builder: (context, state) {
                        if (state is BrandsLoaded) {
                          return SizedBox(
                            width: double.infinity,
                            height: 250.h,
                            child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.brands.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                crossAxisSpacing: 10,
                                childAspectRatio: 1, // 1 / 0.6,
                                mainAxisSpacing: 10,
                              ),
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (index < state.brands.length) {
                                  final brand = state.brands[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        final brand = state.brands[index];
                                        print("${brand.id},saaasaas");

                                        BlocProvider.of<GetproductBloc>(context)
                                            .add(FetchProductSelectEvent(
                                          brandId: brand.id,
                                        ));
                                      },
                                      child: CustomContainer(
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              // "$imageAccess${product.thumbnail_image_url}",
                                              child: Image.asset(
                                                'assets/bucketfruits.png',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                brand.name,
                                                style:
                                                    TextStyle(fontSize: 10.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          );
                        } else if (state is BrandsLoading) {
                          return const CircularProgressIndicator();
                        } else if (state is BrandsLoadFailure) {
                          log(state.error);
                          return Text('Failed to load brands: ${state.error}');
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(25)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search products',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(25)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'All Products',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(13),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _showAllProducts = !_showAllProducts;
                        });
                      },
                      child: Text(
                        _showAllProducts ? 'View Less' : 'View More',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(13),
                          fontWeight: FontWeight.bold,
                          color: CustomColor.myGreenColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),

              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                child: BlocBuilder<GetproductBloc, GetproductState>(
                  builder: (context, state) {
                    if (state is ProductsLoaded) {
                      List<Product> filteredProducts = state.products
                          .where(
                            (product) => product.name.toLowerCase().contains(
                                  searchText.toLowerCase(),
                                ),
                          )
                          .toList();
                      log("$filteredProducts consoledData");
                      final itemCount = _showAllProducts
                          ? filteredProducts.length
                          : filteredProducts.length > 6
                              ? 6
                              : filteredProducts.length;

                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: ScreenUtil().screenWidth >
                                  ScreenUtil().setWidth(600)
                              ? 5
                              : 3,
                          childAspectRatio: 1,
                          mainAxisSpacing: 10.h,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index < filteredProducts.length) {
                            final product = filteredProducts[index];
                            return GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      width: double.infinity,
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20)),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              "$imageAccess${product.thumbnail_image_url}",
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.contain,
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              // product.name,
                                              'Product Name: ${product.name}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              'Price: ${product.salePrice} ر.ع.',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            ElevatedButton(
                                              onPressed: () {
                                                _scaffoldkey.currentContext!
                                                    .read<CartBloc>()
                                                    .add(
                                                      AddtoCartPageEvent(
                                                          ProductsForCart(
                                                        name: product.name,
                                                        imageUrl: product
                                                            .thumbnail_image_url,
                                                        price:
                                                            product.salePrice,
                                                        stockQuantity: product
                                                            .productsCount,
                                                        discount:
                                                            product.discount,
                                                        tax: 0,
                                                      )),
                                                    );
                                                Navigator.of(context).pop();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                              ),
                                              child: const Text(
                                                'Add to Cart',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                color: Colors.white,
                                // width: ScreenUtil().setWidth(200),
                                // height: ScreenUtil().setHeight(130),
                                child: ImageTextCard(
                                  imagePath:
                                      "$imageAccess${product.thumbnail_image_url}",
                                  name: filteredProducts[index].name,
                                  price: filteredProducts[index]
                                      .salePrice
                                      .toString(),
                                  stock: filteredProducts[index].stockStatus,
                                  isGreen: filteredProducts[index].stockStatus,
                                  productsCount:
                                      filteredProducts[index].productsCount,
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                        itemCount: itemCount,
                        shrinkWrap: true,
                      );
                    } else if (state is ProductsLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is ProductSelectBrandState) {
                      List<Product> filteredProducts = state.productsData
                          .where((product) => product.name
                              .toLowerCase()
                              .contains(searchText.toLowerCase()))
                          .toList();

                      final itemCount = _showAllProducts
                          ? filteredProducts.length
                          : filteredProducts.length > 6
                              ? 6
                              : filteredProducts.length;

                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: ScreenUtil().screenWidth >
                                  ScreenUtil().setWidth(600)
                              ? 5
                              : 3,
                          childAspectRatio: 1,
                          mainAxisSpacing: 10.h,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index < filteredProducts.length) {
                            final product = filteredProducts[index];
                            return GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      // width:
                                      //     MediaQuery.of(context).size.width *
                                      //         0.9,
                                      width: double.infinity,
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20)),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              "$imageAccess${product.thumbnail_image_url}",
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.contain,
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              // product.name,
                                              'Product Name: ${product.name}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              'Price: ${product.salePrice} ر.ع.',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            ElevatedButton(
                                              onPressed: () {
                                                _scaffoldkey.currentContext!
                                                    .read<CartBloc>()
                                                    .add(
                                                      AddtoCartPageEvent(
                                                          ProductsForCart(
                                                        name: product.name,
                                                        imageUrl: product
                                                            .thumbnail_image_url,
                                                        price:
                                                            product.salePrice,
                                                        stockQuantity: product
                                                            .productsCount,
                                                        discount:
                                                            product.discount,
                                                        tax: 0,
                                                      )),
                                                    );
                                                Navigator.of(context).pop();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                              ),
                                              child: const Text(
                                                'Add to Cart',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                color: Colors.white,
                                // width: ScreenUtil().setWidth(200),
                                // height: ScreenUtil().setHeight(130),
                                child: ImageTextCard(
                                  imagePath:
                                      "$imageAccess${product.thumbnail_image_url}",
                                  name: filteredProducts[index].name,
                                  price: filteredProducts[index]
                                      .salePrice
                                      .toString(),
                                  stock: filteredProducts[index].stockStatus,
                                  isGreen: filteredProducts[index].stockStatus,
                                  productsCount:
                                      filteredProducts[index].productsCount,
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                        itemCount: itemCount,
                        shrinkWrap: true,
                      );
                    } else if (state is ProductsLoadFailure) {
                      log(state.error);
                      return const Text('Something went wrong');
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
