import 'dart:io';

import 'package:dekhlo/services/injection.dart';
import 'package:dekhlo/services/notificationServices.dart';
import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart' show MediaType;
import '../../../controllers/exactController.dart';
import '../../../controllers/homeSellerController.dart';
import '../../size/global_size/global_size.dart';
import '../buttons.dart';
import '../coustoumTextField.dart';

class AcceptDialodBox extends StatelessWidget {
  final String fcm;
  final bool isExact;
  final List<dynamic> imageList;
  final String requiremetId;
  final String storeId;

  const AcceptDialodBox({
    super.key,
    required this.isExact,
    required this.fcm,
    required this.imageList,
    required this.requiremetId,
    required this.storeId,
  });

  @override
  Widget build(BuildContext context) {
    ExactController exactController = Get.put(ExactController());

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        width: 300.0.w,
        height: 200.0.h,
        child: Stack(
          children: [
            Positioned(
              top: 10.0,
              right: 3.0,
              child: InkWell(
                onTap: () => Get.back(),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.close, size: 24.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8.0.w, 15.h, 10.w, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Please add quotes",
                    style: TextStyles.openSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff4A4A4A),
                    ),
                  ),
                  Text(
                    "You can add pricing ",
                    style: TextStyles.openSans(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff898989),
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      exactController.changeQuteOption(
                          option: value.isNotEmpty);
                    },
                    controller: exactController.quoteEditingController,
                    decoration: InputDecoration(
                      hintText: "Enter your Quote",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: GlobalSizes.getDeviceWidth(context) * 0.009,
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyles.openSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff979797),
                            ),
                          ),
                        ),
                      ),
                      Buttons.shortButton(
                        color: const Color(0xffFC8019),
                        context: context,
                        onPressedCallback: () async {
                          final dio.FormData formData = dio.FormData.fromMap({
                            "RequirementID": requiremetId,
                            "Quote":
                                exactController.quoteEditingController.text,
                            if (isExact) "Exact": "true" else "Similar": "true",
                          });

                          // Add images to formData
                          for (int i = 0; i < imageList.length; i++) {
                            File file = File(imageList[i]);
                            String fileName = path.basename(file.path);
                            String? mimeType = getMimeType(fileName);

                            formData.files.add(MapEntry(
                              "images", // Use "images[]" if your server expects an array
                              await dio.MultipartFile.fromFile(
                                file.path,
                                filename: fileName,
                                contentType: mimeType != null
                                    ? MediaType.parse(mimeType)
                                    : null,
                              ),
                            ));
                          }

                          try {
                            await postdio.exactOrSimilar(formData);
                            Get.back();
                            try {
                              await restClient
                                  .pushtoBuyerInProcessAndSellerInProcess(
                                      requiremetId, {"Accept": true});

                              try {
                                final HomeSellerController
                                    homeSellerController =
                                    Get.put(HomeSellerController(storeId));
                                homeSellerController.fetchSellerData(storeId);
                              } catch (e) {
                                Logger().f(e);
                              }

                              await Fluttertoast.showToast(
                                  msg:
                                      "accepted requested"); // Close the dialog after successful submission
                            } catch (e) {
                              Fluttertoast.showToast(msg: "$e");
                            }
                          } catch (e) {
                            Logger().f(e);
                            // Show an error message to the user
                          }
                        },
                        buttonText: "Accept",
                        textColor: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String? getMimeType(String fileName) {
    final ext = path.extension(fileName).toLowerCase();
    switch (ext) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.gif':
        return 'image/gif';
      case '.bmp':
        return 'image/bmp';
      case '.webp':
        return 'image/webp';
      default:
        return null;
    }
  }
}
                          // PushNotificationServices.sendNotificationtoBuyer(
                          //     fcm, context, "Your request has been accepted");

                          // try {
                          //   User? user = FirebaseAuth.instance.currentUser;
                          //   String phoneNumber = user?.phoneNumber ?? "";
                          //   String formattedPhoneNumber = phoneNumber.isNotEmpty
                          //       ? phoneNumber.substring(3)
                          //       : "";

                          //   final storeData = await restClient
                          //       .checkStoreId(int.parse(formattedPhoneNumber));
                          //   final storeId = storeData.StoreID;
                          //   try {
                          //     await restClient.sendQuote(storeId, {
                          //       "RequirementID": requiremetId,
                          //       "Quote":
                          //           exactController.quoteEditingController.text
                          //     });
                          //     Fluttertoast.showToast(msg: "Sent");
                          //   } catch (e) {
                          //     Logger().d(e);
                          //   }
                          //   Fluttertoast.showToast(msg: "Accepted");
                          //   Get.back();
                          // } catch (e) {
                          //   Logger().d(e);
                          // }