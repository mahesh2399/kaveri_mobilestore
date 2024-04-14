import 'package:awesome_top_snackbar/awesome_top_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showsuccesstop({
  required BuildContext context,
  required String text,
  Icon? icon,
  Color? iconColor,
}) {
  awesomeTopSnackbar(
    context,
    text,
    backgroundColor: Colors.white,
    textStyle: const TextStyle(
      color: Colors.black,
    ),
    icon: icon ??
         Icon(CupertinoIcons.checkmark_alt_circle, color: iconColor ?? Colors.green),
  );
}