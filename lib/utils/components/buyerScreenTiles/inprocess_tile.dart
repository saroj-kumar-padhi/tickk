import 'package:dekhlo/controllers/inprocessController.dart';
import 'package:dekhlo/models/userFcmModel.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:dekhlo/utils/components/buttons.dart';
import 'package:dekhlo/views/seller_views/store_screens/mystore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import '../../../controllers/buyerInprocessController.dart';
import '../../../controllers/expandController.dart';
import '../../../controllers/myStoreAccountController.dart';
import '../../../controllers/sortDialogBoxController.dart';
import '../../../services/notificationServices.dart';
import '../../../views/buyer_view/home_screen_buyer.dart/tabs/rejected_tab.dart';
import '../../size/global_size/global_size.dart';
import '../bottomSheets/sort.dart';
import '../dialog_boxs/coursal_dialog.dart';
import '../sellerScreenTiles/newSellerTile.dart';
import '../textstyle.dart';
import 'package:intl/intl.dart';

class InprocessTile extends StatelessWidget {
  final String mobile;
  final String requirementId;
  final String requirementImge;
  final String catagory;
  final String subCategory;
  final String brands;
  final String modelNo;
  final String oty;
  final String size;
  final String units;
  final String des;
  final String date;
  final List stores;
  final String image;
  const InprocessTile(
      {super.key,
      required this.requirementId,
      required this.catagory,
      required this.subCategory,
      required this.brands,
      required this.modelNo,
      required this.oty,
      required this.size,
      required this.units,
      required this.des,
      required this.date,
      required this.stores,
      required this.mobile,
      required this.requirementImge,
      required this.image});

  @override
  Widget build(BuildContext context) {
    final ExpandController expandController = Get.put(ExpandController());
    final Mystoreaccountcontroller mystoreaccountcontroller =
        Get.put(Mystoreaccountcontroller(storeId: ''));
    final InProcessController inProcessController =
        Get.put(InProcessController());
    final DialogBoxController dialogBoxController =
        Get.put(DialogBoxController());
    DateTime dateTime = DateTime.parse(date);
    String dateOnly = DateFormat('yyyy-MM-dd').format(dateTime);

    String text = des;
    return SizedBox(child: Obx(() {
      return Container(
          width: double.infinity, // Adjust the width as needed
          height: expandController.isExpanded.value
              ? stores.length == 1
                  ? 250
                  : stores.length == 2
                      ? 300
                      : 386.h
              : 225.h, // Adjust the height as needed
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
                4.r), // Adjust the border radius for a squared shape
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2.r,
                blurRadius: 5.r,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.w),
                child: Text(
                  "Requirement ID #$requirementId",
                  style: TextStyles.openSans(
                      fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          subCategory,
                          style: TextStyles.openSans(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                        Text(" | ",
                            style: TextStyles.openSans(
                                fontSize: 12.sp, fontWeight: FontWeight.w400)),
                        Text(brands,
                            style: TextStyles.openSans(
                                fontSize: 12.sp, fontWeight: FontWeight.w400))
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.h),
                      child: Text(
                        dateOnly,
                        style: TextStyles.openSans(
                            fontSize: 12.sp, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                children: [
                  SizedBox(
                      width: 100.w,
                      height: 50.h,
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
                                  GlobalSizes.getDeviceHeight(context) * 0.025,
                            ),
                            child: SizedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Adjust the value to make the image rectangular with rounded corners
                                child: Image.network(image, fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                      )),
                  Column(
                    children: [
                      Text(
                        "#$modelNo",
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w600, fontSize: 12.sp),
                      ),
                      Text(
                        "Model No",
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w400, fontSize: 12.sp),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: Image.asset("assest/bigLine.png"),
                  ),
                  Column(
                    children: [
                      Text(
                        oty,
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w600, fontSize: 12.sp),
                      ),
                      Text(
                        "Qty",
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w400, fontSize: 12.sp),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 9.h),
                    child: Image.asset("assest/bigLine.png"),
                  ),
                  Column(
                    children: [
                      Text(
                        size,
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w600, fontSize: 12.sp),
                      ),
                      Text(
                        "size",
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w400, fontSize: 12.sp),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 9.h),
                    child: Image.asset("assest/bigLine.png"),
                  ),
                  Column(
                    children: [
                      Text(
                        units,
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w600, fontSize: 12.sp),
                      ),
                      Text(
                        "Units",
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w400, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: text.length > 132 ? text.substring(0, 134) : text,
                        style: TextStyles.openSans(
                          color: Colors.black,
                          fontSize: 13.sp,
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
                height: 1.h,
              ),
              Obx(() {
                return Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 6.h, 14.w, 6.h),
                  child: Container(
                    height: expandController.isExpanded.value
                        ? stores.length == 1
                            ? 100
                            : stores.length == 2
                                ? 160
                                : 210.h
                        : 33.h,
                    width: 309.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffFFC18E)),
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        color: const Color(0xffFFF5ED)),
                    child: expandController.isExpanded.value
                        ? Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10.h, 0, 5.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            dialogBoxController
                                                .selectedTab.value = 0;
                                            sortDialogBox(
                                              context: context,
                                              mobileNumber: mobile,
                                              requiestId: requirementId,
                                            );
                                          },
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 25.w),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5),
                                                  child: Image.asset(
                                                      "assest/hamburger.png"),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(
                                                  "Sort by Distance/Price",
                                                  style: TextStyles.openSans(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12.sp,
                                                      color: const Color(
                                                          0xffFC8019)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 11.w),
                                          child: Text(
                                            "Requests (${stores.length})",
                                            style: TextStyles.openSans(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 11.5.sp,
                                            ),
                                          ),
                                        ),
                                        expandController.isExpanded.value
                                            ? InkWell(
                                                onTap: () {
                                                  expandController
                                                          .isExpanded.value =
                                                      !expandController
                                                          .isExpanded.value;
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 4.w),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.sp),
                                                    child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Color(
                                                                    0xffFC8019)),
                                                        child: Icon(
                                                          Icons.expand_more,
                                                          size: 15.sp,
                                                          color: Colors.white,
                                                        )),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: stores.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            10.w, 0.h, 8.w, 5.h),
                                        child: Container(
                                          height: 55.h,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffFFFFFF),
                                            borderRadius: BorderRadius.circular(
                                                4.0.r), // Adjust the value as needed
                                          ),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 3.w,
                                                            vertical: 2.h),
                                                    child: Row(
                                                      children: [
                                                        ClipOval(
                                                          child: SizedBox(
                                                            width: 25
                                                                .w, // Adjust size as needed
                                                            height: 20
                                                                .h, // Adjust size as needed
                                                            child:
                                                                Image.network(
                                                              stores[index]
                                                                  .stared,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            await mystoreaccountcontroller
                                                                .fetchStoreDetails(
                                                                    stores[index]
                                                                        .storeID);
                                                            Get.to(MyStore(
                                                                StoreId: stores[
                                                                        index]
                                                                    .storeID));
                                                          },
                                                          child: Text(
                                                            stores[index]
                                                                .storeName,
                                                            style: TextStyles
                                                                .openSansUnderLine(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: GlobalSizes
                                                                  .getDeviceWidth(
                                                                      context) *
                                                              0.03,
                                                        ),
                                                        FutureBuilder<
                                                            Map<String,
                                                                dynamic>>(
                                                          future: inProcessController
                                                              .fetchStoreRating(
                                                                  stores[index]
                                                                      .storeID),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return const CircularProgressIndicator();
                                                            } else if (snapshot
                                                                .hasError) {
                                                              return Text(
                                                                  'Error: ${snapshot.error}');
                                                            } else if (snapshot
                                                                .hasData) {
                                                              final rating =
                                                                  snapshot
                                                                      .data!;
                                                              return rating['averageRating'] ==
                                                                          "0" ||
                                                                      rating['averageRating'] ==
                                                                          0
                                                                  ? const Text(
                                                                      "_")
                                                                  : Text(
                                                                      "${rating['averageRating'].toStringAsFixed(1)} (${rating['ratingCount']})",
                                                                      style: TextStyles.openSans(
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              12),
                                                                    );
                                                            } else {
                                                              return const Text(
                                                                  'No data');
                                                            }
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 6.w,
                                                        ),
                                                        SizedBox(
                                                          width: 1.w,
                                                        ),
                                                        stores[index]
                                                                    .totalDiatance ==
                                                                '0'
                                                            ? const SizedBox()
                                                            : Text(
                                                                stores[index]
                                                                    .totalDiatance,
                                                                style: GoogleFonts
                                                                    .openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 2.w),
                                                          child: Text(
                                                            "KM",
                                                            style: GoogleFonts
                                                                .openSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        // Text(
                                                        //   "away",
                                                        //   style: GoogleFonts
                                                        //       .openSans(
                                                        //     fontWeight:
                                                        //         FontWeight.w400,
                                                        //     fontSize: 12,
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 2.w),
                                                    child: Row(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                                "₹ ${stores[index].quote}",
                                                                style: TextStyles.openSans(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: const Color(
                                                                        0xffFC8019))),
                                                            Text("Quotation",
                                                                style: TextStyles.openSans(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: const Color(
                                                                        0xfff4a4a4a))),
                                                          ],
                                                        ),
                                                        Image.asset(
                                                          "assest/bigLine.png",
                                                          height: GlobalSizes
                                                                  .getDeviceHeight(
                                                                      context) *
                                                              0.02,
                                                          width: GlobalSizes
                                                                  .getDeviceWidth(
                                                                      context) *
                                                              0.03,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                                stores[index].similar ==
                                                                        true
                                                                    ? "Similar"
                                                                    : "Exact",
                                                                style: TextStyles.openSans(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: const Color(
                                                                        0xffFC8019))),
                                                            Text("Product Type",
                                                                style: TextStyles.openSans(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: const Color(
                                                                        0xfff4a4a4a))),
                                                          ],
                                                        ),
                                                        Image.asset(
                                                          "assest/bigLine.png",
                                                          height: GlobalSizes
                                                                  .getDeviceHeight(
                                                                      context) *
                                                              0.02,
                                                          width: GlobalSizes
                                                                  .getDeviceWidth(
                                                                      context) *
                                                              0.03,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      right: GlobalSizes.getDeviceWidth(
                                                                              context) *
                                                                          0.01),
                                                                  child: SizedBox(
                                                                      height: 10.h,
                                                                      child: Image.asset(
                                                                        "assest/image_view.png",
                                                                        fit: BoxFit
                                                                            .fitHeight,
                                                                      )),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return CarouselDialog(
                                                                          images:
                                                                              stores[index].ExactSimilarImage,
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                  child: Text(
                                                                      "View",
                                                                      style: TextStyles.openSans(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              const Color(0xffFC8019))),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                                "Product Image",
                                                                style: TextStyles.openSans(
                                                                    fontSize:
                                                                        10.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: const Color(
                                                                        0xfff4a4a4a))),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 6.w,
                                                        ),
                                                        Obx(() {
                                                          final inProcessController =
                                                              Get.find<
                                                                  InProcessController>();
                                                          final buyerinprocesscontroller =
                                                              Get.find<
                                                                  Buyerinprocesscontroller>();

                                                          // Fetch the acceptance status only once
                                                          inProcessController
                                                              .fetchIsAccepted(
                                                                  reqId:
                                                                      requirementId,
                                                                  storeId: stores[
                                                                          index]
                                                                      .storeID);

                                                          // Get the response for this specific store
                                                          final documentResponse =
                                                              inProcessController
                                                                      .documentResponses[
                                                                  stores[index]
                                                                      .storeID];

                                                          if (documentResponse
                                                                  ?.message ==
                                                              "Document found") {
                                                            // Show "Deal Done" and "Call" buttons
                                                            return Row(
                                                              children: [
                                                                Buttons
                                                                    .smallDealDoneButton(
                                                                  RequrementId:
                                                                      requirementId,
                                                                  storeId: stores[
                                                                          index]
                                                                      .storeID,
                                                                  buyerinprocesscontroller:
                                                                      buyerinprocesscontroller,
                                                                  mobile:
                                                                      mobile,
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Buttons
                                                                    .smallCallButton(
                                                                  buttonText:
                                                                      'Call',
                                                                  onPressed:
                                                                      () {
                                                                    String
                                                                        phone =
                                                                        stores[index]
                                                                            .mobile;
                                                                    FlutterPhoneDirectCaller
                                                                        .callNumber(
                                                                            '+91$phone');
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          } else {
                                                            // Show check and cross buttons
                                                            return Row(
                                                              children: [
                                                                InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    try {
                                                                      // await restClient.moveToAccepet(
                                                                      //     requirementId,
                                                                      //     stores[index].storeID,
                                                                      //     {
                                                                      //       "Accept":
                                                                      //           true
                                                                      //     });
                                                                      // // Update the local state after successful API call
                                                                      // inProcessController
                                                                      //         .documentResponses[
                                                                      //     stores[index]
                                                                      //         .storeID] = DocumentResponse(
                                                                      //     message:
                                                                      //         "Document found");

                                                                      try {
                                                                        UserFcmToken
                                                                            userFcmToken =
                                                                            UserFcmToken(fcm: "");
                                                                        try {
                                                                          userFcmToken =
                                                                              await restClient.fetchUserFcmbyreqId(
                                                                            requirementId,
                                                                          );
                                                                        } catch (e) {
                                                                          Logger()
                                                                              .e(e);
                                                                        }
                                                                        PushNotificationServices.sendNotificationToOne(
                                                                            userFcmToken.fcm,
                                                                            context,
                                                                            "Accepted",
                                                                            "Your quote is accepted. We wish this order will be successful");
                                                                      } catch (e) {
                                                                        Logger()
                                                                            .d(e);
                                                                      }
                                                                    } catch (e) {
                                                                      Fluttertoast
                                                                          .showToast(
                                                                              msg: "Unfortunately, can't move to seller accepted tab due to $e");
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration: const BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Color(
                                                                            0xffCEEDE3)),
                                                                    child: Icon(
                                                                      Icons
                                                                          .check,
                                                                      size:
                                                                          15.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    try {
                                                                      await restClient.rejectQuote(
                                                                          stores[index]
                                                                              .storeID,
                                                                          requirementId,
                                                                          {
                                                                            "Reject":
                                                                                true
                                                                          });
                                                                      Get.to(
                                                                          const RejectedTab());
                                                                    } catch (e) {
                                                                      Logger()
                                                                          .d(e);
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration: const BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Color(
                                                                            0xffFFEAEC)),
                                                                    child: Icon(
                                                                      Icons
                                                                          .close,
                                                                      size:
                                                                          15.sp,
                                                                      color: const Color(
                                                                          0xffBC0000),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          }
                                                        })
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          )
                        : Row(
                            children: [
                              Row(
                                children: [
                                  expandController.isExpanded.value
                                      ? Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                expandController
                                                        .isExpanded.value =
                                                    !expandController
                                                        .isExpanded.value;
                                                inProcessController.index
                                                    .clear();
                                              },
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 6.w),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 4.sp),
                                                  child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Color(
                                                                  0xffFC8019)),
                                                      child: Icon(
                                                        Icons.expand_less,
                                                        size: 15.sp,
                                                        color: Colors.white,
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : InkWell(
                                          onTap: () {
                                            expandController.isExpanded.value =
                                                !expandController
                                                    .isExpanded.value;
                                            inProcessController.index.clear();
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  dialogBoxController
                                                      .selectedTab.value = 0;
                                                  sortDialogBox(
                                                    context: context,
                                                    mobileNumber: mobile,
                                                    requiestId: requirementId,
                                                  );
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.w),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 0),
                                                        child: Image.asset(
                                                            "assest/hamburger.png"),
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Text(
                                                        "Sort by Distance/Price",
                                                        style: TextStyles.openSans(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12.sp,
                                                            color: const Color(
                                                                0xffFC8019)),
                                                      ),
                                                      SizedBox(
                                                        width: 30.w,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 11.w),
                                                child: Text(
                                                  "Requests (${stores.length})",
                                                  style: TextStyles.openSans(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 6.w),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 4.sp),
                                                  child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Color(
                                                                  0xffFC8019)),
                                                      child: Icon(
                                                        Icons.expand_less,
                                                        size: 15.sp,
                                                        color: Colors.white,
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            ],
                          ),
                  ),
                );
              })
            ],
          ));
    }));
  }
}
