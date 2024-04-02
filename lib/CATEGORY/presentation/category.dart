import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaveri/CATEGORY/bloc/get_category_bloc.dart';
import 'package:kaveri/common/widgets/custom_container_widget.dart';
import 'package:kaveri/constants/api_url.dart';
import 'package:kaveri/products/bloc/getproduct_bloc.dart';
import 'package:kaveri/products/product_model/product_model.dart';
import 'package:kaveri/common/card_product/card.dart';

import 'package:kaveri/common/header.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaveri/constants/custom_colorcode.dart';
import 'package:kaveri/screens/selectedCategory/bloc/selected_category_bloc.dart';
import 'package:kaveri/screens/selectedCategory/bloc/selected_category_event.dart';

class CategoryScreen extends StatefulWidget {
  static String routeName = "category";
  const CategoryScreen({
    super.key,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetCategoryBloc>(context).add(FetchCategoryEvent());
    BlocProvider.of<GetproductBloc>(context).add(FetchProductsEvent());
  }

  String searchText = '';
  bool _showLess = false;
  bool _showAllProducts = false;
  void _toggleShowLess() {
    setState(() {
      _showLess = !_showLess;
    });
  }

  int refreshTime = 1;

  Future<void> _handleRefresh() async {
    return await Future.delayed(
      Duration(
        seconds: refreshTime,
      ),
      () {
        BlocProvider.of<GetCategoryBloc>(context).add(FetchCategoryEvent());
        BlocProvider.of<GetproductBloc>(context).add(FetchProductsEvent());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const HeaderWidget(),
                // SizedBox(height: ScreenUtil().setHeight(10)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(25)),
                  child: Row(
                    children: [
                      Text(
                        'Category',
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
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(10)),
                  child: BlocBuilder<GetCategoryBloc, GetCategoryState>(
                    builder: (context, state) {
                      if (state is GetCategoryLoaded) {
                        return SizedBox(
                          width: double.infinity,
                          height: 250.h,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.category.length,
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
                              if (index < state.category.length) {
                                final category = state.category[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      context.read<SelectedCategoryBloc>().add(
                                          FetchSelectedCategoryEvent(
                                              category.id));
                                      log(category.id);
                                    },
                                    child: CustomContainer(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Image.asset(
                                              'assets/bucketfruits.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              category.name,
                                              style: TextStyle(fontSize: 10.sp),
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
                      } else if (state is GetCategoryLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is GetCategoryLoadFailure) {
                        log(state.error);
                        return Text('Failed to load category: ${state.error}');
                      } else {
                        return Container();
                      }
                    },
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
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(25)),
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
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(10)),
                  child: BlocBuilder<GetproductBloc, GetproductState>(
                    builder: (context, state) {
                      if (state is ProductsLoaded) {
                        List<Product> filteredProducts = state.products
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: ScreenUtil().screenWidth >
                                    ScreenUtil().setWidth(600)
                                ? 5
                                : 3,
                            childAspectRatio: 1,
                            mainAxisSpacing: 10.h,
                          ),
                          physics: NeverScrollableScrollPhysics(),
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
                                    price: filteredProducts[index].salePrice,
                                    stock: filteredProducts[index].stockStatus,
                                    isGreen:
                                        filteredProducts[index].stockStatus,
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
                      } else if (state is ProductsLoadFailure) {
                        log(state.error);
                        return Text('Failed to load products: ${state.error}');
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
      ),
    );
  }
}
