import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColoredRectangle extends StatelessWidget {
  final String stock;
  final bool isGreen;

  const ColoredRectangle({
    required this.stock,
    required this.isGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(15),
      color: isGreen ? Colors.green : Colors.red,
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            stock,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 5.sp,
            ),
          ),
          Icon(
            isGreen ? Icons.check_circle : Icons.error,
            color: Colors.white,
            size: 5.sp,
          ),
        ],
      ),
    );
  }
}
