import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPTimmerController extends GetxController {
  var isLoading = false.obs;
  var otpController = TextEditingController();
  var isOtpEmpty = true.obs;
  var canResendOtp = false.obs;
  var resendOtpTimer = 30.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    startResendOtpTimer();
    super.onInit();
  }

  void startResendOtpTimer() {
    resendOtpTimer.value = 60;
    canResendOtp.value = false;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendOtpTimer.value > 0) {
        resendOtpTimer.value--;
      } else {
        canResendOtp.value = true;
        timer.cancel();
      }
    });
  }

  void signInWithOtp() {
    // Implement your sign-in logic here
  }

  void resendOtp() {
    // Implement your resend OTP logic here
    startResendOtpTimer();
  }
}
