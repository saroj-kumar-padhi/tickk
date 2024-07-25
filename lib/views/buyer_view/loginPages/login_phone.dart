import 'package:dekhlo/controllers/authController.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:dekhlo/utils/Strings/strings.dart';
import 'package:dekhlo/utils/components/buttons.dart';
import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/web.dart';
import 'package:lottie/lottie.dart';
import '../../../utils/components/Coustum_RichText.dart';
import '../../singUpPages/Singup_phone.dart';

class ErrorResponse {
  final String message;

  ErrorResponse({required this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      message: json['message'] as String,
    );
  }
}

class LogInPhone extends StatelessWidget {
  final String? msg;

  const LogInPhone({super.key, this.msg});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return Scaffold(
      body: SafeArea(child: Obx(() {
        return authController.isLoading.value
            ? Scaffold(
                body: Center(
                    child: LottieBuilder.asset("assest/mX2qe5gUvP.json")),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Center(
                          child: Text(
                        "Welcome back!",
                        style: TextStyles.openSans(),
                      ))),
                  SizedBox(height: GlobalSizes.getDeviceHeight(context) * 0.01),
                  msg == null
                      ? Text(
                          "Enter your registered mobile number, We will send you OTP",
                          style: TextStyles.openSans(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50.w),
                          child: Text(
                            "The mobile number you are trying to signup is already registered on Tickk. Please Login here.",
                            style: TextStyles.openSans(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ),
                  // Text("send you OTP",
                  //     style: TextStyles.openSans(
                  //         fontSize: 12, fontWeight: FontWeight.w400)),
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
                          //check logic
                          try {
                            ErrorResponse errorResponse =
                                await restClient.checkMobileNumberIfRegistered(
                                    authController.phoneAuthController.text);

                            if (errorResponse.message ==
                                "Mobile not registered") {
                              authController.phoneAuthController.clear();
                              await Future.delayed(const Duration(seconds: 1));
                              Get.to(const Phone(
                                msg: "eufukgfy",
                              ));
                            } else {
                              if (!authController.isPhoneNumberEmpty.value) {
                                if (authController
                                        .phoneAuthController.text.length !=
                                    10) {
                                  authController.errorMessagePhoneNumber.value =
                                      'The number you entered is not valid.';
                                } else {
                                  await authController.LoginWithOtp();

                                  Get.toNamed(RouteName.logInotpScreen);
                                }
                              }
                            }
                          } catch (e) {
                            Logger().f(e);
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
