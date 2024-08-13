import 'dart:async';
import 'package:dekhlo/services/injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import '../utils/routes/routes_names.dart';
import '../views/buyer_view/home_screen_buyer.dart/home_screenBuyer.dart';
import '../views/seller_views/seller_home_screens/seller_home.dart';

class AuthController extends GetxController {
  RxBool isLogin = false.obs;
  RxBool isPhoneNumberEmpty = true.obs;
  RxBool isOtpEmpty = true.obs;
  RxString errorMessagePhoneNumber = ''.obs;
  TextEditingController phoneAuthController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  RxBool isLoading = false.obs;

  RxString verificationId = ''.obs;
  RxBool isCodeSent = false.obs;

  Future<void> signUpWithOtp() async {
    try {
      isLoading.value = true;
      await restClient.signUpWithOtp({'mobile': phoneAuthController.text});
      isLoading.value = false;
      Get.toNamed(RouteName.signOtpScreen);
    } catch (e) {
      Logger().f(e);
    }
  }

  Future<void> LoginWithOtp() async {
    try {
      isLoading.value = true;
      await restClient.LoginWithOtp({'mobile': phoneAuthController.text});
      isLoading.value = false;
      Get.toNamed(RouteName.logInotpScreen);
    } catch (e) {
      Logger().f(e);
    }
  }

  Future<void> signUpValidateOTP({required String otp}) async {
    try {
      await restClient.verifyPhoneNumber(
          phoneAuthController.text, int.parse(otp));

      final box = Hive.box('mybox');
      box.put('phone', phoneAuthController.text);
      try {
        final response = await restClient
            .checkBuyerOrSeller(int.parse(phoneAuthController.text));

        Get.toNamed(RouteName.basicDetails);
      } catch (e) {
        Logger().d(e);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Invalid otp");
    }
  }

  Future<void> validateOTP({required String otp, required bool islogin}) async {
    try {
      await restClient.verifyPhoneNumber(
          phoneAuthController.text, int.parse(otp));

      final box = Hive.box('mybox');
      box.put('phone', phoneAuthController.text);
      try {
        final response = await restClient
            .checkBuyerOrSeller(int.parse(phoneAuthController.text));
        if (response.message == 'Mobile registered for buyer') {
          Logger().f(response.message);
          Get.to(const HomeBuyer());
        } else if (response.message == 'Mobile registered for seller') {
          try {
            final storeData = await restClient
                .checkStoreId(int.parse(phoneAuthController.text));
            final storeId = storeData.StoreID;
            Logger().d(storeId);
            Get.to(HomeSeller(storeId: storeId.toString()));
          } catch (e) {
            Get.snackbar("Login Failed",
                "Oop's something wrong with server try to login later");
          }
        } else {
          islogin
              ? Get.toNamed(RouteName.homeBuyerScreen)
              : Get.toNamed(RouteName.basicDetails);
        }
      } catch (e) {
        Logger().d(e);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Invalid otp");
    }
  }
}

class MessageOTP {
  final String message;

  MessageOTP({required this.message});

  factory MessageOTP.fromJson(Map<String, dynamic> json) {
    return MessageOTP(
      message: json['message'] as String,
    );
  }
}


















 // Future<bool> checkPhoneNumber() async {
  //   isLoading.value = true;
  //   final phoneNumber = "+91${phoneAuthController.text.trim()}";

  //   if (phoneNumber.isEmpty) {
  //     errorMessagePhoneNumber.value = "Phone number cannot be empty";
  //     isLoading.value = false;
  //     return false;
  //   }

  //   final completer = Completer<bool>();

  //   await _auth.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await _auth.signInWithCredential(credential);
  //       isLogin.value = true;
  //       completer.complete(true);
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       errorMessagePhoneNumber.value = e.message ?? "Verification failed";
  //       Fluttertoast.showToast(msg: "$e");
  //       completer.complete(false);
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       this.verificationId.value = verificationId;
  //       isCodeSent.value = true;
  //       completer.complete(true);
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       this.verificationId.value = verificationId;
  //     },
  //   );

  //   isLoading.value = false;
  //   return await completer.future;
  // }

  // Future<void> signInWithOtp() async {
  //   isLoading.value = true;
  //   final otp = otpController.text.trim();
  //   if (otp.isEmpty) {
  //     isOtpEmpty.value = true;
  //     isLoading.value = false;
  //     return;
  //   }

  //   if (verificationId.value.isEmpty) {
  //     Fluttertoast.showToast(msg: "Verification ID is not set");
  //     isLoading.value = false;
  //     return;
  //   }

  //   try {
  //     final credential = PhoneAuthProvider.credential(
  //       verificationId: verificationId.value,
  //       smsCode: otp,
  //     );

  //     await _auth.signInWithCredential(credential);
  //     isLogin.value = true;
  //     Get.toNamed(RouteName.langScreen);
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: "Invalid OTP");
  //   }
  //   isLoading.value = false;
  // }