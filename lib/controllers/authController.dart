import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLogin = false.obs;
  RxBool isPhoneNumberEmpty = true.obs;
  RxBool isOtpEmpty = true.obs;
  RxString errorMessagePhoneNumber = ''.obs;
  TextEditingController phoneAuthController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  RxBool isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxString verificationId = ''.obs;
  RxBool isCodeSent = false.obs;

  void verifyPhoneNumber() async {
    isLoading.value = true;
    final phoneNumber = "+91${phoneAuthController.text.trim()}";

    if (phoneNumber.isEmpty) {
      errorMessagePhoneNumber.value = "Phone number cannot be empty";
      return;
    }

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        isLogin.value = true;
      },
      verificationFailed: (FirebaseAuthException e) {
        errorMessagePhoneNumber.value = e.message ?? "Verification failed";
        Fluttertoast.showToast(msg: "$e");
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId.value = verificationId;
        isCodeSent.value = true;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId.value = verificationId;
      },
    );
    isLoading.value = false;
  }

  void signInWithOtp() async {
    isLoading.value = true;
    final otp = otpController.text.trim();
    if (otp.isEmpty) {
      isOtpEmpty.value = true;
      return;
    }

    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId.value,
      smsCode: otp,
    );

    try {
      await _auth.signInWithCredential(credential);
      isLogin.value = true;
    } catch (e) {
      errorMessagePhoneNumber.value = "Invalid OTP";
    }
    isLoading.value = false;
  }
}
