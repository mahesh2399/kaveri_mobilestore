import 'package:dropdown_button2/dropdown_button2.dart';
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
                color: Colors.black, // Set focused border color
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
            hintStyle: const TextStyle(color: Colors.black, fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ],
    );
  }
}

class KDropDownButton extends StatelessWidget {
  KDropDownButton({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.validator,
    required this.labelText,
    this.icon,
    this.padding,
    required this.disabled,
    required this.isSearchVisible,
    required this.textEditingController,
    required this.onChanged,
    this.isLabelNameVisible,
    this.hintText,
  });
  final EdgeInsetsGeometry? padding;
  final List<DropdownMenuItem<dynamic>>? items;
  final String? selectedItem;
  void Function(dynamic)? onChanged;
  final String? Function(dynamic)? validator;
  final String labelText;
  final Widget? icon;
  final bool isSearchVisible;
  final TextEditingController textEditingController;
  final bool disabled;
  final bool? isLabelNameVisible;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: isLabelNameVisible == null ? true : isLabelNameVisible!,
            child: Text(
              labelText,
              style: TextStyle(
                  // fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          DropdownButtonFormField2(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            value: selectedItem,
            decoration: decorationForDropDown(),
            items: items,
            buttonStyleData: const ButtonStyleData(height: 35),
            dropdownSearchData: isSearchVisible == true
                ? DropdownSearchData(
                    searchController: textEditingController,
                    searchInnerWidgetHeight: 50,
                    searchInnerWidget: Container(
                      height: 70,
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        expands: true,
                        maxLines: null,
                        controller: textEditingController,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: 'Search for an item...',
                          hintStyle: const TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return item.child
                          .toString()
                          .toLowerCase()
                          .contains(searchValue.toLowerCase());
                    },
                  )
                : null,
            onChanged: onChanged,
            isExpanded: true,
            dropdownStyleData: DropdownStyleData(
                maxHeight: 1
                    .sw), //to make the dropsown to show only upto the half of the screen
            hint: Text(
              hintText ?? labelText,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }

  InputDecoration decorationForDropDown({Widget? icons}) {
    return InputDecoration(
      prefixIconColor: Colors.black,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Colors.green, // Set focused border color
          width: 1.0, // Set focused border width
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 175, 24, 13), // Set focused border color
          width: 1.0, // Set focused border width
        ),
      ),
      enabledBorder: disabled == false
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.black, // Set focused border color
                width: 1.0, // Set focused border width
              ),
            )
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Color.fromARGB(
                    255, 220, 220, 220), // Set focused border color
                width: 1.0, // Set focused border width
              ),
            ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Colors.black, // Set focused border color
          width: 1.0, // Set focused border width
        ),
      ),
      prefixIcon: icons,
      iconColor: Colors.black,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
    );
  }
}
