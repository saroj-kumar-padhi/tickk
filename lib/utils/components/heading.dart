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
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff4A4A4A))),
    );
  }
}
