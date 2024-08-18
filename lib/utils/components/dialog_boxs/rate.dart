import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:dekhlo/services/injection.dart';

// GetX Controller
class RateUsController extends GetxController {
  final RxInt selectedValue = 1.obs; // Initial value
  final RxDouble ratingStar = 0.0.obs;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController totalBillingAmountController =
      TextEditingController();
  final String requirementId;

  RateUsController({required this.requirementId});

  void submitReview() async {
    try {
      await restClient.postReviews(requirementId, {
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
}

// Dialog Widget
class RateUsDialog extends StatelessWidget {
  final RateUsController controller;

  const RateUsDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11.0.r), // Rounded corners
      ),
      contentPadding: EdgeInsets.zero, // Remove content padding
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 40), // Remove inset padding
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
                  _buildHeading('Help us improve! Rate your experience'),
                  SizedBox(height: 10.h),
                  _buildRatingBar(),
                  SizedBox(height: 20.h),
                  Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeading("Select your pickup option"),
                          SizedBox(height: 20.h),
                          _buildPickupOptions(context),
                          SizedBox(height: 20.h),
                          _buildTextField(
                              controller.totalBillingAmountController,
                              'Enter Total Billing Amount'),
                          SizedBox(height: 10.h),
                          _buildTextField(controller.descriptionController,
                              'Tell us what you think...',
                              maxLines: 5),
                        ],
                      )),
                ],
              ),
            ),
            const Spacer(), // Takes up remaining space to push buttons to the bottom
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  // Reusable Widgets
  RichText _buildHeading(String text) {
    return RichText(
      text: TextSpan(
        text: text,
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: '*',
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  RatingBar _buildRatingBar() {
    return RatingBar(
      initialRating: 0,
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
        controller.ratingStar.value = rating;
      },
    );
  }

  Row _buildPickupOptions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildRadioOption(1, "In-Store Pickup", context),
        _buildRadioOption(2, "Home Delivery", context),
      ],
    );
  }

  Row _buildRadioOption(int value, String text, BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 0.8,
          child: Radio<int>(
            activeColor: const Color(0xffFC8019),
            value: value,
            groupValue: controller.selectedValue.value,
            onChanged: (int? val) {
              controller.selectedValue.value = val!;
            },
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        Text(
          text,
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.w400,
            fontSize: 13.sp,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  SizedBox _buildTextField(TextEditingController controller, String hintText,
      {int maxLines = 1}) {
    return SizedBox(
      height: maxLines == 1 ? 40.h : 104.h,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: Colors.blue.shade300),
          ),
        ),
        style: const TextStyle(fontSize: 14),
        maxLines: maxLines,
      ),
    );
  }

  Row _buildButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48.h,
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
            height: 48.h,
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
              onPressed: controller.submitReview,
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
    );
  }
}
