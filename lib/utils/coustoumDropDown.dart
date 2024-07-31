import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String? hintText;
  final List<String> items;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;
  final String? value;

  const CustomDropdownFormField({
    super.key,
    this.hintText,
    required this.items,
    this.onChanged,
    this.onSaved,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 50.h,
        width: 300.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.r),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 202, 201, 201).withOpacity(0.09),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // bottom shadow
            ),
            BoxShadow(
              color: const Color.fromARGB(255, 202, 201, 201).withOpacity(0.09),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(3, 0), //left shadow
            ),
            BoxShadow(
              color: const Color.fromARGB(255, 202, 201, 201).withOpacity(0.09),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(3, 0), //up shadow
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.09),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(3, 0), //right shadow
            ),
          ],
        ),
        child: DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.transparent,
            hintText: hintText,
          ),
          hint: Text(
            hintText ?? 'Select',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              color: const Color(0xffD8D8D8),
            ),
          ),
          icon: const Icon(Icons.arrow_drop_down),
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ))
              .toList(),
          validator: (value) {
            if (value == null) {
              return 'Please select an item.';
            }
            return null;
          },
          onChanged: onChanged,
          onSaved: onSaved,
        ),
      ),
    );
  }
}
