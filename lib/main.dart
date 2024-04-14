import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaveri/brand/bloc/get_brands_bloc.dart';
import 'package:kaveri/brand/brand_servive/brandservice.dart';
import 'package:kaveri/cart/bloc/cart_bloc.dart';
import 'package:kaveri/category/bloc/get_category_bloc.dart';
import 'package:kaveri/category/category_service/categoryservice.dart';
import 'package:kaveri/login/bloc/login.service.dart';
import 'package:kaveri/login/bloc/login_bloc.dart';

import 'package:kaveri/products/bloc/getproduct_bloc.dart';
import 'package:kaveri/products/prduct_servide/productservice.dart';
import 'package:kaveri/constants/gorouter.dart';
import 'package:kaveri/screens/selectedCategory/bloc/selected_category_bloc.dart';
import 'package:kaveri/screens/selectedCategory/model/service/SelectedCategory.service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GetBrandsBloc>(
            create: (context) => GetBrandsBloc(BrandService()),
          ),
          BlocProvider<GetproductBloc>(
            create: (context) => GetproductBloc(ProductService(),BrandService()),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(LoginService()),
          ),
          BlocProvider<SelectedCategoryBloc>(
            create: (context) =>
                SelectedCategoryBloc(SelectedCategoryService()),
          ),
          BlocProvider<GetCategoryBloc>(
            create: (context) => GetCategoryBloc(CategoryService()),
          ),
          BlocProvider<CartBloc>(
            create: (context) => CartBloc(),
          ),
        ],
        child: MaterialApp.router(
          // localizationsDelegates: [
          //   AppLocalizations.delegate,
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate
          // ],
          // locale: Locale('en'),
          // supportedLocales: [Locale('en')],
          routerConfig: goRouter,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
