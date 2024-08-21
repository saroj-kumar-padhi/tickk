import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double height;
  final double width;
  final ValueChanged<String>? onChanged;
  final bool isenable;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.height,
    required this.width,
    this.onChanged,
    required this.isenable,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffC4CDD5)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextField(
          keyboardType: keyboardType,
          enabled: isenable,
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: const Color(0xffD8D8D8),
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          ),
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
    );
  }
}
