import 'package:dekhlo/controllers/productSetupController.dart';
import 'package:dekhlo/controllers/sortDialogBoxController.dart';
import 'package:dekhlo/utils/components/buttons.dart';
import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  late GoogleMapController _mapController;
  DialogBoxController dialogBoxController = Get.put(DialogBoxController());

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                  dialogBoxController.setMapController(controller);
                  setState(() {});
                },
                onCameraMove: (CameraPosition newPosition) {
                  dialogBoxController.latitude.value =
                      newPosition.target.latitude;
                  dialogBoxController.longitude.value =
                      newPosition.target.longitude;
                },
                onCameraIdle: () {
                  // Trigger marker update when the camera stops moving
                  dialogBoxController.updateLocationFromCoordinates(
                    dialogBoxController.latitude.value,
                    dialogBoxController.longitude.value,
                  );
                },
                markers: {
                  Marker(
                    markerId: const MarkerId('selected_location'),
                    position: LatLng(
                      dialogBoxController.latitude.value,
                      dialogBoxController.longitude.value,
                    ),
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
                            Get.toNamed(RouteName.changeLocation);
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
                  onPressedCallback: () async {
                    Future.delayed(const Duration(seconds: 0), () {
                      Get.back();
                    });
                    ProductSetUpController().updateButtonState();
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
