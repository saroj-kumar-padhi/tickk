import 'package:dekhlo/utils/components/Coustum_RichText.dart';
import 'package:dekhlo/utils/components/buttons.dart';
import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:dekhlo/utils/size/global_size.dart/global_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:pinput/pinput.dart';

class OTP extends StatelessWidget {
  const OTP({super.key});

  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Column(
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
            "We send verification code",
            style:
                GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          Text(
            "to +91 6280644889",
            style:
                GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: GlobalSizes.getDeviceHeight(context) * 0.05,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: GlobalSizes.getDeviceWidth(context) * 0.05),
            child: Pinput(
              // controller: authController.otpController,

              length: 6,
              defaultPinTheme: defaultPinTheme,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: GlobalSizes.getDeviceWidth(context) * 0.05,
                vertical: 10),
            child:
                const Align(alignment: Alignment.centerLeft, child: OTPText()),
          ),
          LongButton.longButton(
            color: const Color(0xffFC8019),
            buttonText: 'Login',
            textColor: Colors.white,
            context: context,
            onPressedCallback: () {
              Get.toNamed(RouteName.langScreen);
            },
          ),
          const Spacer(),
          const Padding(
              padding: EdgeInsets.only(bottom: 35),
              child: CoustumRichText(
                text1: 'Don’t have an account? ',
                text2: 'Signup',
              ))
        ],
      ),
    );
  }
}

class OTPText extends StatelessWidget {
  const OTPText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Didn’t you get OTP? ',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              TextSpan(text: ' & ', style: TextStyle(color: Colors.black)),
              TextSpan(
                text: ' Resend OTP',
                style: TextStyle(color: Color(0xffFC8019)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
