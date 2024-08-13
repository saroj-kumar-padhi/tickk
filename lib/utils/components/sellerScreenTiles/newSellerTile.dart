import 'dart:io';
import 'dart:math';

import 'package:blur/blur.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

import '../../../controllers/exactController.dart';
import '../../../controllers/homeSellerController.dart';
import '../dialog_boxs/accept_dialod_box.dart';
import '../dialog_boxs/pick_diallo.dart';
import '../textstyle.dart';

class NewSellerCard extends StatelessWidget {
  final int index;
  final String storeId;
  final String storeCategory;
  final String requirementId;
  final String storeSubCategory;
  final String brands;
  final String date;
  final String modelNo;
  final String Qty;
  final String size;
  final String units;
  final String Requirement_in_details;
  final String FCM;
  final String image;
  final String name;
  final String profileImage;

  const NewSellerCard({
    super.key,
    required this.storeCategory,
    required this.storeSubCategory,
    required this.brands,
    required this.date,
    required this.modelNo,
    required this.Qty,
    required this.size,
    required this.units,
    required this.Requirement_in_details,
    required this.requirementId,
    required this.FCM,
    required this.image,
    required this.storeId,
    required this.name,
    required this.index,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    ExactController exactController = Get.put(ExactController());
    final HomeSellerController homeSellerController =
        Get.put(HomeSellerController(storeId));
    String text = Requirement_in_details;
    RxList pickedImage = [].obs;
    return Obx(() {
      return Container(
          width: double.infinity, // Adjust the width as needed
          height: exactController.items[index] != ""
              ? 415.h
              : 270.h, // Adjust the height as needed
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
                4.r), // Adjust the border radius for a squared shape
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  profileImage == "task/assets/men.png"
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ClipOval(
                            child: SizedBox(
                              height: 40.h,
                              width: 40.w,
                              child: Image.network(
                                      'https://www.citypng.com/public/uploads/preview/download-profile-user-round-orange-icon-symbol-png-11639594360ksf6tlhukf.png')
                                  .blurred(
                                blur: 2,
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ClipOval(
                            child: SizedBox(
                              height: 40.h,
                              width: 40.h,
                              child: Image.network(profileImage).blurred(
                                blur: 2,
                              ),
                            ),
                          ),
                        ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 17.w),
                        child: Text(
                          "Requirement ID : #$requirementId",
                          style: TextStyles.openSans(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 17.w),
                        child: Text(
                          name.isNotEmpty ? '${name[0]}${'.....'}' : '',
                          style: const TextStyle(
                              fontSize: 16), // Adjust font size as needed
                        ),
                      ),
                      SizedBox(
                        height: GlobalSizes.getDeviceHeight(context) * 0.003,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: GlobalSizes.getDeviceHeight(context) * 0.023),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    storeSubCategory,
                                    style: TextStyles.openSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(" | ",
                                      style: TextStyles.openSans(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400)),
                                  Text(brands,
                                      style: TextStyles.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400))
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(
                              date,
                              style: TextStyles.openSans(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: GlobalSizes.getDeviceHeight(context) * 0.01,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: GlobalSizes.getDeviceHeight(context) * 0.0),
                    child: SizedBox(
                        height: 50.h,
                        width: 100.w,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EnlargedImageView(
                                    image: image, heroTag: 'heroTag'),
                              ),
                            );
                          },
                          child: Hero(
                            tag: 'heroTag',
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalSizes.getDeviceHeight(context) *
                                        0.025,
                              ),
                              child: SizedBox(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Adjust the value to make the image rectangular with rounded corners
                                  child:
                                      Image.network(image, fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                        )),
                  ),
                  Column(
                    children: [
                      Text(
                        modelNo == "" ? "--" : modelNo,
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                      Text(
                        "Model No",
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Image.asset("assest/bigLine.png"),
                  ),
                  Column(
                    children: [
                      Text(
                        Qty,
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                      Text(
                        "Qty",
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Image.asset("assest/bigLine.png"),
                  ),
                  Column(
                    children: [
                      Text(
                        size == '-1' ? "--" : size,
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                      Text(
                        "size",
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Image.asset("assest/bigLine.png"),
                  ),
                  Column(
                    children: [
                      Text(
                        units,
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                      Text(
                        "Units",
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: GlobalSizes.getDeviceHeight(context) * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: GlobalSizes.getDeviceHeight(context) * 0.025),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: text.length > 132 ? text.substring(0, 134) : text,
                        style: TextStyles.openSans(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      if (text.length > 130)
                        const TextSpan(
                          text: " more..",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffFC8019),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: GlobalSizes.getDeviceHeight(context) * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  "Product type you have",
                  style: TextStyles.openSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff4A4A4A)),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Obx(() => RadioListTile(
                          dense: true,
                          activeColor: const Color(0xffFC8019),
                          title: Text(
                            'Exact',
                            style: TextStyles.openSans(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          value: 'Exact',
                          groupValue: exactController.items[index],
                          onChanged: (value) {
                            exactController.isExact.value = true;
                            exactController.toShow.value = true;
                            exactController.changeSelectedOption(
                                option: value.toString(), index: index);
                          },
                        )),
                  ),
                  Flexible(
                    child: Obx(() => RadioListTile(
                          dense: true,
                          activeColor: const Color(0xffFC8019),
                          title: Text(
                            'Similar',
                            style: TextStyles.openSans(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          value: 'Similar',
                          groupValue: exactController.items[index],
                          onChanged: (value) {
                            exactController.isExact.value = false;
                            exactController.toShow.value = true;
                            exactController.changeSelectedOption(
                                option: value.toString(), index: index);
                          },
                        )),
                  ),
                ],
              ),
              Obx(() {
                return exactController.items[index] != ""
                    ? pickedImage.isEmpty
                        ? InkWell(
                            onTap: () async {
                              final result = await showDialog<String>(
                                context: context,
                                builder: (BuildContext context) {
                                  return const PickImageDialog(
                                    heading: 'upload image',
                                  );
                                },
                              );
                              if (result != null) {
                                pickedImage.add(result);
                              }
                            },
                            child: Center(
                              child: Container(
                                height: 100.h,
                                width: 130.w,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color(0xffC4C4C4), // Border color
                                    width: 1.0.w, // Border width
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      10.0.r), // Border radius
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.height *
                                          0.01),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      SvgPicture.asset(
                                        "assest/upload.svg",
                                        height: 20.h,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        "Upload Images",
                                        style: TextStyles.openSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11.sp,
                                            color: const Color(0xffFC8019)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Flexible(
                            child: Row(
                              children: [
                                Flexible(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: pickedImage.length,
                                    itemBuilder: (context, index) {
                                      return Stack(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.w),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: const Color(
                                                          0xff828282))),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    5.w, 5.h, 5.w, 5.h),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  height: 100.h,
                                                  width: 100.w,
                                                  child: Image.file(
                                                    File(pickedImage[index]),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 10,
                                            right: 10,
                                            child: InkWell(
                                              onTap: () {
                                                pickedImage
                                                    .remove(pickedImage[index]);
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Color(0xffFC8019),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    final result = await showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const PickImageDialog(
                                          heading: 'upload image',
                                        );
                                      },
                                    );
                                    if (result != null) {
                                      pickedImage.add(result);
                                    }
                                  },
                                  child: pickedImage.length >= 3
                                      ? const SizedBox()
                                      : Padding(
                                          padding: EdgeInsets.only(left: 10.w),
                                          child: Container(
                                            height: 100.h,
                                            width: 130.w,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: const Color(
                                                    0xffC4C4C4), // Border color
                                                width: 1.0.w, // Border width
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0.r), // Border radius
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                  SvgPicture.asset(
                                                    "assest/upload.svg",
                                                    height: 20.h,
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Text(
                                                    "Upload Images",
                                                    style: TextStyles.openSans(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 11.sp,
                                                        color: const Color(
                                                            0xffFC8019)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          )
                    : const SizedBox();
              }),
              SizedBox(
                height: 10.h,
              ),
              Obx(() {
                return exactController.items[index] != ""
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              elevation: WidgetStateProperty.all(
                                  0.0), // Remove elevation
                              side: WidgetStateProperty.all(const BorderSide(
                                width: 1.0,
                                color: Color(0xffC4C4C4),
                              )),
                              backgroundColor: WidgetStateProperty.all(
                                  Colors.transparent), // Transparent background
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      1.0), // Adjust radius as needed
                                ),
                              ),
                            ),
                            onPressed: () async {
                              try {
                                await restClient.rejectBySeller(storeId, {
                                  "Reject": 'true',
                                  "RequirementID": requirementId
                                });
                                await homeSellerController
                                    .fetchSellerData(storeId);
                              } catch (e) {
                                Fluttertoast.showToast(msg: "$e");
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Text(
                                "Reject",
                                style: TextStyles.openSans(
                                    color: const Color(0xff4A4A4A),
                                    fontSize: 14.sp),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              elevation: WidgetStateProperty.all(
                                  0.0), // Remove elevation
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      3.0), // Adjust radius as needed
                                ),
                              ),

                              backgroundColor: exactController.isExact.isTrue ||
                                      pickedImage.isNotEmpty
                                  ? WidgetStateProperty.all(
                                      const Color(0xffFC8019))
                                  : WidgetStateProperty.all(
                                      const Color(0xffFC8019).withOpacity(
                                          0.3)), // Transparent background
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  final List<String> dataImage =
                                      pickedImage.cast<String>();
                                  return AcceptDialodBox(
                                    isExact: exactController.isExact.value,
                                    imageList: dataImage,
                                    requiremetId: requirementId,
                                    fcm: FCM,
                                    storeId: storeId,
                                  );
                                },
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Text(
                                "Accept",
                                style: TextStyles.openSans(
                                    color: Colors.white, fontSize: 14.sp),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          )
                        ],
                      )
                    : const SizedBox();
              })
            ],
          ));
    });
  }
}

class EnlargedImageView extends StatefulWidget {
  final String image;
  final String heroTag;

  const EnlargedImageView(
      {super.key, required this.image, required this.heroTag});

  @override
  _EnlargedImageViewState createState() => _EnlargedImageViewState();
}

class _EnlargedImageViewState extends State<EnlargedImageView> {
  final TransformationController _controller = TransformationController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _resetZoom() {
    _controller.value = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GestureDetector(
            onTap: _resetZoom,
            child: Center(
              child: InteractiveViewer(
                transformationController: _controller,
                minScale: 0.5,
                maxScale: 4.0,
                child: Hero(
                  tag: widget.heroTag,
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.contain,
                    width: GlobalSizes.getDeviceWidth(context),
                    height: GlobalSizes.getDeviceHeight(context),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
