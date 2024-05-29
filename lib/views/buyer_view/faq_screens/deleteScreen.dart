import 'package:dekhlo/utils/components/dialog_boxs/otp_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/deleteReasonController.dart';
import '../../../utils/components/dialog_boxs/delete_dialog.dart';
import '../../../utils/components/textstyle.dart';
import '../../../utils/size/global_size/global_size.dart';

class DeleteScreen extends StatelessWidget {
  const DeleteScreen({super.key});

  // Method to generate RadioListTile widgets
  Widget buildRadioListTile({
    required String title,
    required String value,
    required DeleteReasonController controller,
  }) {
    return RadioListTile(
      dense: true,
      fillColor: const WidgetStatePropertyAll(Color(0xffFC8019)),
      title: Text(
        title,
        style: TextStyles.openSans(
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          color: const Color(0xff4A4A4A),
        ),
      ),
      value: value,
      groupValue: controller.seletedOption.value,
      onChanged: (option) {
        controller.changeSelectedOption(option: option!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DeleteReasonController deleteReasonController =
        Get.put(DeleteReasonController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: Text(
          "Delete Account",
          style: TextStyles.openSans(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xff4A4A4A)),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xff4A4A4A),
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // Widgets before the RadioListTiles...
            SizedBox(height: 30.h),
            Text(
              "Why are you deleting your account ?",
              style: TextStyles.openSans(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: const Color(0xff828282),
              ),
            ),
            SizedBox(height: 10.h),
            Material(
              // Material widget configuration...
              child: SizedBox(
                height: 260.h,
                width: 328.w,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // RichText widget...
                      SizedBox(height: 10.h),
                      Obx(() {
                        return Column(
                          children: [
                            // Use the method to generate RadioListTile widgets
                            buildRadioListTile(
                              title: "Too many bugs",
                              value: 'Too many bugs',
                              controller: deleteReasonController,
                            ),
                            buildRadioListTile(
                              title: "App is difficult to use",
                              value: 'App is difficult to use',
                              controller: deleteReasonController,
                            ),
                            buildRadioListTile(
                              title: "Using other app for my store",
                              value: 'Using other app for my store',
                              controller: deleteReasonController,
                            ),
                            buildRadioListTile(
                              title: "Concerned about my privacy",
                              value: 'Concerned about my privacy',
                              controller: deleteReasonController,
                            ),
                            buildRadioListTile(
                              title: "Something else",
                              value: 'Something else',
                              controller: deleteReasonController,
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Deleting account will do the following",
              style: TextStyles.openSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: const Color(0xff4A4A4A)),
            ),
            SizedBox(
              height: 10.h,
            ),
            Material(
                elevation: 1,
                child: SizedBox(
                  height: 140.h,
                  width: 328.w,
                  child: Column(
                    children: [
                      guiedlines(title: 'Log out on the all devices'),
                      SizedBox(
                        height: 20.h,
                      ),
                      guiedlines(
                          title:
                              'All your products, categories will be permanently deleted'),
                      SizedBox(
                        height: 20.h,
                      ),
                      guiedlines(
                          title: 'Delete all of your account information'),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.009,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: GlobalSizes.getDeviceHeight(context) * 0.01),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DeleteItemDialog(
                          title:
                              'Are you sure you want to Delete your account permanently?',
                          onDelete: () async {
                            Future.delayed(Duration.zero, () {
                              Get.back();
                            });
                            Future.delayed(Duration.zero, () {
                              // showSuccessDialog(context);
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const OtpDialog(
                                      nametoNavigate: '',
                                    );
                                  });
                            });
                          },
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xffFC8019),
                      width: 0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: const Color(0xffFC8019),
                    padding: EdgeInsets.all(
                        GlobalSizes.getDeviceWidth(context) * 0.04),
                  ),
                  child: const Text(
                    "Delete account",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white, // Text color
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row guiedlines({required String title}) {
    return Row(
      children: [
        SvgPicture.asset("assest/small_dot.svg"),
        SizedBox(
          width: 10.w,
        ),
        Flexible(
          child: Text(
            title,
            style: TextStyles.openSans(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: const Color(0xff4A4A4A)),
          ),
        )
      ],
    );
  }
}
