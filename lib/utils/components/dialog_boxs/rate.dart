import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:dekhlo/utils/size/global_size/global_size.dart';

class RateUs extends StatelessWidget {
  final RxInt selectedValue = 1.obs; // Initial value
  final RxDouble ratingStar = 0.0.obs;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController totalBillingAmountController =
      TextEditingController();
  final String requirementId;

  RateUs({super.key, required this.requirementId});

  void _submitReview() async {
    try {
      await restClient.postReviews("TR1A26249", {
        "Rating": ratingStar.value,
        "how_did_you_get_this":
            selectedValue.value == 1 ? 'InStorepick' : 'Delivery',
        "description": descriptionController.text,
        "TotalPurchaseAmount":
            int.tryParse(totalBillingAmountController.text) ?? 0,
      });

      Fluttertoast.showToast(msg: 'Thank You For Your valuable feedback');
      Get.back(); // Close the dialog after submission
    } catch (e) {
      Logger().d(e);
    }
  }

  void _showRateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11.0.r), // Rounded corners
          ),
          contentPadding: EdgeInsets.zero, // Remove content padding
          insetPadding: const EdgeInsets.symmetric(
              horizontal: 40), // Remove inset padding
          content: SizedBox(
            width: double.maxFinite, // Take the maximum width
            height: 450.0.h, // Set the height here
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0.w), // Add padding inside content
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heading(text: 'Help us improve! Rate your experience'),
                      SizedBox(height: 10.h),
                      RatingBar(
                        initialRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                          full: Image.asset('assest/filledStar.png'),
                          empty: Image.asset('assest/emptyStar.png'),
                          half: Image.asset('assest/filledStar.png'),
                        ),
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        onRatingUpdate: (rating) {
                          ratingStar.value = rating;
                        },
                      ),
                      SizedBox(height: 20.h),
                      Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              heading(text: "Select your pickup option"),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Transform.scale(
                                        scale: 0.8,
                                        child: Radio<int>(
                                          activeColor: const Color(0xffFC8019),
                                          value: 1,
                                          groupValue: selectedValue.value,
                                          onChanged: (int? value) {
                                            selectedValue.value = value!;
                                          },
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: VisualDensity.compact,
                                        ),
                                      ),
                                      Text(
                                        "In-Store Pickup",
                                        style: GoogleFonts.openSans(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      unselectedWidgetColor:
                                          Colors.grey, // Unselected color
                                      radioTheme: RadioThemeData(
                                        fillColor: WidgetStateProperty.all(
                                            const Color(
                                                0xffFC8019)), // Active color
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Transform.scale(
                                          scale: 0.8,
                                          child: Radio<int>(
                                            value: 2,
                                            groupValue: selectedValue.value,
                                            onChanged: (int? value) {
                                              selectedValue.value = value!;
                                            },
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            visualDensity:
                                                VisualDensity.compact,
                                          ),
                                        ),
                                        Text(
                                          "Home Delivery",
                                          style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              SizedBox(
                                height: 40.h,
                                child: TextField(
                                  controller: totalBillingAmountController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Total Billing Amount',
                                    hintStyle: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 15.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                          color: Colors.blue.shade300),
                                    ),
                                  ),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              SizedBox(
                                height: 104.h,
                                child: TextField(
                                  controller: descriptionController,
                                  decoration: InputDecoration(
                                    hintText: 'Tell us what you think...',
                                    hintStyle: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 15.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                          color: Colors.blue.shade300),
                                    ),
                                  ),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                const Spacer(), // Takes up remaining space to push buttons to the bottom
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48.h, // Set height as per your need
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFFFFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(11.0.r),
                              ),
                            ),
                            padding: EdgeInsets.zero, // Remove padding
                          ),
                          onPressed: () {
                            Get.back(); // Close the dialog
                          },
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 48.h, // Set height as per your need
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFC8019),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(11.0.r),
                              ),
                            ),
                            padding: EdgeInsets.zero, // Remove padding
                          ),
                          onPressed: _submitReview,
                          child: Text(
                            'Submit',
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  RichText heading({required String text}) {
    return RichText(
      text: TextSpan(
        text: text, // Default text
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
          color: Colors.black, // Default text color
        ),
        children: [
          TextSpan(
            text: '*', // Asterisk
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: Colors.orange, // Orange color for asterisk
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate Us Example'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Rate Us'),
          onPressed: () {
            _showRateDialog(context); // Show the dialog when button is pressed
          },
        ),
      ),
    );
  }
}
