import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../buttons.dart';
import '../textstyle.dart';

class DeleteItemDialog extends StatelessWidget {
  final String title;
  final VoidCallback onDelete;

  const DeleteItemDialog({
    super.key,
    required this.title,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: <Widget>[
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(
                right: GlobalSizes.getDeviceWidth(context) * 0.009),
            child: Text(
              "Cancel",
              style: TextStyles.openSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff979797)),
            ),
          ),
        ),
        Buttons.shortButton(
          color: const Color(0xffFC8019),
          context: context,
          onPressedCallback: onDelete,
          buttonText: "Delete",
          textColor: Colors.white,
        ),
      ],
    );
  }
}
