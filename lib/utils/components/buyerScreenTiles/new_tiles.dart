import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../dialog_boxs/delete_dialog.dart';
import '../textstyle.dart';

class NewSquareCard extends StatelessWidget {
  final String mobile;
  final String requirementId;
  final String storeCategory;
  final String storeSubCategory;
  final String storeSubSubCategory;
  final String brands;
  final String modelNo;
  final String size;
  final String quantity;
  final String units;
  final String requirementInDetails;
  final String date;

  const NewSquareCard(
      {super.key,
      required this.mobile,
      required this.requirementId,
      required this.storeCategory,
      required this.storeSubCategory,
      required this.storeSubSubCategory,
      required this.brands,
      required this.modelNo,
      required this.size,
      required this.quantity,
      required this.units,
      required this.requirementInDetails,
      required this.date});

  @override
  Widget build(BuildContext context) {
    String text = requirementInDetails;
    DateTime dateTime = DateTime.parse(date);
    String dateOnly = dateTime.toIso8601String().split('T').first;
    return Container(
        width: double.infinity, // Adjust the width as needed
        height: 240.h, // Adjust the height as needed
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
            Padding(
              padding: EdgeInsets.only(left: 17.w),
              child: Text(
                "Requirement ID #$requirementId",
                style: TextStyles.openSans(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
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
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        Text(" | ",
                            style: TextStyles.openSans(
                                fontSize: 12, fontWeight: FontWeight.w400)),
                        Text(
                          storeSubCategory,
                          style: TextStyles.openSans(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        Text(" | ",
                            style: TextStyles.openSans(
                                fontSize: 10, fontWeight: FontWeight.w400)),
                        Text(brands,
                            style: TextStyles.openSans(
                                fontSize: 12, fontWeight: FontWeight.w400))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text(
                      dateOnly,
                      style: TextStyles.openSans(
                          fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: GlobalSizes.getDeviceHeight(context) * 0.01,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalSizes.getDeviceHeight(context) * 0.025),
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
                      quantity,
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
              padding: EdgeInsets.symmetric(
                  horizontal: GlobalSizes.getDeviceWidth(context) * 0.05,
                  vertical: GlobalSizes.getDeviceHeight(context) * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assest/info.png",
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            GlobalSizes.getDeviceWidth(context) * 0.015,
                            GlobalSizes.getDeviceHeight(context) * 0.014,
                            GlobalSizes.getDeviceWidth(context) * 0.067,
                            GlobalSizes.getDeviceHeight(context) * 0.014),
                        child: Text(
                          "Delete requirement before seller accepts.",
                          style: TextStyles.openSans(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DeleteItemDialog(
                                title:
                                    'Do you really want to delete this Requirement ?',
                                onDelete: () {
                                  Fluttertoast.showToast(
                                      msg:
                                          'Your requirement is deleted successfully');
                                  Get.back();
                                },
                              );
                            },
                          );
                        },
                        child: SizedBox(
                            width: GlobalSizes.getDeviceWidth(context) * 0.09,
                            child: Image.asset(
                              "assest/delete-filled.png",
                              fit: BoxFit.fitWidth,
                            )),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
