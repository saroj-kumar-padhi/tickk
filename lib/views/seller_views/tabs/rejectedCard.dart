import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:flutter/material.dart';

import '../../../utils/components/textstyle.dart';
import 'package:intl/intl.dart';

class RejectedSellerSquareCard extends StatelessWidget {
  final String requirementID;
  final String category;
  final String subCategory;
  final String brands;
  final DateTime dateTime;
  final String modelNo;
  final String qty;
  final String size;
  final String units;
  final String des;
  const RejectedSellerSquareCard(
      {super.key,
      required this.requirementID,
      required this.category,
      required this.subCategory,
      required this.brands,
      required this.dateTime,
      required this.modelNo,
      required this.qty,
      required this.size,
      required this.units,
      required this.des});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    String text = des;
    return Container(
        width: double.infinity, // Adjust the width as needed
        height: GlobalSizes.getDeviceHeight(context) *
            0.26, // Adjust the height as needed
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
              4), // Adjust the border radius for a squared shape
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
              padding: EdgeInsets.only(
                  left: GlobalSizes.getDeviceHeight(context) * 0.023),
              child: Text(
                "Requirement ID #$requirementID",
                style: TextStyles.openSans(
                    fontSize: 12, fontWeight: FontWeight.w600),
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
                          "$category ",
                          style: TextStyles.openSans(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        Text(" | ",
                            style: TextStyles.openSans(
                                fontSize: 12, fontWeight: FontWeight.w400)),
                        Text(
                          category,
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
                      formattedDate,
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
                      "#$modelNo",
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
                      qty,
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
          ],
        ));
  }
}
