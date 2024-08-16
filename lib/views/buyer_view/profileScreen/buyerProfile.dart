import 'package:dekhlo/services/injection.dart';
import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:dekhlo/views/buyer_view/profileScreen/FAQ_webview.dart';
import 'package:dekhlo/views/buyer_view/profileScreen/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controllers/basicControllerEdit.dart';
import '../../../utils/components/buttons.dart';
import '../../../utils/components/dialog_boxs/rate_now.dart';
import '../../../utils/components/dialog_boxs/support_dialogbox.dart';
import '../../../utils/components/textstyle.dart';
import '../../login.dart';

class BuyerProfile extends StatefulWidget {
  const BuyerProfile({super.key});

  @override
  State<BuyerProfile> createState() => _BuyerProfileState();
}

class _BuyerProfileState extends State<BuyerProfile> {
  BasiccontrollerEdit basiccontrollerEdit = Get.put(BasiccontrollerEdit());
  RxString male = "".obs;
  @override
  void initState() {
    super.initState();
    _initializeProfile();
  }

  Future<void> _initializeProfile() async {
    try {
      await Hive.openBox('myBox');
      final box = await Hive.openBox('myBox');
      male.value = box.get('Gender');
      Logger().f(male);
    } catch (e) {
      Logger().d(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => basiccontrollerEdit.isLoading.value
        ? Scaffold(
            body: Center(child: LottieBuilder.asset("assest/mX2qe5gUvP.json")),
          )
        : Scaffold(
            body: Animate(
              effects: [
                SlideEffect(
                    begin: const Offset(1, 0), // Start from bottom
                    end: const Offset(0, 0), // End at normal position
                    duration: 500.ms, // Animation duration
                    curve: Curves.easeOut // Animation curve
                    ),
              ],
              child: Scaffold(
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
                          onTap: () async {
                            try {
                              final box = Hive.box('myBox');
                              final String formattedPhoneNumber =
                                  box.get('phone');
                              await restClient.Logout({
                                "mobile": formattedPhoneNumber,
                              });
                            } catch (e) {
                              Logger().d("error: $e");
                            }
                            Get.to(() => const Login());
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
                          basiccontrollerEdit.response.value.profileImage ==
                                  "task/assets/men.png"
                              ? male.value == "Male"
                                  ? Image.asset(
                                      "assest/man.png",
                                      height: 100.h,
                                      width: 100.h,
                                    )
                                  : male.value == "Female"
                                      ? Image.asset(
                                          "assest/woman.png",
                                          height: 100.h,
                                          width: 100.h,
                                        )
                                      : Image.asset(
                                          "assest/transgender (2).png",
                                          height: 100.h,
                                          width: 100.h,
                                        )
                              : CircleAvatar(
                                  radius: 40.r,
                                  child: ClipOval(
                                    child: Image.network(
                                      basiccontrollerEdit
                                          .response.value.profileImage,
                                      fit: BoxFit.cover,
                                      width: 80.r,
                                      height: 80.r,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(Icons.person, size: 40.r);
                                      },
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return const CircularProgressIndicator();
                                      },
                                    ),
                                  ),
                                ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  basiccontrollerEdit.response.value.yourName,
                                  style: TextStyles.openSans(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xff000000)),
                                ),
                                Text(
                                  basiccontrollerEdit.response.value.email,
                                  style: TextStyles.openSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                      color: const Color(0xff828282)),
                                ),
                                Text(
                                  basiccontrollerEdit.response.value.mobile,
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
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp),
                                    borderColor: const Color(0xffDADADA),
                                    foregroundColor: const Color(0xff4a4a4a),
                                    onPressed: () {
                                      Get.to(EditProfile(
                                        gender: male.value,
                                      ));
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
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const SupportDialogBox();
                            },
                          );
                        },
                        child: buyerSupport(
                          imagePath: "assest/info_grey.svg",
                          title: "Buyer Support",
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      textSupport(
                          imagePath: "assest/question_mark.svg",
                          title: "Buyer FAQs",
                          url: 'https://www.tickk.in/faqs'),
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteName.termsCondition);
                        },
                        child: textSupport(
                            imagePath: "assest/doc.svg",
                            title: "Buyer Terms & Conditions",
                            url: 'https://www.tickk.in/terms-and-conditions'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
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

  textSupport(
      {required String imagePath, required String title, required String url}) {
    return InkWell(
      onTap: () {
        Get.to(() => WebViewScreen(url: url));
      },
      child: Row(
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
      ),
    );
  }

  buyerSupport({
    required String imagePath,
    required String title,
  }) {
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
