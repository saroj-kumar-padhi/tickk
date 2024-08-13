import 'package:dekhlo/controllers/authController.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:dekhlo/utils/components/buttons.dart';
import 'package:dekhlo/utils/components/dialog_boxs/succsess_dialog.dart';
import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:pinput/pinput.dart';
import '../../../controllers/basicControllerEdit.dart';
import '../../../views/login.dart';
import '../../size/global_size/global_size.dart';
import '../textstyle.dart';

class OtpController extends GetxController {
  RxBool canResend = true.obs;
  RxInt remainingTime = 60.obs;

  void startResendTimer() {
    canResend.value = false;
    remainingTime.value = 60;
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      remainingTime.value--;
      if (remainingTime.value <= 0) {
        canResend.value = true;
        return false;
      }
      return true;
    });
  }
}

class OtpDialog extends StatelessWidget {
  final String nametoNavigate;
  final String phone;
  final Map<String, dynamic>? body;
  final String reason;

  OtpDialog({
    super.key,
    required this.nametoNavigate,
    required this.phone,
    this.body,
    required this.reason,
  });

  final OtpController otpController = Get.put(OtpController());
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BasiccontrollerEdit basiccontrollerEdit = BasiccontrollerEdit();
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
                onTap: () => Get.back(),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.close, size: 24.0),
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
                      "We sent a verification code to ${AuthController().phoneAuthController.text}",
                      style: TextStyles.openSans(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: GlobalSizes.getDeviceWidth(context) * 0.05),
                    child: Pinput(
                      controller: textEditingController,
                      length: 6,
                      defaultPinTheme: defaultPinTheme,
                      autofocus: true, // Ensure autofocus is enabled
                      onChanged: (value) {
                        // Optionally handle changes to the input
                      },
                      onCompleted: (pin) {
                        // Optionally handle when the pin is completely filled
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(height: 65.h),
                  Buttons.longButton(
                    color: const Color(0xffFC8019),
                    context: context,
                    onPressedCallback: () async {
                      try {
                        final box = Hive.box('myBox');
                        final String formattedPhoneNumber =
                            box.get('phone') ?? "";
                        try {
                          await restClient.deleteAccountVerifyOTP(
                              formattedPhoneNumber, textEditingController.text);
                        } catch (e) {
                          Fluttertoast.showToast(msg: e.toString());
                        }

                        try {
                          await restClient.deleteAccount(formattedPhoneNumber,
                              {"DeleteAccountReason": reason});
                          Future.delayed(Duration.zero, () {
                            nametoNavigate == 'success'
                                ? showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const SuccessDialog(
                                        tile:
                                            'Profile Details have been updated Successfully!',
                                      );
                                    },
                                  )
                                : showSuccessDeleteDialog(context);
                            Get.to(const Login());
                          });

                          Get.to(const Login());
                        } catch (e) {
                          Logger().d(e);
                        }
                      } catch (e) {
                        Logger().d(e);
                      }
                      Get.back();
                    },
                    buttonText: 'Delete',
                    textColor: Colors.white,
                  ),
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
