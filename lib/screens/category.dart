import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kaveri/BRAND/bloc/get_brands_bloc.dart';
import 'package:kaveri/CATEGORY/bloc/get_category_bloc.dart';
import 'package:kaveri/PRODUCT/bloc/getproduct_bloc.dart';
import 'package:kaveri/PRODUCT/product_model/product_model.dart';
import 'package:kaveri/common/card_product/card.dart';

import 'package:kaveri/common/header.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaveri/constants/custom_colorcode.dart';
import 'package:kaveri/screens/selectedCategory/bloc/selected_category_bloc.dart';
import 'package:kaveri/screens/selectedCategory/bloc/selected_category_event.dart';

class CategoryScreen extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderWidget(),
              // SizedBox(height: ScreenUtil().setHeight(10)),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(25)),
                child: Text(
                  'Category',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(15),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              BlocBuilder<GetCategoryBloc, GetCategoryState>(
                builder: (context, state) {
                  if (state is GetCategoryLoaded) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ScreenUtil().screenWidth >
                                ScreenUtil().setWidth(600)
                            ? 5
                            : 3,
                        childAspectRatio: 1 / 0.6,
                        mainAxisSpacing: 7.h,
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index < state.category.length) {
                          final brand = state.category[index];
                          return GestureDetector(
                            onTap: () {
                              // Log the ID of the selected brand
                              log('Selected brand ID: ${brand.id}');

                              context.read<SelectedCategoryBloc>().add(FetchSelectedCategoryEvent(brand.id));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(25)),
                              child: Container(
                                width: ScreenUtil().setWidth(100),
                                height: ScreenUtil().setHeight(70),
                                child: Card(
                                  elevation: 10,
                                  child: Image.asset(
                                    'assets/bucketfruits.png',
                                    width: ScreenUtil().setWidth(80),
                                    height: ScreenUtil().setHeight(50),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                      itemCount: state.category.length,
                      shrinkWrap: true,
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
                          childAspectRatio: 1 / 0.7,
                          mainAxisSpacing: 10.h,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index < filteredProducts.length) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(20),
                                vertical: ScreenUtil().setHeight(0),
                              ),
                              child: Container(
                                color: Colors.white,
                                width: ScreenUtil().setWidth(200),
                                height: ScreenUtil().setHeight(130),
                                child: ImageTextCard(
                                  imagePath: 'assets/fruits.png',
                                  name: filteredProducts[index].name,
                                  price: filteredProducts[index].salePrice,
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
    );
  }
}
