import 'package:dekhlo/controllers/authController.dart';
import 'package:dekhlo/utils/Strings/strings.dart';
import 'package:dekhlo/utils/components/Coustum_RichText.dart';
import 'package:dekhlo/utils/components/buttons.dart';
import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:dekhlo/views/buyer_view/loginPages/otptimerController.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

import 'package:pinput/pinput.dart';

class LogINOTP extends StatelessWidget {
  const LogINOTP({super.key});

  @override
  Widget build(BuildContext context) {
    OTPTimmerController authController = Get.put(OTPTimmerController());
    AuthController authController1 = Get.put(AuthController());
    final defaultPinTheme = PinTheme(
      width: GlobalSizes.getDeviceWidth(context) * 0.4,
      height: GlobalSizes.getDeviceHeight(context) * 0.06,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xffE4E4E4)),
      ),
    );

    return Scaffold(
      body: Animate(
        effects: [
          SlideEffect(
              begin: const Offset(1, 0), // Start from bottom
              end: const Offset(0, 0), // End at normal position
              duration: 500.ms, // Animation duration
              curve: Curves.easeOut // Animation curve
              ),
        ],
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
            ),
            body: Obx(() {
              return authController.isLoading.value
                  ? Scaffold(
                      body: Center(
                          child: LottieBuilder.asset("assest/mX2qe5gUvP.json")),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: GlobalSizes.getDeviceHeight(context) * 0.03,
                        ),
                        Center(
                          child: Text(
                            "Enter verification code",
                            style: GoogleFonts.openSans(
                                fontSize: 27, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: GlobalSizes.getDeviceHeight(context) * 0.02,
                        ),
                        Text(
                          "We sent a verification code",
                          style: GoogleFonts.openSans(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "to +91 ${authController1.phoneAuthController.text}",
                          style: GoogleFonts.openSans(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: GlobalSizes.getDeviceHeight(context) * 0.05,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalSizes.getDeviceWidth(context) * 0.05),
                          child: Pinput(
                            controller: authController.otpController,
                            onChanged: (val) {
                              if (val.length == 6) {
                                authController.isOtpEmpty.value = false;
                              } else {
                                authController.isOtpEmpty.value = true;
                              }
                            },
                            length: 6,
                            defaultPinTheme: defaultPinTheme,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalSizes.getDeviceWidth(context) * 0.05,
                              vertical: 10),
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: OTPText()),
                        ),
                        Obx(() {
                          return Buttons.longButton(
                            color: authController.isOtpEmpty.value
                                ? const Color(0xffFC8019).withOpacity(0.2)
                                : const Color(0xffFC8019),
                            buttonText: 'Login',
                            textColor: Colors.white,
                            context: context,
                            onPressedCallback: () async {
                              if (authController.otpController.text.length ==
                                  6) {
                                // authController1.signInWithOtp();
                                await authController1.validateOTP(
                                    otp: authController.otpController.text,
                                    islogin: true);
                              } else {}
                            },
                          );
                        }),
                        const Spacer(),
                      ],
                    );
            })),
      ),
    );
  }
}

class OTPText extends StatelessWidget {
  const OTPText({super.key});

  @override
  Widget build(BuildContext context) {
    OTPTimmerController authController = Get.find();
    return Obx(() {
      return Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Didn’t you get OTP? ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                if (!authController.canResendOtp.value)
                  TextSpan(
                    text: 'Retry in ${authController.resendOtpTimer.value}s',
                    style: const TextStyle(color: Colors.black),
                  ),
                if (authController.canResendOtp.value)
                  TextSpan(
                    text: 'Resend OTP',
                    style: const TextStyle(color: Color(0xffFC8019)),
                    recognizer: TapGestureRecognizer()
                      ..onTap = authController.resendOtp,
                  ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
