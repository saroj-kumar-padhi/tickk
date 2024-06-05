import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../routes/routes_names.dart';
import '../../size/global_size/global_size.dart';
import '../buttons.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        width: 300.0.w,
        height: 100.0.h,
        child: Stack(
          children: [
            // Positioned close icon at top right
            Positioned(
              top: 10.0.h,
              right: 10.0.w,
              child: InkWell(
                onTap: () => Get.back(),
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 24.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8.0.w, 15.h, 10.w, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Do you really want to Logout?",
                    style: TextStyles.openSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff4A4A4A),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: GlobalSizes.getDeviceWidth(context) * 0.009,
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyles.openSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff979797),
                            ),
                          ),
                        ),
                      ),
                      Buttons.shortButton(
                        color: const Color(0xffFC8019),
                        context: context,
                        onPressedCallback: () {
                          Get.toNamed(RouteName.signPhoneScreen);
                        },
                        buttonText: "LogOut",
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
