// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kaveri/cart/data/cart_utils_service.dart';

class ShowUserWithVisibilityWidget extends StatelessWidget {
  const ShowUserWithVisibilityWidget({
    Key? key,
    required this.onDeletePressed,
    required this.createdUserData,
  }) : super(key: key);
  final void Function()? onDeletePressed;
  final UserDetailModel? createdUserData;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: createdUserData != null,
      child: ListTile(
        hoverColor: Colors.green,
        leading: const Icon(Icons.person),
        title: Text(
          createdUserData?.name ?? '',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(createdUserData?.mobileNumber ?? ''),
        trailing: IconButton(
            iconSize: 17.r,
            onPressed: onDeletePressed,
            icon: const Icon(
              CupertinoIcons.delete,
              color: Colors.red,
            )),
      ),
    );
  }
}
