import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../size/global_size/global_size.dart';
import '../textstyle.dart';

class PickImageDialog extends StatelessWidget {
  const PickImageDialog({super.key});

  Future<void> pickImage(ImageSource source, BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      Get.back(result: image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                onTap: () {
                  Get.back();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.close,
                    size: 24.0,
                  ),
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
                      "Upload your store images",
                      style: TextStyles.openSans(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => pickImage(ImageSource.camera, context),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              "assest/cam_svg.svg",
                              height: 23.h,
                              width: 28.w,
                            ),
                            Text(
                              "Camera",
                              style: TextStyles.openSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: const Color(0xff939393)),
                            )
                          ],
                        ),
                      ),
                      Image.asset("assest/bigLine.png"),
                      GestureDetector(
                        onTap: () => pickImage(ImageSource.gallery, context),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              "assest/gallery.svg",
                              semanticsLabel: 'Acme Logo',
                            ),
                            Text(
                              "Gallery",
                              style: TextStyles.openSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: const Color(0xff939393)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
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
