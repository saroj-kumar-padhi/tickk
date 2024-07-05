import 'package:dekhlo/services/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../buttons.dart';

class RateNowCustomDialog extends StatelessWidget {
  const RateNowCustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var selectedOption = 'InStorepick'.obs;
    var ratingStar = 0.0.obs;
    TextEditingController textEditingController =
        Get.put(TextEditingController());
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 0.0,
              right: 0.0,
              child: GestureDetector(
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: GlobalSizes.getDeviceHeight(context) * 0.01),
                    child: Text(
                      "Give your Rating",
                      style: TextStyles.openSans(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  RatingBar(
                    initialRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                      full: Image.asset('assest/filledStar.png'),
                      empty: Image.asset('assest/emptyStar.png'),
                      half: Image.asset('assest/filledStar.png'),
                    ),
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    onRatingUpdate: (rating) {
                      ratingStar.value = rating;
                      print(ratingStar.value);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: GlobalSizes.getDeviceHeight(context) * 0.03),
                    child: Text(
                      "Write your review",
                      style: TextStyles.openSans(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: GlobalSizes.getDeviceHeight(context) * 0.01),
                  Container(
                    width: GlobalSizes.getDeviceWidth(context) * 0.7,
                    padding: EdgeInsets.fromLTRB(
                        GlobalSizes.getDeviceWidth(context) * 0.01,
                        GlobalSizes.getDeviceHeight(context) * 0.01,
                        GlobalSizes.getDeviceWidth(context) * 0.01,
                        GlobalSizes.getDeviceHeight(context) * 0.01),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffE4E4E4),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: TextField(
                      controller: textEditingController,
                      maxLines: 5, // Set the number of lines for the TextField
                      decoration: InputDecoration(
                        hintText: 'Describe your experience (optional)',
                        hintStyle: TextStyles.openSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: const Color(0xff828282)),
                        contentPadding: EdgeInsets.symmetric(
                            vertical:
                                GlobalSizes.getDeviceHeight(context) * -0.008),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: GlobalSizes.getDeviceHeight(context) * 0.01,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Dropdown
                        DropdownButton<String>(
                          value: selectedOption.value,
                          onChanged: (String? newValue) {
                            selectedOption.value = newValue!;
                          },
                          items: <String>['InStorepick', 'Delivery']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ]),
                  Padding(
                    padding: EdgeInsets.only(
                        left: GlobalSizes.getDeviceWidth(context) * 0.25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: GlobalSizes.getDeviceWidth(context) *
                                    0.009),
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
                              try {
                                await restClient.postReviews("DR1A264", {
                                  "Rating": ratingStar.value,
                                  "how_did_you_get_this": selectedOption.value,
                                  "description": textEditingController.text
                                });

                                Fluttertoast.showToast(
                                    msg:
                                        'Thank You For Your valuable feedback');
                              } catch (e) {
                                Logger().d(e);
                              }

                              Get.back();
                            },
                            buttonText: "Submit",
                            textColor: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
