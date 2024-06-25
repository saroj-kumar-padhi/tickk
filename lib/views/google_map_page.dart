import 'package:dekhlo/controllers/sortDialogBoxController.dart';
import 'package:dekhlo/utils/components/buttons.dart';
import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

import 'package:dekhlo/controllers/sortDialogBoxController.dart';
import 'package:dekhlo/utils/components/buttons.dart';
import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatelessWidget {
  const GoogleMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    DialogBoxController dialogBoxController = Get.put(DialogBoxController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Flexible(
            flex: 3,
            child: Obx(() {
              LatLng position = LatLng(
                dialogBoxController.latitude.value,
                dialogBoxController.longitude.value,
              );
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: position,
                  zoom: 14,
                ),
                onCameraMove: (CameraPosition newPosition) {
                  dialogBoxController.latitude.value =
                      newPosition.target.latitude;
                  dialogBoxController.longitude.value =
                      newPosition.target.longitude;
                },
                onCameraIdle: () {
                  dialogBoxController.updateLocationFromCoordinates(
                    dialogBoxController.latitude.value,
                    dialogBoxController.longitude.value,
                  );
                },
                markers: {
                  Marker(
                    markerId: const MarkerId('selected_location'),
                    position: position,
                    draggable: true,
                    onDragEnd: (LatLng newPosition) {
                      dialogBoxController.updateLocationFromCoordinates(
                        newPosition.latitude,
                        newPosition.longitude,
                      );
                    },
                  ),
                },
              );
            }),
          ),
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.sp,
                    vertical: 10.sp,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Set Your Location",
                        style: TextStyles.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          color: const Color(0xff4A4A4A),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 30.h,
                        width: 100.w,
                        child: TextButton(
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                            side: WidgetStateProperty.all(
                              const BorderSide(color: Color(0xffFC8019)),
                            ),
                            foregroundColor: WidgetStateProperty.all(
                              const Color(0xffFC8019),
                            ),
                          ),
                          onPressed: () {
                            // Add functionality for the "change" button if needed
                          },
                          child: Text(
                            "change",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                              color: const Color(0xffFC8019),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Location",
                    style: TextStyles.openSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 9,
                    ),
                    child: Text(
                      dialogBoxController.locacationController.value.text,
                      style: TextStyles.openSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff4A4A4A),
                      ),
                    ),
                  );
                }),
                Buttons.longButton(
                  color: const Color(0xffFC8019),
                  context: context,
                  onPressedCallback: () {
                    Get.back();
                  },
                  buttonText: "Confirm",
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
