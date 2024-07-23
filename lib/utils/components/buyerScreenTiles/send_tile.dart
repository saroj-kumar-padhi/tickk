import 'dart:io';
import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../services/injection.dart';
import '../textstyle.dart';
import 'package:dekhlo/services/rest_client.dart';

class CountModel {
  final int count;

  CountModel({required this.count});

  factory CountModel.fromJson(Map<String, dynamic> json) {
    return CountModel(
      count: json['count'] as int,
    );
  }
}

class SendTile extends StatefulWidget {
  final String category;
  final String subcategory;
  final String subsubCategory;
  final String brands;
  final String modelNo;
  final String size;
  final String storeCount;
  final String quantity;
  final String units;
  final String description;
  final String image;

  const SendTile({
    super.key,
    required this.category,
    required this.subcategory,
    required this.subsubCategory,
    required this.brands,
    required this.modelNo,
    required this.size,
    required this.quantity,
    required this.units,
    required this.description,
    required this.image,
    required this.storeCount,
  });

  @override
  _SendTileState createState() => _SendTileState();
}

class _SendTileState extends State<SendTile> {
  int storeCount = 0;

  @override
  void initState() {
    super.initState();
    fetchStoreCount();
  }

  Future<void> fetchStoreCount() async {
    try {
      CountModel countModel;
      if (widget.subcategory.isNotEmpty) {
        countModel =
            await restClient.fetchSubCategoriesCount(widget.subcategory);
      } else {
        countModel = await restClient.fetchCategoriesCount(widget.category);
      }
      setState(() {
        storeCount = countModel.count;
      });
    } catch (e) {
      print('Error fetching store count: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String text = widget.description;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffFFF4EC),
            borderRadius: BorderRadius.circular(4.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              SizedBox(height: GlobalSizes.getDeviceHeight(context) * 0.003),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Text(
                            widget.category,
                            style: TextStyles.openSans(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          if (widget.subcategory.isNotEmpty) ...[
                            Text(" | ",
                                style: TextStyles.openSans(
                                    fontSize: 12, fontWeight: FontWeight.w400)),
                            Text(
                              widget.subcategory,
                              style: TextStyles.openSans(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ],
                          if (widget.subsubCategory.isNotEmpty) ...[
                            Text(" | ",
                                style: TextStyles.openSans(
                                    fontSize: 10, fontWeight: FontWeight.w400)),
                            Text(
                              widget.subsubCategory,
                              style: TextStyles.openSans(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Text(
                        "$storeCount stores",
                        style: TextStyles.openSans(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Image.file(
                      File(widget.image),
                      height: 40.h,
                      width: 50.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        widget.modelNo.isEmpty ? "--" : "#${widget.modelNo}",
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
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Image.asset("assest/bigLine.png"),
                  ),
                  Column(
                    children: [
                      Text(
                        widget.quantity,
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
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Image.asset("assest/bigLine.png"),
                  ),
                  Column(
                    children: [
                      Text(
                        widget.size.isEmpty ? "--" : widget.size,
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                      Text(
                        "Size",
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Image.asset("assest/bigLine.png"),
                  ),
                  Column(
                    children: [
                      Text(
                        widget.units,
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
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
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
          ),
        ),
      ],
    );
  }
}
