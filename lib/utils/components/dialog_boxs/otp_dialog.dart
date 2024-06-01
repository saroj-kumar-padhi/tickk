import 'package:dekhlo/utils/components/buttons.dart';
import 'package:dekhlo/utils/components/dialog_boxs/succsess_dialog.dart';
import 'package:dekhlo/views/buyer_view/faq_screens/deleteScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../size/global_size/global_size.dart';
import '../textstyle.dart';

class OtpDialog extends StatelessWidget {
  final String nametoNavigate;

  const OtpDialog({super.key, required this.nametoNavigate});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    final defaultPinTheme = PinTheme(
      width: 60.w,
      height: 30.h,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xffE4E4E4)),
      ),
    );
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 10.0,
              right: 10.0,
              child: GestureDetector(
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    Get.back();
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.close,
                    size: 24.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: GlobalSizes.getDeviceHeight(context) * 0.01),
                    child: Text(
                      "We send verification code to +9378478328",
                      style: TextStyles.openSans(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: GlobalSizes.getDeviceWidth(context) * 0.05),
                    child: Pinput(
                      controller: textEditingController,
                      onChanged: (val) {
                        // if (val.length == 6) {
                        //   textEditingController.isOtpEmpty.value = false;
                        // } else {
                        //   authController.isOtpEmpty.value = true;
                        // }
                      },
                      length: 6,
                      defaultPinTheme: defaultPinTheme,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                      child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Didn’t you get OTP? ",
                          style: TextStyles.openSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          ),
                        ),
                        TextSpan(
                          text: "Resend OTP",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: Colors.orange, // Set the color to orange
                          ),
                          // Add your onTap callback for resend OTP here if needed
                        ),
                      ],
                    ),
                  )),
                  SizedBox(
                    height: 60.h,
                    child: Buttons.longButton(
                        color: const Color(0xffFC8019),
                        context: context,
                        onPressedCallback: () {
                          Future.delayed(Duration.zero, () {
                            Get.back();
                          });

                          Future.delayed(Duration.zero, () {
                            nametoNavigate == 'success'
                                ? showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const SuccessDialog(
                                        tile:
                                            'Profile Details has been updated Successfully!',
                                      );
                                    },
                                  )
                                : showSuccessDeleteDialog(context);
                          });
                        },
                        buttonText: 'Signup',
                        textColor: Colors.white),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showSuccessDeleteDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const AlertDialog(
        content: Text(
            "We have deleted your account successfully. We incorporate your feedback to serve you better in near future. Take care."),
      );
    },
  );
}
