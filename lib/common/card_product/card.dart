import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class ImageTextCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;
  final String stock;
  final int productsCount;

  final String isGreen;

  const ImageTextCard({
    required this.imagePath,
    required this.name,
    required this.price,
    required this.stock,
    required this.isGreen,
    required this.productsCount,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, String> stockLabels = {
      'in_stock': 'Available Stock',
      'out_stock': 'Out of Stock',
    };

    Map<String, Color> stockColors = {
      'in_stock': Colors.green,
      'out_stock': Colors.red,
    };

    // Get the text label and color based on the stock status
    String stockLabel = stockLabels[stock] ?? 'Unknown';
    Color stockColor = stockColors[stock] ?? Colors.grey;

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 228, 228, 228)),
          borderRadius: BorderRadius.circular(12.0),
        ),
        width: ScreenUtil().setWidth(100),
        height: ScreenUtil().setHeight(150),
        child: Card(
          color: Colors.white,
          elevation: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                imagePath,
                width: ScreenUtil().setWidth(30),
                height: ScreenUtil().setHeight(30),
                fit: BoxFit.cover,
              ),
              // SizedBox(height: 3.h),
              Text(

                name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 7.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // SizedBox(height: 3.h),
              Text(
                '$price ر.ع.',
                style: TextStyle(
                  fontSize: 7.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // SizedBox(height: 3.h),
              Container(
                height: 10.h,
                width: 50.w,
                color: stockColor,
                alignment: Alignment.center,
                child: Text(
                  '$stockLabel: $productsCount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 5.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Color color;
  final double elevation;
  final ShapeBorder? shape;

  const CustomCard({
    Key? key,
    required this.child,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(16.0),
    this.color = Colors.white,
    this.elevation = 0.0,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      elevation: elevation,
      color: color,
      shape: shape,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}