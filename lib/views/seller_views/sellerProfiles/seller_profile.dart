import 'package:dekhlo/utils/components/dialog_boxs/log_out_dialog.dart';
import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/components/buttons.dart';
import '../../../utils/components/textstyle.dart';

class SellerProfile extends StatelessWidget {
  const SellerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const LogOutDialog();
                      });
                },
                value: 0,
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout,
                      color: Color(0xff4A4A4A),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    const Text("Logout")
                  ],
                ),
              ),
              PopupMenuItem<int>(
                onTap: () {
                  Get.toNamed(RouteName.deleteScreen);
                },
                value: 1,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assest/delete.svg",
                      height: 23.h,
                      width: 28.w,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    const Text("Delete Account")
                  ],
                ),
              ),
            ],
          ),
        ],
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xff4A4A4A),
            )),
        title: Text(
          'My profile',
          style: TextStyles.openSans(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              color: const Color(0xff4A4A4A)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assest/profileImage.png"),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "John Doe",
                        style: TextStyles.openSans(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff000000)),
                      ),
                      Text(
                        "johndoe192@gmail.com",
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: const Color(0xff828282)),
                      ),
                      Text(
                        "98765432132",
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: const Color(0xff828282)),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Buttons.smallCallButton(
                          height: 35.h,
                          width: 120.w,
                          buttonText: 'Edit profile',
                          textStyle: TextStyles.openSans(
                              fontWeight: FontWeight.w600, fontSize: 16.sp),
                          borderColor: const Color(0xffDADADA),
                          foregroundColor: const Color(0xff4a4a4a),
                          onPressed: () {
                            Get.toNamed(RouteName.editProfile);
                          }),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            const Divider(),
            SizedBox(
              height: 10.h,
            ),
            textSupport(
                imagePath: "assest/info_grey.svg", title: "Buyer Support"),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                Get.toNamed(RouteName.faqScreens);
              },
              child: textSupport(
                  imagePath: "assest/question_mark.svg", title: "Buyer FAQs"),
            ),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                Get.toNamed(RouteName.termsCondition);
              },
              child: textSupport(
                  imagePath: "assest/doc.svg",
                  title: "Buyer Terms & Conditions"),
            ),
            SizedBox(
              height: 20.h,
            ),
            const Divider(),
            textSupport(
                imagePath: "assest/info_grey.svg", title: "Seller Support"),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                Get.toNamed(RouteName.faqScreens);
              },
              child: textSupport(
                  imagePath: "assest/question_mark.svg", title: "Seller FAQs"),
            ),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                Get.toNamed(RouteName.termsCondition);
              },
              child: textSupport(
                  imagePath: "assest/doc.svg",
                  title: "Seller Terms & Conditions"),
            ),
          ],
        ),
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        print('Item 1 selected');
        // Add your custom logic for Item 1 here
        break;
      case 1:
        print('Item 2 selected');
        // Add your custom logic for Item 2 here
        break;
      case 2:
        print('Item 3 selected');
        // Add your custom logic for Item 3 here
        break;
    }
  }

  Row textSupport({required String imagePath, required String title}) {
    return Row(
      children: [
        SvgPicture.asset(
          imagePath,
          height: 23.h,
          width: 28.w,
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(title,
            style: TextStyles.openSans(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: const Color(0xff4A4A4A)))
      ],
    );
  }
}
