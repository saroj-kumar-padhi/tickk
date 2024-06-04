import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../size/global_size/global_size.dart';
import '../buttons.dart';

class QuoteDialog extends StatelessWidget {
  const QuoteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        width: 300.0.w,
        height: 150.0.h,
        child: Stack(
          children: [
            Positioned(
              top: 10.0,
              right: 3.0,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.close,
                    size: 24.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8.0.w, 15.h, 10.w, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Do you really want to send this Quotation to buyer?",
                    style: TextStyles.openSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff4A4A4A)),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              right:
                                  GlobalSizes.getDeviceWidth(context) * 0.009),
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
                          Fluttertoast.showToast(msg: "Sent");
                          Get.back();
                        },
                        buttonText: "Send",
                        textColor: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
