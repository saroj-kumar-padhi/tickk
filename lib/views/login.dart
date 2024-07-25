import 'package:dekhlo/controllers/authController.dart';
import 'package:dekhlo/utils/Strings/strings.dart';
import 'package:dekhlo/utils/components/buttons.dart';
import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'buyer_view/profileScreen/FAQ_webview.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return WillPopScope(
      onWillPop: () async {
        // Directly quit the app
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: GlobalSizes.getDeviceWidth(context),
                height: GlobalSizes.getDeviceHeight(context) * .35,
                decoration: const BoxDecoration(
                  color: Color(0xffFFF5EC),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                ),
                child: Center(
                  child: Image.asset("assest/tickk.png"),
                ),
              ),
              SizedBox(
                height: GlobalSizes.getDeviceWidth(context) * 0.04,
              ),
              Buttons.longButton(
                  color: const Color(0xffFC8019),
                  buttonText: AppStrings.logInButtonString,
                  textColor: const Color(0xffFFFFFF),
                  context: context,
                  onPressedCallback: () {
                    authController.isLogin.value = true;
                    authController.isOtpEmpty.value = true;
                    authController.isPhoneNumberEmpty.value = true;
                    authController.otpController.clear();
                    authController.phoneAuthController.clear();
                    Get.toNamed(RouteName.logInphoneScreen);
                  }),
              Buttons.longButton(
                  color: const Color(0xffFFFFFF),
                  buttonText: AppStrings.signUpButtonText,
                  textColor: const Color(0xffFC8019),
                  context: context,
                  onPressedCallback: () {
                    authController.isLogin.value = false;
                    authController.isOtpEmpty.value = true;
                    authController.isPhoneNumberEmpty.value = true;
                    authController.otpController.clear();
                    authController.phoneAuthController.clear();
                    Get.toNamed(RouteName.signPhoneScreen);
                  }),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(AppStrings.arreingText1),
                    ),
                    const TermsAndPolicyText()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TermsAndPolicyText extends StatelessWidget {
  const TermsAndPolicyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: AppStrings.terms,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.to(() => const WebViewScreen(
                          url: 'https://www.tickk.in/terms-and-conditions',
                        ));
                  },
                style: const TextStyle(
                  color: Color(0xffFC8019),
                ),
              ),
              const TextSpan(
                  text: ' & ', style: TextStyle(color: Colors.black)),
              TextSpan(
                text: AppStrings.privacyPoilcy,
                style: const TextStyle(color: Color(0xffFC8019)),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.to(() => const WebViewScreen(
                          url: 'https://www.tickk.in/privacy-policy',
                        ));
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
