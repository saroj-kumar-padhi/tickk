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
        height: 40.h,
        width: 300.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: const Color(0xffC4CDD5)),
        ),
        child: DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(14.w, 0.h, 14.w, 5.h),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.transparent,
            hintText: hintText,
          ),
          hint: Text(
            '',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              color: const Color(0xffD8D8D8),
            ),
          ),
          icon: Center(
            child: Icon(Icons.arrow_drop_down, size: 24.h),
          ),
          iconSize: 20.h,
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        item,
                        style: TextStyle(fontSize: 14.sp),
                      ),
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
