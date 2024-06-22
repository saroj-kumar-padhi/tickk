import 'dart:io';

import 'package:dekhlo/utils/components/buttons.dart';
import 'package:dekhlo/utils/components/heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../controllers/basicControllerEdit.dart';
import '../../../utils/components/coustoumTextField.dart';
import '../../../utils/components/dialog_boxs/otp_dialog.dart';
import '../../../utils/components/dialog_boxs/pick_diallo.dart';
import '../../../utils/components/textstyle.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    RxString imagePath = ''.obs;
    BasiccontrollerEdit basiccontrollerEdit = Get.put(BasiccontrollerEdit());
    return Obx(() => basiccontrollerEdit.isLoading.value
        ? Scaffold(
            backgroundColor: const Color(0xffFC8019),
            body: Center(
              child: LoadingAnimationWidget.inkDrop(
                  color: const Color(0xffE4E4E4), size: 200),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 1,
              title: Text(
                "My profile",
                style: TextStyles.openSans(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff4A4A4A)),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: const Icon(Icons.close,
                      color: Color(
                        0xff4A4A4A,
                      )),
                )
              ],
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color(0xff4A4A4A),
                  )),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Obx(() {
                  return imagePath.value.isEmpty
                      ? Align(
                          alignment: Alignment.center,
                          child: Image.asset("assest/profileImage.png"),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 80.h,
                            width: 80.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors
                                  .transparent, // Add a transparent background color
                            ),
                            child: ClipOval(
                              child: Image.file(
                                File(imagePath.value),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                }),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () async {
                    final result = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return const PickImageDialog();
                      },
                    );
                    if (result != null) {
                      imagePath.value = result;
                    }
                  },
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Edit profile image",
                        style: TextStyles.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xffFC8019)),
                      )),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                  child: const SmallHeading(headingText: "Name"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomTextField(
                    isenable: true,
                    controller: basiccontrollerEdit.nameController,
                    hintText: basiccontrollerEdit.response.value.yourName,
                    height: 44.h,
                    width: 350.w,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                  child: const SmallHeading(headingText: "Email address"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomTextField(
                    isenable: true,
                    controller: basiccontrollerEdit.emailController,
                    hintText: basiccontrollerEdit.response.value.email,
                    height: 44.h,
                    width: 350.w,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                  child: const SmallHeading(headingText: "Phone number"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomTextField(
                    controller: phoneController,
                    hintText: basiccontrollerEdit.response.value.mobile,
                    height: 44.h,
                    width: 350.w,
                    isenable: false,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                              alignment: Alignment.topLeft,
                              child: SmallHeading(headingText: "Gender")),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.w),
                            child: CustomTextField(
                              isenable: false,
                              controller: phoneController,
                              hintText:
                                  basiccontrollerEdit.response.value.gender,
                              height: 44.h,
                              width: 150.w,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SmallHeading(headingText: "Age"),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.w),
                            child: CustomTextField(
                              isenable: false,
                              controller: phoneController,
                              hintText: basiccontrollerEdit.response.value.age
                                  .toString(),
                              height: 44.h,
                              width: 150.w,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Buttons.longButton(
                      color: const Color(0xffFC8019),
                      context: context,
                      onPressedCallback: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return OtpDialog(
                              phone: basiccontrollerEdit.response.value.mobile,
                              body: {
                                if (basiccontrollerEdit.emailController.text !=
                                    "")
                                  "email":
                                      basiccontrollerEdit.emailController.text,
                                if (basiccontrollerEdit.nameController.text !=
                                    "")
                                  "your_name":
                                      basiccontrollerEdit.nameController.text,
                              },
                              nametoNavigate: 'success',
                            );
                          },
                        );
                      },
                      buttonText: 'Update',
                      textColor: Colors.white),
                )
              ],
            ),
          ));
  }
}
