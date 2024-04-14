import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpdart/fpdart.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20.0),
      child: Image.asset(
        'assets/kaveri_store_logo (1) (1).png',
        width: ScreenUtil().setWidth(100),
        height: ScreenUtil().setHeight(90),
      ),
    );
  }
}

//for api call 
typedef EitherData<T> = Either<String, T>;

