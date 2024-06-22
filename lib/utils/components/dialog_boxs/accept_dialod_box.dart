import 'package:dekhlo/services/injection.dart';
import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

import '../../size/global_size/global_size.dart';
import '../buttons.dart';

class AcceptDialodBox extends StatelessWidget {
  final bool isExact;
  final List<dynamic> imageList;

  final String requiremetId;

  const AcceptDialodBox(
      {super.key,
      required this.isExact,
      required this.imageList,
      required this.requiremetId});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        width: 300.0.w,
        height: 150.0.h,
        child: Stack(
          children: [
            Positioned(
              top: 10.0,
              right: 3.0,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.close,
                    size: 24.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8.0.w, 15.h, 10.w, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Do You want to accept this requirement?",
                    style: TextStyles.openSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff4A4A4A)),
                  ),
                  Text(
                    "You can add pricing from “Pending Quote” tab.",
                    style: TextStyles.openSans(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff898989)),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              right:
                                  GlobalSizes.getDeviceWidth(context) * 0.009),
                          child: Text(
                            "Cancel",
                            style: TextStyles.openSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff979797)),
                          ),
                        ),
                      ),
                      Buttons.shortButton(
                        color: const Color(0xffFC8019),
                        context: context,
                        onPressedCallback: () async {
                          final data = {
                            "RequirementID": requiremetId,
                            "ExactSimilarImage": imageList,
                            if (isExact) "Exact": true else "Similar": true,
                          };

                          try {
                            await restClient.exactOrSimilar(data);
                            Fluttertoast.showToast(msg: "Accepted");
                            Get.back();
                          } catch (e) {
                            Logger().d(e);
                          }
                        },
                        buttonText: "Accept",
                        textColor: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
