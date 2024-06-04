import 'package:dekhlo/utils/components/buttons.dart';
import 'package:dekhlo/utils/components/heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../utils/components/textstyle.dart';
import '../set_up_product.dart';

class CustoumCategory extends StatelessWidget {
  CustoumCategory({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoriesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: Text(
          "Custom Category",
          style: TextStyles.openSans(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xff4A4A4A)),
        ),
        leading: IconButton(
          onPressed: () {
            SetUpProduct.categorySelectController.clearAllSelection();
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff4A4A4A),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              '''
          We are very sorry that your store category is not listed on HelloDukaan.
          Please let us know you category by typing in the below text box. Our team will soon check the category or categories you are requesting for and will get back to you soon. Thank you.
          ''',
              textAlign: TextAlign.justify,
              style: TextStyles.openSans(
                  color: const Color(0xff4A4A4A), fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: const SmallHeading(headingText: "Your Name"),
          ),
          coustoumTextField(
            controller: nameController,
            hintText: '',
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: const SmallHeading(headingText: "Add Store Categories"),
          ),
          coustoumTextField(
            controller: categoriesController,
            hintText: 'e.g store categories 1,store categories 1',
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Buttons.longButton(
                color: const Color(0xffFC8019),
                context: context,
                onPressedCallback: () {
                  if (nameController.text.isEmpty ||
                      categoriesController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please fill all the details");
                  } else {
                    Fluttertoast.showToast(msg: "sent");
                  }
                },
                buttonText: "Send",
                textColor: Colors.white),
          )
        ],
      ),
    );
  }

  Padding coustoumTextField(
      {required TextEditingController controller, required String hintText}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: const TextStyle(color: Color(0xffC4C4C4)),
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 18.0.h),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0.r),
            borderSide: const BorderSide(
              color: Color(0xFFC4C4C4), // Border color
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0.r),
            borderSide: const BorderSide(
              color: Color(0xFFC4C4C4), // Border color
            ),
          ),
        ),
      ),
    );
  }
}
