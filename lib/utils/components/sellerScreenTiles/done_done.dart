import 'package:blur/blur.dart';
import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/exactController.dart';
import '../dialog_boxs/coursal_dialog.dart';
import '../textstyle.dart';

class DoneDoneSellerCard extends StatelessWidget {
  const DoneDoneSellerCard({super.key});

  @override
  Widget build(BuildContext context) {
    ExactController exactController = Get.put(ExactController());
    String text =
        "Hi, I want a keyboard which is wireless. Looking for Need 5 of them. Please get back as soon as possible if it available in your store";

    return Obx(() {
      return Container(
          width: double.infinity, // Adjust the width as needed
          height: exactController.toShow.value
              ? 300.h
              : 340.h, // Adjust the height as needed
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
                4.r), // Adjust the border radius for a squared shape
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ClipOval(
                      child: SizedBox(
                        height: 40.h,
                        width: 40.h,
                        child: Image.asset('assest/profileImage.png').blurred(
                          colorOpacity: 0.5,
                          blur: 90,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 17.w),
                        child: SvgPicture.asset("assest/name.svg"),
                      ),
                      SizedBox(
                        height: GlobalSizes.getDeviceHeight(context) * 0.003,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: GlobalSizes.getDeviceHeight(context) * 0.023),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    "Electronics ",
                                    style: TextStyles.openSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(" | ",
                                      style: TextStyles.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400)),
                                  Text(
                                    "Table lamp",
                                    style: TextStyles.openSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(" | ",
                                      style: TextStyles.openSans(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400)),
                                  Text("Phillips",
                                      style: TextStyles.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400))
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(
                              "05 Feb ‘24",
                              style: TextStyles.openSans(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: GlobalSizes.getDeviceHeight(context) * 0.01,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            GlobalSizes.getDeviceHeight(context) * 0.025),
                    child: SizedBox(
                        width: GlobalSizes.getDeviceWidth(context) * 0.15,
                        height: GlobalSizes.getDeviceHeight(context) * 0.09,
                        child: Image.asset("assest/sellitems.png")),
                  ),
                  Column(
                    children: [
                      Text(
                        "#12638",
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                      Text(
                        "Model No",
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Image.asset("assest/bigLine.png"),
                  ),
                  Column(
                    children: [
                      Text(
                        "02",
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                      Text(
                        "Qty",
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Image.asset("assest/bigLine.png"),
                  ),
                  Column(
                    children: [
                      Text(
                        "{value}",
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                      Text(
                        "10",
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Image.asset("assest/bigLine.png"),
                  ),
                  Column(
                    children: [
                      Text(
                        "{value}",
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                      Text(
                        "Units",
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: GlobalSizes.getDeviceHeight(context) * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: GlobalSizes.getDeviceHeight(context) * 0.025),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: text.length > 132 ? text.substring(0, 134) : text,
                        style: TextStyles.openSans(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      if (text.length > 130)
                        const TextSpan(
                          text: " more..",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffFC8019),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: GlobalSizes.getDeviceHeight(context) * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  "Product type you have",
                  style: TextStyles.openSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff4A4A4A)),
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Obx(() => RadioListTile(
                            dense: true,
                            fillColor: WidgetStatePropertyAll(
                                exactController.isExact.isTrue
                                    ? const Color(0xffFC8019)
                                    : const Color(0xff959595)),
                            title: Text(
                              'Exact',
                              style: TextStyles.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: exactController.isExact.isTrue
                                      ? const Color(0xff313333)
                                      : const Color(0xff959595)),
                            ),
                            value: 'Exact',
                            groupValue: exactController.seletedOption
                                .value, // access value with .value
                            onChanged: (value) {},
                          )),
                    ),
                    Flexible(
                      child: Obx(() => RadioListTile(
                            dense: true,
                            fillColor: WidgetStatePropertyAll(
                                exactController.isExact.isFalse
                                    ? const Color(0xffFC8019)
                                    : const Color(0xff959595)),
                            title: Text(
                              'Similar',
                              style: TextStyles.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: exactController.isExact.isFalse
                                      ? const Color(0xff313333)
                                      : const Color(0xff959595)),
                            ),
                            value: 'Similar',
                            groupValue: exactController.seletedOption
                                .value, // access value with .value
                            onChanged: (value) {},
                          )),
                    ),
                    const SizedBox.shrink(),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right:
                                  GlobalSizes.getDeviceWidth(context) * 0.01),
                          child: SizedBox(
                              height: 10.h,
                              child: Image.asset(
                                "assest/image_view.png",
                                fit: BoxFit.fitHeight,
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CarouselDialog();
                              },
                            );
                          },
                          child: Text("View Image",
                              style: TextStyles.openSansUnderLine(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xffFC8019))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                // child: CustomTextField(
                //   controller: exactController.quoteEditingController,
                //   hintText: 'Enter your Quote',
                //   height: 44.h,
                //   width: 350.w,
                // ),
                child: Container(
                  height: 44.0, // Adjust height as needed
                  width: 350.0, // Adjust width as needed
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      exactController
                          .quoteEditingController.text, // Add your text here
                      style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black), // Adjust text style as needed
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ));
    });
  }
}
