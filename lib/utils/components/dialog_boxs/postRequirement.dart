import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../buttons.dart';
import '../textstyle.dart';

class PostRequirementsDialog extends StatelessWidget {
  const PostRequirementsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
          'Do you really want tosend the requirement to all 25 shops ?'),
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
            onPressedCallback: () {
              Fluttertoast.showToast(
                  msg: 'Your requirement is posted successfully');
              Get.back();
            },
            buttonText: "Send",
            textColor: Colors.white),
      ],
    );
  }
}
