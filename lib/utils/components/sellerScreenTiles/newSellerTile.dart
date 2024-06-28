import 'dart:io';

import 'package:blur/blur.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

import '../../../controllers/exactController.dart';
import '../dialog_boxs/accept_dialod_box.dart';
import '../dialog_boxs/pick_diallo.dart';
import '../textstyle.dart';

class NewSellerCard extends StatelessWidget {
  final String storeCategory;
  final String requirementId;
  final String storeSubCategory;
  final String brands;
  final String date;
  final String modelNo;
  final String Qty;
  final String size;
  final String units;
  final String Requirement_in_details;

  const NewSellerCard(
      {super.key,
      required this.storeCategory,
      required this.storeSubCategory,
      required this.brands,
      required this.date,
      required this.modelNo,
      required this.Qty,
      required this.size,
      required this.units,
      required this.Requirement_in_details,
      required this.requirementId});

  @override
  Widget build(BuildContext context) {
    ExactController exactController = Get.put(ExactController());
    String text = Requirement_in_details;
    RxList pickedImage = [].obs;
    return Obx(() {
      return Container(
          width: double.infinity, // Adjust the width as needed
          height: exactController.toShow.value
              ? 415.h
              : 270.h, // Adjust the height as needed
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
                                    storeCategory,
                                    style: TextStyles.openSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(" | ",
                                      style: TextStyles.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400)),
                                  Text(
                                    storeSubCategory,
                                    style: TextStyles.openSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(" | ",
                                      style: TextStyles.openSans(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400)),
                                  Text(brands,
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
                              date,
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
                        modelNo,
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
                        Qty,
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
                        size,
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                      Text(
                        "size",
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
                        units,
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Obx(() => RadioListTile(
                          dense: true,
                          fillColor:
                              const WidgetStatePropertyAll(Color(0xffFC8019)),
                          title: Text(
                            'Exact',
                            style: TextStyles.openSans(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          value: 'Exact',
                          groupValue: exactController
                              .seletedOption.value, // access value with .value
                          onChanged: (value) {
                            exactController.isExact.value = true;
                            exactController.toShow.value = true;
                            exactController.changeSelectedOption(
                                option: value.toString());
                          },
                        )),
                  ),
                  Flexible(
                    child: Obx(() => RadioListTile(
                          dense: true,
                          fillColor:
                              const WidgetStatePropertyAll(Color(0xffFC8019)),
                          title: Text(
                            'Similar',
                            style: TextStyles.openSans(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          value: 'Similar',
                          groupValue: exactController
                              .seletedOption.value, // access value with .value
                          onChanged: (value) {
                            exactController.isExact.value = false;
                            exactController.toShow.value = true;
                            exactController.changeSelectedOption(
                                option: value.toString());
                          },
                        )),
                  ),
                ],
              ),
              Obx(() {
                return exactController.toShow.value
                    ? pickedImage.isEmpty
                        ? InkWell(
                            onTap: () async {
                              final result = await showDialog<String>(
                                context: context,
                                builder: (BuildContext context) {
                                  return const PickImageDialog();
                                },
                              );
                              if (result != null) {
                                pickedImage.add(result);
                              }
                            },
                            child: Center(
                              child: Container(
                                height: 100.h,
                                width: 130.w,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color(0xffC4C4C4), // Border color
                                    width: 1.0.w, // Border width
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      10.0.r), // Border radius
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.height *
                                          0.01),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      SvgPicture.asset(
                                        "assest/upload.svg",
                                        height: 20.h,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        "Upload Images",
                                        style: TextStyles.openSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11.sp,
                                            color: const Color(0xffFC8019)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Flexible(
                            child: Row(
                              children: [
                                Flexible(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: pickedImage.length,
                                    itemBuilder: (context, index) {
                                      return Stack(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.w),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: const Color(
                                                          0xff828282))),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    5.w, 5.h, 5.w, 5.h),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  height: 100.h,
                                                  width: 100.w,
                                                  child: Image.file(
                                                    File(pickedImage[index]),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 10,
                                            right: 10,
                                            child: InkWell(
                                              onTap: () {
                                                pickedImage
                                                    .remove(pickedImage[index]);
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Color(0xffFC8019),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
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
                                      pickedImage.add(result);
                                    }
                                  },
                                  child: pickedImage.length >= 3
                                      ? const SizedBox()
                                      : Padding(
                                          padding: EdgeInsets.only(left: 10.w),
                                          child: Container(
                                            height: 100.h,
                                            width: 130.w,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: const Color(
                                                    0xffC4C4C4), // Border color
                                                width: 1.0.w, // Border width
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0.r), // Border radius
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                  SvgPicture.asset(
                                                    "assest/upload.svg",
                                                    height: 20.h,
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Text(
                                                    "Upload Images",
                                                    style: TextStyles.openSans(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 11.sp,
                                                        color: const Color(
                                                            0xffFC8019)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          )
                    : const SizedBox();
              }),
              SizedBox(
                height: 10.h,
              ),
              Obx(() {
                return exactController.toShow.isTrue
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              elevation: WidgetStateProperty.all(
                                  0.0), // Remove elevation
                              side: WidgetStateProperty.all(const BorderSide(
                                width: 1.0,
                                color: Color(0xffC4C4C4),
                              )),
                              backgroundColor: WidgetStateProperty.all(
                                  Colors.transparent), // Transparent background
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      1.0), // Adjust radius as needed
                                ),
                              ),
                            ),
                            onPressed: () async {
                              try {
                                await restClient.rejectBySeller("TS156235HP", {
                                  "Reject": 'true',
                                  "RequirementID": "DR1A265"
                                });
                              } catch (e) {
                                Logger().d(e.toString());
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Text(
                                "Reject",
                                style: TextStyles.openSans(
                                    color: const Color(0xff4A4A4A),
                                    fontSize: 14.sp),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              elevation: WidgetStateProperty.all(
                                  0.0), // Remove elevation
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      3.0), // Adjust radius as needed
                                ),
                              ),

                              backgroundColor: exactController.isExact.isTrue ||
                                      pickedImage.isNotEmpty
                                  ? WidgetStateProperty.all(
                                      const Color(0xffFC8019))
                                  : WidgetStateProperty.all(
                                      const Color(0xffFC8019).withOpacity(
                                          0.3)), // Transparent background
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  final List<String> dataImage =
                                      pickedImage.cast<String>();
                                  return AcceptDialodBox(
                                    isExact: exactController.isExact.value,
                                    imageList: dataImage,
                                    requiremetId: requirementId,
                                  );
                                },
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Text(
                                "Accept",
                                style: TextStyles.openSans(
                                    color: Colors.white, fontSize: 14.sp),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          )
                        ],
                      )
                    : const SizedBox();
              })
            ],
          ));
    });
  }
}
