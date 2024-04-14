import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KTextformField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  TextEditingController? controller;
  TextInputType? keyboardType;
  String? initialValue;
  List<TextInputFormatter>? inputFormate;
  bool? readOnly;
  void Function(String)? onChanged;
  bool? enabled;
  final TextCapitalization? textCapitalization;
  final EdgeInsetsGeometry? padding;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxline;
  final bool? isLabelNameVisible;
  KTextformField({
    super.key,
    required this.labelText,
    required this.validator,
    required this.controller,
    required this.keyboardType,
    this.isLabelNameVisible,
    this.initialValue,
    this.inputFormate,
    this.readOnly,
    this.onChanged,
    this.enabled,
    this.textCapitalization,
    this.padding,
    this.obscureText,
    this.suffixIcon,
    this.maxline,
    this.prefixIcon,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: isLabelNameVisible == null ? true : isLabelNameVisible!,
          child: Text(
            labelText,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextFormField(
          obscureText: obscureText ?? false,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          enabled: enabled ?? true,
          style: const TextStyle(height: 1.5),
          initialValue: initialValue,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: keyboardType,
          validator: validator,
          inputFormatters: inputFormate,
          controller: controller,
          onChanged: onChanged,
          readOnly: readOnly ?? false,
          maxLines: maxline ?? 1,
          // enableInteractiveSelection: false,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.green, // Set focused border color
                width: 1.0, // Set focused border width
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.grey, // Set focused border color
                width: 1.0, // Set focused border width
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Color.fromARGB(
                    255, 175, 24, 13), // Set focused border color
                width: 1.0, // Set focused border width
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            // labelText: labelText,
            hintText: hintText ?? labelText,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ],
    );
  }
}
