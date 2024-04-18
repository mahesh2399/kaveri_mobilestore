import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaveri/cart/bloc/cart_bloc.dart';
import 'package:kaveri/category/bloc/get_category_bloc.dart';
import 'package:kaveri/category/category_service/categoryservice.dart';
import 'package:kaveri/common/card_product/card.dart';
import 'package:kaveri/common/widgets/custom_container_widget.dart';
import 'package:kaveri/constants/api_url.dart';
import 'package:kaveri/constants/custom_colorcode.dart';
import 'package:kaveri/common/header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaveri/products/product_model/product_model.dart';
import 'package:kaveri/screens/selectedCategory/model/selectedCategoryModel.dart';

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
    getCategories();
    // BlocProvider.of<GetCategoryBloc>(context).add(FetchCategoryEvent());

    BlocProvider.of<GetCategoryBloc>(context).add(GetProductsEvent(context));
  }

  List<Category> productData = [];
  String searchText = '';
  bool _showLess = false;
  bool _showAllProducts = false;
  getCategories() async {
    final resut = await CategoryService().fetchCategories();

    setState(() {
      productData = resut;
    });
  }

  void toggleShowLess() {
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
        // BlocProvider.of<GetCategoryBloc>(context).add(FetchCategoryEvent());
        BlocProvider.of<GetCategoryBloc>(context)
            .add(GetProductsEvent(context));

        // BlocProvider.of<GetproductBloc>(context).add(FetchProductsEvent());
      },
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: Scaffold(
        key: _scaffoldkey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
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
                SizedBox(
                    width: double.infinity,
                    height: 250.h,
                    child:

                        // if (state is GetCategoryLoaded) {
                        GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productData.length,
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
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<GetCategoryBloc>(context).add(
                                  GetCategoryFetchProductsEvent(
                                      productData[index].id));

                              log(productData[index].id);
                            },
                            child: CustomContainer(
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Image.asset(
                                      'assets/bucketfruits.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      productData[index].name,
                                      style: TextStyle(fontSize: 10.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                    // }

                    ),
                BlocConsumer<GetCategoryBloc, GetCategoryState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is GetCategoryProductsLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GetCategoryLoaded2State) {
                      log('state is');
                      return categoryAndProducts(state.categoryProductList);
                    } else if (state is GetCategorybyIdState) {
                      return categoryAndProducts(state.categoryProductList);
                    }
                    return Container(
                      child: const Text(''),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column categoryAndProducts(List<Product> productsData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // }
        //   },
        // ),

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
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(25)),
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
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              itemCount: _showAllProducts
                  ? productsData.length
                  : productsData.length < 8
                      ? productsData.length
                      : 8,
              shrinkWrap: true,
              gridDelegate:
                  //   SliverGridDelegateWithFixedCrossAxisCount(

                  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    ScreenUtil().screenWidth > ScreenUtil().setWidth(600)
                        ? 5
                        : 4,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (BuildContext con) {
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(
                                    "$imageAccess${productsData[index].thumbnail_image_url}",
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    // product.name,
                                    'Product Name: ${productsData[index].name}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Price: ${productsData[index].salePrice} ر.ع.',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      BlocProvider.of<CartBloc>(
                                              _scaffoldkey.currentContext!)
                                          .add(
                                        AddtoCartPageEvent(ProductsForCart(
                                          unit: productsData[index]
                                              .unit['unit_code'],
                                          wantedQuantity: 1,
                                          name: productsData[index].name,
                                          imageUrl: productsData[index]
                                              .thumbnail_image_url,
                                          price: productsData[index].salePrice,
                                          availableQuantity:
                                              productsData[index].productsCount,
                                          discount:
                                              productsData[index].discount,
                                          tax: 0,
                                        )
                                            // Product(
                                            //   id: state
                                            //       .categoryProductList[index].id,
                                            //   name: state
                                            //       .categoryProductList[index]
                                            //       .name,
                                            //   slug: [],
                                            //   description: state
                                            //       .categoryProductList[index]
                                            //       .description,
                                            //   productsCount: state
                                            //       .categoryProductList[index]
                                            //       .productsCount,
                                            //   stockStatus: state
                                            //       .categoryProductList[index]
                                            //       .stockStatus,
                                            //   salePrice: state
                                            //       .categoryProductList[index]
                                            //       .salePrice,
                                            // ),
                                            ),
                                      );

                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                    child: const Text(
                                      'Add to Cart',
                                      style: TextStyle(color: Colors.white),
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
                      child: ImageTextCard(
                        imagePath:
                            "$imageAccess${productsData[index].thumbnail_image_url}",
                        name: productsData[index].name,
                        price: productsData[index].salePrice.toString(),
                        stock: productsData[index].stockStatus,
                        isGreen: productsData[index].stockStatus,
                        productsCount: productsData[index].productsCount,
                      ),
                    ));
              }),
        )
      ], //column
    );
  }
}

// 