import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Buttons {
  static Padding longButton(
      {required Color color,
      required BuildContext context,
      required VoidCallback onPressedCallback,
      required String buttonText,
      required Color textColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalSizes.getDeviceWidth(context) * 0.05,
          vertical: GlobalSizes.getDeviceHeight(context) * 0.01),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressedCallback,
          style: ElevatedButton.styleFrom(
            side: const BorderSide(
              color: Color(0xffFC8019),
              width: 0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            backgroundColor: color,
            padding: EdgeInsets.all(GlobalSizes.getDeviceWidth(context) * 0.04),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 18.0,
              color: textColor, // Text color
            ),
          ),
        ),
      ),
    );
  }

  static Padding shortButton(
      {required Color color,
      required BuildContext context,
      required VoidCallback onPressedCallback,
      required String buttonText,
      required Color textColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalSizes.getDeviceWidth(context) * 0.016,
        vertical: GlobalSizes.getDeviceHeight(context) * 0.009,
      ),
      child: SizedBox(
        width:
            GlobalSizes.getDeviceWidth(context) * 0.3, // Adjust width as needed
        height: GlobalSizes.getDeviceHeight(context) *
            0.05, // Adjust height as needed
        child: ElevatedButton(
          onPressed: onPressedCallback,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            backgroundColor: color,
            padding: EdgeInsets.fromLTRB(
                GlobalSizes.getDeviceWidth(context) * -0.1,
                GlobalSizes.getDeviceHeight(context) * 0.001,
                GlobalSizes.getDeviceWidth(context) * -0.1,
                GlobalSizes.getDeviceHeight(context) * 0.001),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 16.0, // Adjust font size as needed
              color: textColor, // Text color
            ),
          ),
        ),
      ),
    );
  }

  static GestureDetector veryShortButton(
      {required Color color,
      required BuildContext context,
      required VoidCallback onPressedCallback,
      required String buttonText,
      required Color textColor}) {
    return GestureDetector(
      onTap: onPressedCallback,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.127,
        height: MediaQuery.of(context).size.height * 0.04,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12, // Adjust font size as needed
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  static Padding smallCallButton({
    required String buttonText,
    required VoidCallback onPressed,
    double height = 28.0,
    double width = 38.0,
    double borderRadius = 4.0,
    Color borderColor = const Color(0xffFC8019),
    Color foregroundColor = const Color(0xffFC8019),
    TextStyle? textStyle,
    EdgeInsetsGeometry padding = const EdgeInsets.only(right: 2.0),
  }) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: height.h,
        width: width.w,
        child: TextButton(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius.r),
              ),
            ),
            side: WidgetStateProperty.all(BorderSide(color: borderColor)),
            foregroundColor: WidgetStateProperty.all(foregroundColor),
          ),
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: textStyle ??
                TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 11.5.sp,
                  color: foregroundColor,
                ),
          ),
        ),
      ),
    );
  }

  static SizedBox smallDealDoneButton() {
    return SizedBox(
      height: 28.h,
      width: 35.w,
      child: TextButton(
          style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(4.0.r), // Adjust radius as needed
                ),
              ),
              side: WidgetStateProperty.all(
                  const BorderSide(color: Color(0xffFC8019))),
              backgroundColor: const WidgetStatePropertyAll(Color(0xffFC8019)),
              foregroundColor: const WidgetStatePropertyAll(Colors.white)),
          onPressed: () {},
          child: Text(
            "DD",
            style: TextStyles.openSans(
                fontWeight: FontWeight.w600, fontSize: 11.5.sp),
          )),
    );
  }

  static coustoumTextButton({required VoidCallback onPressedCallback}) {
    return TextButton(
        onPressed: onPressedCallback,
        child: Text(
          "Clear",
          style: TextStyles.openSans(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xff4A4A4A)),
        ));
  }
}
