import 'package:carousel_slider/carousel_slider.dart';
import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:dekhlo/views/seller_views/seller_home_screens/storeEditScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controllers/myStoreAccountController.dart';
import '../../../controllers/myStoreController.dart';
import '../../../controllers/productSetupController.dart';
import '../../../controllers/reviewsControllers.dart';
import '../../../utils/components/textstyle.dart';

class MyStore extends StatelessWidget {
  final String StoreId;
  final bool isFromSeller;

  MyStore({super.key, required this.StoreId, this.isFromSeller = false});

  final MyStoreCarouselController myStoreCarouselController =
      Get.put(MyStoreCarouselController());

  @override
  Widget build(BuildContext context) {
    final Mystoreaccountcontroller mystoreaccountcontroller =
        Get.put(Mystoreaccountcontroller(storeId: StoreId));
    final Reviewscontrollers reviewscontrollers =
        Get.put(Reviewscontrollers(StoreId));

    return Obx(() => mystoreaccountcontroller.isLoading.value
        ? Scaffold(
            body: Center(child: LottieBuilder.asset("assest/mX2qe5gUvP.json")),
          )
        : Scaffold(
            body: Animate(
              effects: [
                SlideEffect(
                    begin: const Offset(1, 0), // Start from bottom
                    end: const Offset(0, 0), // End at normal position
                    duration: 500.ms, // Animation duration
                    curve: Curves.easeOut // Animation curve
                    ),
              ],
              child: Scaffold(
                appBar: AppBar(
                  elevation: 1,
                  shadowColor: Colors.black,
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xff4A4A4A),
                    ),
                  ),
                  title: Text(
                    "My store",
                    style: TextStyles.openSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 17.sp,
                      color: const Color(0xff4A4A4A),
                    ),
                  ),
                ),
                body: SafeArea(
                  child: Column(
                    children: [
                      Flexible(
                        child: ListView(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CarouselSlider(
                                  options: CarouselOptions(
                                    height: 200.0,
                                    viewportFraction: 1,
                                    onPageChanged: (index, reason) {
                                      myStoreCarouselController
                                          .updateIndex(index);
                                    },
                                  ),
                                  items: mystoreaccountcontroller.storeImages
                                      .map((imageUrl) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Image.network(
                                            imageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                                Obx(() {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: mystoreaccountcontroller
                                        .storeImages
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      return GestureDetector(
                                        onTap: () => myStoreCarouselController
                                            .updateIndex(entry.key),
                                        child: Container(
                                          width: 10.0.w,
                                          height: 10.0.h,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 2.0),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: (myStoreCarouselController
                                                          .currentIndex.value ==
                                                      entry.key
                                                  ? const Color(0xffFC8019)
                                                  : const Color(0xffC4C4C4))),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                }),
                                Row(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: ClipOval(
                                            child: Image.network(
                                              mystoreaccountcontroller
                                                  .staredImage,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            mystoreaccountcontroller.storeName,
                                            style: TextStyles.openSans(
                                                color: const Color(0xff4A4A4A),
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            mystoreaccountcontroller
                                                .storeCategories
                                                .toString(),
                                            style: TextStyles.openSans(
                                                color: const Color(0xff4A4A4A),
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          isFromSeller
                                              ? OutlinedButton(
                                                  onPressed: () {
                                                    Logger().f("jlknjlk");
                                                    Logger().f(
                                                        mystoreaccountcontroller
                                                            .staredImage);

                                                    int staredImageIndex =
                                                        mystoreaccountcontroller
                                                            .storeImages
                                                            .indexOf(
                                                                mystoreaccountcontroller
                                                                    .staredImage);

                                                    ProductSetUpController
                                                        productSetUpController =
                                                        Get.put(
                                                            ProductSetUpController());
                                                    productSetUpController
                                                            .staredImageIndex =
                                                        staredImageIndex.obs;
                                                    Get.to(
                                                        () => StoreEditScreen(
                                                              storeName:
                                                                  mystoreaccountcontroller
                                                                      .storeName,
                                                              storeCategory:
                                                                  mystoreaccountcontroller
                                                                      .storeCategories,
                                                              storeSubcategory:
                                                                  mystoreaccountcontroller
                                                                      .storeSubCategory,
                                                              about:
                                                                  mystoreaccountcontroller
                                                                      .about,
                                                              yt: mystoreaccountcontroller
                                                                  .yt,
                                                              iG: mystoreaccountcontroller
                                                                  .iG,
                                                              webSite:
                                                                  mystoreaccountcontroller
                                                                      .wL,
                                                              houseNo:
                                                                  mystoreaccountcontroller
                                                                      .houseNoBuildingName,
                                                              pincode:
                                                                  mystoreaccountcontroller
                                                                      .pinCode
                                                                      .toString(),
                                                              city: "Hyderabad",
                                                              yourStoreLoaction:
                                                                  mystoreaccountcontroller
                                                                      .storeAddress,
                                                              area: mystoreaccountcontroller
                                                                  .streetController,
                                                              brands: mystoreaccountcontroller
                                                                      .brands ??
                                                                  [],
                                                              sundayOpentime:
                                                                  mystoreaccountcontroller
                                                                      .sundayOpen,
                                                              sundayClosetime:
                                                                  mystoreaccountcontroller
                                                                      .sundayClose,
                                                              mondayOpentime:
                                                                  mystoreaccountcontroller
                                                                      .mondayOpen,
                                                              mondayClosetime:
                                                                  mystoreaccountcontroller
                                                                      .mondayClose,
                                                              tuesdayOpentime:
                                                                  mystoreaccountcontroller
                                                                      .tuesdayOpen,
                                                              tuesdayClosetime:
                                                                  mystoreaccountcontroller
                                                                      .tuesdayClose,
                                                              wednesdayOpentime:
                                                                  mystoreaccountcontroller
                                                                      .wednesdayOpen,
                                                              wednesdayClosetime:
                                                                  mystoreaccountcontroller
                                                                      .wednesdayClose,
                                                              thursdayOpentime:
                                                                  mystoreaccountcontroller
                                                                      .thursdayOpen,
                                                              thursdayClosetime:
                                                                  mystoreaccountcontroller
                                                                      .thursdayClose,
                                                              fridayOpentime:
                                                                  mystoreaccountcontroller
                                                                      .fridayOpen,
                                                              fridayClosetime:
                                                                  mystoreaccountcontroller
                                                                      .fridayClose,
                                                              saturdayOpentime:
                                                                  mystoreaccountcontroller
                                                                      .saturdayOpen,
                                                              saturdayClosetime:
                                                                  mystoreaccountcontroller
                                                                      .saturdayClose,
                                                              storeID: StoreId,
                                                              stared:
                                                                  mystoreaccountcontroller
                                                                      .staredImage,
                                                              imageList:
                                                                  mystoreaccountcontroller
                                                                      .storeImages,
                                                              lat: mystoreaccountcontroller
                                                                  .sellerLocation
                                                                  .latitude,
                                                              long: mystoreaccountcontroller
                                                                  .sellerLocation
                                                                  .longitude,
                                                              staredImageIndex:
                                                                  staredImageIndex
                                                                      .obs,
                                                            ));
                                                  },
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    foregroundColor: const Color(
                                                        0xff4A4A4A), // Text Color
                                                    side: const BorderSide(
                                                        color: Color(
                                                            0xffDADADA)), // Border Color
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(4
                                                              .r), // Rounded Corners
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15,
                                                        vertical:
                                                            10), // Button Padding
                                                  ),
                                                  child: const Text(
                                                    'Manage Account',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              "${reviewscontrollers.ratingResponse.averageRating} (${reviewscontrollers.ratingResponse.ratingCount})"),
                                          RatingBar(
                                            ignoreGestures: true,
                                            itemSize: 12,
                                            initialRating: reviewscontrollers
                                                .ratingResponse.averageRating,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            ratingWidget: RatingWidget(
                                              full: Container(
                                                constraints: BoxConstraints(
                                                  maxHeight: 4.0
                                                      .h, // Adjust the max height as needed
                                                  maxWidth: 4.0
                                                      .w, // Adjust the max width as needed
                                                ),
                                                child: Image.asset(
                                                  'assest/small_star.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              empty: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  maxHeight:
                                                      4.0, // Adjust the max height as needed
                                                  maxWidth:
                                                      4.0, // Adjust the max width as needed
                                                ),
                                                child: Image.asset(
                                                  'assest/emptyStar.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              half: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  maxHeight:
                                                      4.0, // Adjust the max height as needed
                                                  maxWidth:
                                                      4.0, // Adjust the max width as needed
                                                ),
                                                child: Image.asset(
                                                  'assest/small_star.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Theme(
                                              data: Theme.of(context).copyWith(
                                                dividerColor:
                                                    Colors.transparent,
                                              ),
                                              child: ExpansionTile(
                                                leading: Image.asset(
                                                    "assest/clock.png"),
                                                title: Row(
                                                  children: [
                                                    Text(
                                                      mystoreaccountcontroller
                                                              .isCurrentlyOpen()
                                                          ? "Open now"
                                                          : "Closed",
                                                      style: TextStyle(
                                                        color: mystoreaccountcontroller
                                                                .isCurrentlyOpen()
                                                            ? Colors.green
                                                            : Colors.red,
                                                      ),
                                                    ),
                                                    Text(
                                                      " - ${mystoreaccountcontroller.getCurrentDayTiming()}",
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                                children: [
                                                  dayTile(
                                                      title: 'Mon',
                                                      openTime:
                                                          mystoreaccountcontroller
                                                              .tuesdayOpen,
                                                      closeTime:
                                                          mystoreaccountcontroller
                                                              .tuesdayClose),
                                                  dayTile(
                                                      title: 'Tue ',
                                                      openTime:
                                                          mystoreaccountcontroller
                                                              .tuesdayOpen,
                                                      closeTime:
                                                          mystoreaccountcontroller
                                                              .tuesdayClose),
                                                  Row(
                                                    children: [
                                                      dayTile(
                                                          title: 'Wed',
                                                          openTime:
                                                              mystoreaccountcontroller
                                                                  .wednesdayOpen,
                                                          closeTime:
                                                              mystoreaccountcontroller
                                                                  .wednesdayClose),
                                                      SizedBox(
                                                        width: 35.w,
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                    ],
                                                  ),
                                                  dayTile(
                                                      title: 'Thu ',
                                                      openTime:
                                                          mystoreaccountcontroller
                                                              .thursdayOpen,
                                                      closeTime:
                                                          mystoreaccountcontroller
                                                              .thursdayClose),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2.w),
                                                      child: dayTile(
                                                          title: 'Fri   ',
                                                          openTime:
                                                              mystoreaccountcontroller
                                                                  .fridayOpen,
                                                          closeTime:
                                                              mystoreaccountcontroller
                                                                  .fridayClose)),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2.w),
                                                      child: dayTile(
                                                          title: 'Sat  ',
                                                          openTime:
                                                              mystoreaccountcontroller
                                                                  .saturdayOpen,
                                                          closeTime:
                                                              mystoreaccountcontroller
                                                                  .saturdayClose)),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2.w),
                                                      child: dayTile(
                                                          title: 'Sun ',
                                                          openTime:
                                                              mystoreaccountcontroller
                                                                  .sundayOpen,
                                                          closeTime:
                                                              mystoreaccountcontroller
                                                                  .sundayOpen)),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.w),
                                            child: Image.asset(
                                                "assest/loaction.png"),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${mystoreaccountcontroller.houseNoBuildingName},${mystoreaccountcontroller.pinCode},${mystoreaccountcontroller.streetController}",
                                              style: TextStyles.openSans(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              maxLines: null,
                                              overflow: TextOverflow.visible,
                                            ),
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.w),
                                            child: InkWell(
                                              onTap: () async {
                                                final controller = Get.find<
                                                    Mystoreaccountcontroller>();
                                                final lat = controller
                                                    .sellerLocation.latitude;
                                                final lng = controller
                                                    .sellerLocation.longitude;
                                                final url =
                                                    'https://www.google.com/maps/search/?api=1&query=$lat,$lng';

                                                if (await canLaunch(url)) {
                                                  await launch(url);
                                                } else {
                                                  // Handle the error, maybe show a snackbar
                                                  Get.snackbar('Error',
                                                      'Could not open map');
                                                }
                                              },
                                              child: Image.asset(
                                                  "assest/small_map.png"),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 15.w),
                                            child: Image.asset(
                                              "assest/phone-call_grey.png",
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Text(
                                            mystoreaccountcontroller.mobile,
                                            style: TextStyles.openSans(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      const Divider()
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20.w),
                                  child: Text(
                                    "About",
                                    style: TextStyles.openSans(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    mystoreaccountcontroller.about,
                                    textAlign: TextAlign.justify,
                                    style: TextStyles.openSans(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp,
                                        color: const Color(0xff4A4A4A)),
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: EdgeInsets.only(left: 20.w),
                                  child: Text(
                                    "Reviews",
                                    style: TextStyles.openSans(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Obx(() => reviewscontrollers.reviews.isEmpty
                                    ? Center(
                                        child: isFromSeller
                                            ? const Text(
                                                "No reviews for your store yet.")
                                            : const Text(
                                                "This is only come in seller side store details page."))
                                    : SizedBox(
                                        height: 300,
                                        child: ListView.builder(
                                            itemCount: reviewscontrollers
                                                .reviews.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: ListTile(
                                                          leading: CircleAvatar(
                                                            child: Image.asset(
                                                                "assest/camilo_profile.png"),
                                                          ),
                                                          subtitle: Text(
                                                            "05 Sep 2021",
                                                            style: TextStyles.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 10.sp,
                                                                color: const Color(
                                                                    0xff4A4A4A)),
                                                          ),
                                                          trailing: Flexible(
                                                              child: Text(
                                                                  reviewscontrollers
                                                                      .reviews[
                                                                          index]
                                                                      .rating)),
                                                          title: Text(
                                                            reviewscontrollers
                                                                .reviews[index]
                                                                .yourName,
                                                            style: TextStyles.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14.sp,
                                                                color: const Color(
                                                                    0xff4A4A4A)),
                                                          ),
                                                        ),
                                                      ),
                                                      RatingBar(
                                                        itemSize: 12,
                                                        initialRating:
                                                            double.parse(
                                                                reviewscontrollers
                                                                    .reviews[
                                                                        index]
                                                                    .rating),
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        ratingWidget:
                                                            RatingWidget(
                                                          full: Container(
                                                            constraints:
                                                                BoxConstraints(
                                                              maxHeight: 4.0
                                                                  .h, // Adjust the max height as needed
                                                              maxWidth: 4.0
                                                                  .w, // Adjust the max width as needed
                                                            ),
                                                            child: Image.asset(
                                                              'assest/small_star.png',
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                          empty: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              maxHeight:
                                                                  4.0, // Adjust the max height as needed
                                                              maxWidth:
                                                                  4.0, // Adjust the max width as needed
                                                            ),
                                                            child: Image.asset(
                                                              'assest/emptyStar.png',
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                          half: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              maxHeight:
                                                                  4.0, // Adjust the max height as needed
                                                              maxWidth:
                                                                  4.0, // Adjust the max width as needed
                                                            ),
                                                            child: Image.asset(
                                                              'assest/small_star.png',
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                        itemPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    4.0),
                                                        onRatingUpdate:
                                                            (rating) {
                                                          print(rating);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.w),
                                                    child: Text(
                                                      '''
            ${reviewscontrollers.reviews[index].description}
                                                        ''',
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style:
                                                          TextStyles.openSans(
                                                              color:
                                                                  const Color(
                                                                0xff636363,
                                                              ),
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                      ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
  }

  Padding dayTile(
      {required String title,
      required String openTime,
      required String closeTime}) {
    return Padding(
      padding: EdgeInsets.only(left: 65.w),
      child: Row(
        children: [
          title == "Wed"
              ? Text(
                  title,
                  style: TextStyles.openSans(
                      color: const Color(0xff4A4A4A),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400),
                )
              : Text(
                  title,
                  style: TextStyles.openSans(
                      color: const Color(0xff4A4A4A),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                ),
          SizedBox(
            width: 35.w,
          ),
          Text(
            "$openTime - $closeTime",
            style: TextStyles.openSans(
                color: const Color(0xff4A4A4A),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
