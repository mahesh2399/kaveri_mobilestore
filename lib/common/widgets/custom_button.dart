import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final Color bgcolor;
  final double? height;
  final Widget? child;
  final double? borderRadius;
  final Size? minimumSize;
  final TextStyle? textStyle;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.bgcolor,
    this.height,
    this.child,
    this.borderRadius,
    this.minimumSize,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgcolor,
          shadowColor: Colors.black,
          elevation: 0.0,
          minimumSize: minimumSize ?? const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
        ),
        child: child ??
            FittedBox(
              child: Text(
                text,
                style: textStyle ??
                    TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
              ),
            ),
      ),
    );
  }
}

class CustomButtonTransparant extends StatelessWidget {
  const CustomButtonTransparant(
      {super.key,
      required this.onPressed,
      required this.text,
      this.child,
      this.borderColor,
      this.borderRadius,
      this.textColor,
      this.textSize});
  final void Function()? onPressed;
  final String text;
  final Widget? child;
  final Color? borderColor;
  final double? borderRadius;
  final Color? textColor;
  final double? textSize;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: borderColor ?? Colors.green,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 4)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Center(
              child: child ??
                  Text(
                    text,
                    style: TextStyle(color: textColor, fontSize: textSize),
                  )),
        ),
      ),
    );
  }
}
