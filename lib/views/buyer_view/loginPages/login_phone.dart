import 'package:dekhlo/controllers/authController.dart';
import 'package:dekhlo/utils/Strings/strings.dart';
import 'package:dekhlo/utils/components/buttons.dart';
import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../utils/components/Coustum_RichText.dart';

class LogInPhone extends StatelessWidget {
  const LogInPhone({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return Scaffold(
      body: SafeArea(child: Obx(() {
        return authController.isLoading.value
            ? Scaffold(
                backgroundColor: const Color(0xffFC8019),
                body: Center(
                  child: LoadingAnimationWidget.inkDrop(
                      color: const Color(0xffE4E4E4), size: 200),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Center(
                          child: Text(
                        "Welcome back!",
                        style: TextStyles.openSans(),
                      ))),
                  SizedBox(height: GlobalSizes.getDeviceHeight(context) * 0.01),
                  Text(
                    "Enter your mobile number, We will",
                    style: TextStyles.openSans(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  Text("send you OTP",
                      style: TextStyles.openSans(
                          fontSize: 12, fontWeight: FontWeight.w400)),
                  SizedBox(
                    height: GlobalSizes.getDeviceHeight(context) * .05,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        if (val.length == 10) {
                          authController.errorMessagePhoneNumber.value = '';
                          authController.isPhoneNumberEmpty.value = false;
                        } else {
                          authController.isPhoneNumberEmpty.value = true;
                        }
                      },
                      controller: authController.phoneAuthController,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey), // Border color when focused
                        ),
                        label: Text(
                          "Mobile Number",
                          style: TextStyle(color: Colors.grey),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Obx(() => authController.errorMessagePhoneNumber.value == ''
                      ? const Text('')
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalSizes.getDeviceWidth(context) * 0.06),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              authController.errorMessagePhoneNumber.value,
                              style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.red),
                            ),
                          ),
                        )),
                  SizedBox(
                    height: GlobalSizes.getDeviceHeight(context) * 0.025,
                  ),
                  Obx(() {
                    return Buttons.longButton(
                        color: authController.isPhoneNumberEmpty.value
                            ? const Color(0xffFC8019).withOpacity(0.2)
                            : const Color(0xffFC8019),
                        buttonText: 'Next',
                        textColor: Colors.white,
                        context: context,
                        onPressedCallback: () async {
                          if (!authController.isPhoneNumberEmpty.value) {
                            if (authController
                                    .phoneAuthController.text.length !=
                                10) {
                              authController.errorMessagePhoneNumber.value =
                                  'The number you entered is not valid.';
                            } else {
                              authController.verifyPhoneNumber();
                              Get.toNamed(RouteName.logInotpScreen);
                            }
                          }
                        });
                  }),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: GlobalSizes.getDeviceHeight(context) * 0.04),
                    child: CoustumRichText(
                      text1: 'Don’t have an account? ',
                      text2: AppStrings.signUpButtonText,
                      callBack: () {
                        Get.toNamed(RouteName.signPhoneScreen);
                      },
                    ),
                  )
                ],
              );
      })),
    );
  }
}
