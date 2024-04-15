
import 'package:flutter/material.dart';

void showSnackbarBottom(BuildContext context, String text,
    {Duration? duration}) {
  final snackBar = SnackBar(
    dismissDirection: DismissDirection.none,
    content: Row(
      children: [
        const Icon(Icons.info, color: Colors.white), // Add an icon if needed
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
            overflow: TextOverflow.ellipsis, // Adjust overflow behavior
          ),
        ),
      ],
    ),
    backgroundColor: Colors.green, // Change the background color
    duration: duration ?? const Duration(seconds: 3), // Adjust the duration
    behavior: SnackBarBehavior.floating, // Use floating SnackBar
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Add rounded corners
    ),
    // action: SnackBarAction(
    //   label: 'Close',
    //   textColor: Colors.white,
    //   onPressed: () {
    //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
    //   },
    // ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}