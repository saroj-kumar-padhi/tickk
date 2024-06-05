import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/basicController.dart';
import '../../../controllers/dropDownController.dart';
import '../../../utils/components/buttons.dart';
import '../../../utils/components/textstyle.dart';
import '../../../utils/coustoumDropDown.dart';
// Import the form controller

class BasicDetails extends StatelessWidget {
  const BasicDetails({super.key});

  @override
  Widget build(BuildContext context) {
    DropdownController dropdownController = Get.put(DropdownController());
    BasicDetailsController basicDetailsController =
        Get.put(BasicDetailsController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Center(
                child: Text(
                  "Signup to get started !",
                  style: TextStyles.openSans(),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            coustoumTextField(
              text: 'Full Name',
              controller: basicDetailsController.fullNameController,
              onChanged: (value) => basicDetailsController.updateButtonState(),
            ),
            SizedBox(
              height: 30.h,
            ),
            coustoumTextField(
              text: 'Email address(optional)',
              controller: basicDetailsController.emailAddressController,
              onChanged: (value) => basicDetailsController.updateButtonState(),
            ),
            SizedBox(
              height: 20.h, //ic_launcher
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 55.h,
                      child: CustomDropdownFormField(
                        borderColor: const Color(0xFFC4C4C4),
                        hintText: 'Gender',
                        items: dropdownController.GenderList,
                        onChanged: (value) {},
                        onSaved: (value) {},
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 55.h,
                      child: TextField(
                        controller: basicDetailsController.ageController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "Age",
                          labelStyle: const TextStyle(color: Color(0xffC4C4C4)),
                          hintStyle: const TextStyle(color: Colors.grey),
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
                        onChanged: (value) =>
                            basicDetailsController.updateButtonState(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Obx(() => Buttons.longButton(
                  color: const Color(0xffFC8019).withOpacity(
                      basicDetailsController.isButtonEnabled.value ? 0.9 : 0.2),
                  context: context,
                  onPressedCallback:
                      basicDetailsController.isButtonEnabled.value
                          ? () {
                              Get.toNamed(RouteName.homeBuyerScreen);
                            }
                          : () {},
                  buttonText: 'Sign Up',
                  textColor: Colors.white,
                )),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Padding coustoumTextField(
      {required String text,
      required TextEditingController controller,
      ValueChanged<String>? onChanged}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: text,
          labelStyle: const TextStyle(color: Color(0xffC4C4C4)),
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.0),
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
