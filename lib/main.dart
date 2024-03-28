import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kaveri/BRAND/bloc/get_brands_bloc.dart';
import 'package:kaveri/BRAND/brand_servive/brandservice.dart';
import 'package:kaveri/LOGIN/bloc/login.service.dart';
import 'package:kaveri/LOGIN/bloc/login_bloc.dart';
import 'package:kaveri/PRODUCT/bloc/getproduct_bloc.dart';
import 'package:kaveri/PRODUCT/prduct_servide/productservice.dart';
import 'package:kaveri/constants/gorouter.dart';

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
            create: (context) => GetproductBloc(ProductService()),
          ),

          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(LoginService()),
          ),
     
        ],
        child: MaterialApp.router(
          routerConfig: goRouter,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
