import 'package:dekhlo/controllers/inprocessController.dart';
import 'package:dekhlo/utils/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/expandController.dart';
import '../../../controllers/sortDialogBoxController.dart';
import '../../size/global_size/global_size.dart';
import '../bottomSheets/sort.dart';
import '../dialog_boxs/coursal_dialog.dart';
import '../textstyle.dart';

class InprocessTile extends StatelessWidget {
  const InprocessTile({super.key});

  @override
  Widget build(BuildContext context) {
    final ExpandController expandController = Get.put(ExpandController());
    final InProcessController inProcessController =
        Get.put(InProcessController());
    final DialogBoxController dialogBoxController =
        Get.put(DialogBoxController());
    String text =
        "Hi, I want a keyboard which is wireless. Looking for Need 5 of them. Please get back as soon as possible if it available in your store";
    return SizedBox(child: Obx(() {
      return Container(
          width: double.infinity, // Adjust the width as needed
          height: expandController.isExpanded.value
              ? 386.h
              : 225.h, // Adjust the height as needed
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
                4.r), // Adjust the border radius for a squared shape
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2.r,
                blurRadius: 5.r,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.w),
                child: Text(
                  "Requirement ID #16526545",
                  style: TextStyles.openSans(
                      fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Electronics ",
                          style: TextStyles.openSans(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                        Text(" | ",
                            style: TextStyles.openSans(
                                fontSize: 12.sp, fontWeight: FontWeight.w400)),
                        Text(
                          "Table lamp",
                          style: TextStyles.openSans(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                        Text(" | ",
                            style: TextStyles.openSans(
                                fontSize: 12.sp, fontWeight: FontWeight.w400)),
                        Text("Phillips",
                            style: TextStyles.openSans(
                                fontSize: 12.sp, fontWeight: FontWeight.w400))
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.h),
                      child: Text(
                        "05 Feb ‘24",
                        style: TextStyles.openSans(
                            fontSize: 12.sp, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Row(
                  children: [
                    SizedBox(
                        width: 90.w,
                        height: 60.h,
                        child: Image.asset("assest/sellitems.png")),
                    Column(
                      children: [
                        Text(
                          "#12638",
                          style: TextStyles.openSans(
                              fontWeight: FontWeight.w600, fontSize: 12.sp),
                        ),
                        Text(
                          "Model No",
                          style: TextStyles.openSans(
                              fontWeight: FontWeight.w400, fontSize: 12.sp),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: Image.asset("assest/bigLine.png"),
                    ),
                    Column(
                      children: [
                        Text(
                          "02",
                          style: TextStyles.openSans(
                              fontWeight: FontWeight.w600, fontSize: 12.sp),
                        ),
                        Text(
                          "Qty",
                          style: TextStyles.openSans(
                              fontWeight: FontWeight.w400, fontSize: 12.sp),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9.h),
                      child: Image.asset("assest/bigLine.png"),
                    ),
                    Column(
                      children: [
                        Text(
                          "{value}",
                          style: TextStyles.openSans(
                              fontWeight: FontWeight.w600, fontSize: 12.sp),
                        ),
                        Text(
                          "10",
                          style: TextStyles.openSans(
                              fontWeight: FontWeight.w400, fontSize: 12.sp),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9.h),
                      child: Image.asset("assest/bigLine.png"),
                    ),
                    Column(
                      children: [
                        Text(
                          "{value}",
                          style: TextStyles.openSans(
                              fontWeight: FontWeight.w600, fontSize: 12.sp),
                        ),
                        Text(
                          "Units",
                          style: TextStyles.openSans(
                              fontWeight: FontWeight.w400, fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: text.length > 132 ? text.substring(0, 134) : text,
                        style: TextStyles.openSans(
                          color: Colors.black,
                          fontSize: 13.sp,
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
                height: 1.h,
              ),
              Obx(() {
                return Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 6.h, 14.w, 6.h),
                  child: Container(
                    height: expandController.isExpanded.value ? 210.h : 33.h,
                    width: 309.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffFFC18E)),
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        color: const Color(0xffFFF5ED)),
                    child: expandController.isExpanded.value
                        ? Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10.h, 0, 5.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            dialogBoxController
                                                .selectedTab.value = 0;
                                            sortDialogBox(context: context);
                                          },
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 25.w),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5),
                                                  child: Image.asset(
                                                      "assest/hamburger.png"),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(
                                                  "Sort by Distance/Price",
                                                  style: TextStyles.openSans(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12.sp,
                                                      color: const Color(
                                                          0xffFC8019)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 11.w),
                                          child: Text(
                                            "Requests (03)",
                                            style: TextStyles.openSans(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 11.5.sp,
                                            ),
                                          ),
                                        ),
                                        expandController.isExpanded.value
                                            ? InkWell(
                                                onTap: () {
                                                  expandController
                                                          .isExpanded.value =
                                                      !expandController
                                                          .isExpanded.value;
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 4.w),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.sp),
                                                    child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Color(
                                                                    0xffFC8019)),
                                                        child: Icon(
                                                          Icons.expand_more,
                                                          size: 15.sp,
                                                          color: Colors.white,
                                                        )),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        10.w, 0.h, 8.w, 5.h),
                                    child: Container(
                                      height: 55.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffFFFFFF),
                                        borderRadius: BorderRadius.circular(4.0
                                            .r), // Adjust the value as needed
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3.w,
                                                    vertical: 2.h),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                        "assest/bookImage.png"),
                                                    Text(
                                                      "The Big Bookstore",
                                                      style:
                                                          TextStyles.openSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 12),
                                                    ),
                                                    SizedBox(
                                                      width: GlobalSizes
                                                              .getDeviceWidth(
                                                                  context) *
                                                          0.03,
                                                    ),
                                                    Text(
                                                      "4.7 (5)",
                                                      style:
                                                          TextStyles.openSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12),
                                                    ),
                                                    SizedBox(
                                                      width: 6.w,
                                                    ),
                                                    Image.asset(
                                                        "assest/google_map_icon.png"),
                                                    SizedBox(
                                                      width: 1.w,
                                                    ),
                                                    Text(
                                                      "5 KM away",
                                                      style:
                                                          GoogleFonts.openSans(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 2.w),
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text("₹ 1200",
                                                            style: TextStyles.openSans(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: const Color(
                                                                    0xffFC8019))),
                                                        Text("Quotation",
                                                            style: TextStyles.openSans(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: const Color(
                                                                    0xfff4a4a4a))),
                                                      ],
                                                    ),
                                                    Image.asset(
                                                      "assest/bigLine.png",
                                                      height: GlobalSizes
                                                              .getDeviceHeight(
                                                                  context) *
                                                          0.02,
                                                      width: GlobalSizes
                                                              .getDeviceWidth(
                                                                  context) *
                                                          0.03,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text("Similar",
                                                            style: TextStyles.openSans(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: const Color(
                                                                    0xffFC8019))),
                                                        Text("Product Type",
                                                            style: TextStyles.openSans(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: const Color(
                                                                    0xfff4a4a4a))),
                                                      ],
                                                    ),
                                                    Image.asset(
                                                      "assest/bigLine.png",
                                                      height: GlobalSizes
                                                              .getDeviceHeight(
                                                                  context) *
                                                          0.02,
                                                      width: GlobalSizes
                                                              .getDeviceWidth(
                                                                  context) *
                                                          0.03,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  right: GlobalSizes
                                                                          .getDeviceWidth(
                                                                              context) *
                                                                      0.01),
                                                              child: SizedBox(
                                                                  height: 10.h,
                                                                  child: Image
                                                                      .asset(
                                                                    "assest/image_view.png",
                                                                    fit: BoxFit
                                                                        .fitHeight,
                                                                  )),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return const CarouselDialog();
                                                                  },
                                                                );
                                                              },
                                                              child: Text(
                                                                  "View",
                                                                  style: TextStyles.openSans(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: const Color(
                                                                          0xffFC8019))),
                                                            ),
                                                          ],
                                                        ),
                                                        Text("Product Image",
                                                            style: TextStyles.openSans(
                                                                fontSize: 10.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: const Color(
                                                                    0xfff4a4a4a))),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 6.w,
                                                    ),
                                                    Obx(() {
                                                      return InkWell(
                                                        child: inProcessController
                                                                .index
                                                                .contains(index)
                                                            ? Buttons
                                                                .smallCallButton(
                                                                    buttonText:
                                                                        'Call',
                                                                    onPressed:
                                                                        () {
                                                                      FlutterPhoneDirectCaller
                                                                          .callNumber(
                                                                              '+916280644889');
                                                                    })
                                                            : InkWell(
                                                                onTap: () {
                                                                  if (inProcessController
                                                                      .index
                                                                      .contains(
                                                                          index)) {
                                                                    inProcessController
                                                                        .index
                                                                        .remove(
                                                                            index);
                                                                  } else {
                                                                    inProcessController
                                                                        .index
                                                                        .add(
                                                                            index);
                                                                  }
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets.fromLTRB(
                                                                          20.w,
                                                                          0.h,
                                                                          10.h,
                                                                          0.h),
                                                                      child:
                                                                          Container(
                                                                        decoration: const BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: Color(0xffCEEDE3)),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .check,
                                                                          size:
                                                                              15.sp,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                      );
                                                    }),
                                                    Obx(() {
                                                      return inProcessController
                                                              .index
                                                              .contains(index)
                                                          ? Buttons
                                                              .smallDealDoneButton()
                                                          : Center(
                                                              child: Container(
                                                                decoration: const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Color(
                                                                        0xffFFEAEC)),
                                                                child: Icon(
                                                                  Icons.close,
                                                                  size: 15.sp,
                                                                  color: const Color(
                                                                      0xffBC0000),
                                                                ),
                                                              ),
                                                            );
                                                    })
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              )
                            ],
                          )
                        : Row(
                            children: [
                              Row(
                                children: [
                                  expandController.isExpanded.value
                                      ? Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                expandController
                                                        .isExpanded.value =
                                                    !expandController
                                                        .isExpanded.value;
                                                inProcessController.index
                                                    .clear();
                                              },
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 6.w),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 4.sp),
                                                  child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Color(
                                                                  0xffFC8019)),
                                                      child: Icon(
                                                        Icons.expand_less,
                                                        size: 15.sp,
                                                        color: Colors.white,
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : InkWell(
                                          onTap: () {
                                            expandController.isExpanded.value =
                                                !expandController
                                                    .isExpanded.value;
                                            inProcessController.index.clear();
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  dialogBoxController
                                                      .selectedTab.value = 0;
                                                  sortDialogBox(
                                                      context: context);
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.w),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 0),
                                                        child: Image.asset(
                                                            "assest/hamburger.png"),
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Text(
                                                        "Sort by Distance/Price",
                                                        style: TextStyles.openSans(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12.sp,
                                                            color: const Color(
                                                                0xffFC8019)),
                                                      ),
                                                      SizedBox(
                                                        width: 30.w,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 11.w),
                                                child: Text(
                                                  "Requests (03)",
                                                  style: TextStyles.openSans(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 6.w),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 4.sp),
                                                  child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Color(
                                                                  0xffFC8019)),
                                                      child: Icon(
                                                        Icons.expand_less,
                                                        size: 15.sp,
                                                        color: Colors.white,
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            ],
                          ),
                  ),
                );
              })
            ],
          ));
    }));
  }
}
