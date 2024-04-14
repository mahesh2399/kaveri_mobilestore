import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetHalf extends StatelessWidget {
  final Widget child;
  const BottomSheetHalf({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 2.sw, 
      child: child,
    );
  }
}