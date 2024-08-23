import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmallHeading extends StatelessWidget {
  final String headingText;
  const SmallHeading({
    super.key,
    required this.headingText,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(headingText,
          style: TextStyles.openSans(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xff4A4A4A))),
    );
  }
}

class SmallHeadingOrange extends StatelessWidget {
  final String headingText;
  const SmallHeadingOrange({
    super.key,
    required this.headingText,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: headingText,
                style: TextStyles.openSans(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: "*",
                style: TextStyles.openSans(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xffFC8019), // Orange color for the star
                ),
              ),
            ],
          ),
        ));
  }
}
