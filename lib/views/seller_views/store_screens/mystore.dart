import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

import '../../../controllers/myStoreAccountController.dart';
import '../../../controllers/myStoreController.dart';
import '../../../controllers/reviewsControllers.dart';
import '../../../utils/components/textstyle.dart';

class MyStore extends StatelessWidget {
  final StoreId;

  MyStore({super.key, required this.StoreId});

  final MyStoreCarouselController myStoreCarouselController =
      Get.put(MyStoreCarouselController());

  final List<String> imgList = [
    "assest/Rectangle 312.png",
    "assest/Rectangle 312.png",
    "assest/Rectangle 312.png",
    "assest/Rectangle 312.png",
    "assest/Rectangle 312.png"
  ];

  @override
  Widget build(BuildContext context) {
    final Mystoreaccountcontroller mystoreaccountcontroller =
        Get.put(Mystoreaccountcontroller(storeId: StoreId));
    final Reviewscontrollers reviewscontrollers =
        Get.put(Reviewscontrollers(StoreId));

    return mystoreaccountcontroller.isLoading.value
        ? Scaffold(
            body: Center(child: LottieBuilder.asset("assest/XyglI35BZO.json")),
          )
        : Scaffold(
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
                                  myStoreCarouselController.updateIndex(index);
                                },
                              ),
                              items: imgList.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Image.asset(
                                        i,
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
                                children: imgList.asMap().entries.map((entry) {
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
                                        child: Image.asset(
                                          "assest/books_round_big.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 0,
                                      child: Container(
                                        height: 24,
                                        width: 24,
                                        decoration: const BoxDecoration(
                                          color: Color(0xffFC8019),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          size: 16,
                                          color: Colors.white, // Icon color
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
                                        mystoreaccountcontroller.storeCategories
                                            .toString(),
                                        style: TextStyles.openSans(
                                            color: const Color(0xff4A4A4A),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(right: 20.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text("4.7 (5)"),
                                      RatingBar(
                                        itemSize: 12,
                                        initialRating: 4,
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
                                            constraints: const BoxConstraints(
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
                                            constraints: const BoxConstraints(
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
                                        itemPadding: const EdgeInsets.symmetric(
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
                                            dividerColor: Colors.transparent,
                                          ),
                                          child: ExpansionTile(
                                            leading:
                                                Image.asset("assest/clock.png"),
                                            title: const Row(
                                              children: [
                                                Text(
                                                  "Open now",
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                ),
                                                Text(
                                                  " - 7am - 9:30pm",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 65.w),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Mon",
                                                      style: TextStyles.openSans(
                                                          color: const Color(
                                                              0xff4A4A4A),
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      width: 30.w,
                                                    ),
                                                    Text(
                                                      "${mystoreaccountcontroller.mondayOpen} - ${mystoreaccountcontroller.mondayClose}",
                                                      style: TextStyles.openSans(
                                                          color: const Color(
                                                              0xff4A4A4A),
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              dayTile(
                                                  title: 'Tue',
                                                  openTime:
                                                      mystoreaccountcontroller
                                                          .tuesdayOpen,
                                                  closeTime:
                                                      mystoreaccountcontroller
                                                          .tuesdayClose),
                                              dayTile(
                                                  title: 'Thu',
                                                  openTime:
                                                      mystoreaccountcontroller
                                                          .thursdayOpen,
                                                  closeTime:
                                                      mystoreaccountcontroller
                                                          .thursdayClose),
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
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 2.w),
                                                  child: dayTile(
                                                      title: 'Fri',
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
                                                      title: 'sat',
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
                                                      title: 'Sun',
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
                                      Image.asset("assest/loaction.png"),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Text(
                                          mystoreaccountcontroller.storeAddress,
                                          style: TextStyles.openSans(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400)),
                                      const Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(right: 10.w),
                                        child:
                                            Image.asset("assest/small_map.png"),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assest/phone-call_grey.png",
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                ? const Center(
                                    child: Text(
                                        "No reviews available, be first to post review"),
                                  )
                                : SizedBox(
                                    height: 300,
                                    child: ListView.builder(
                                        itemCount:
                                            reviewscontrollers.reviews.length,
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
                                                                FontWeight.w400,
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
                                                                FontWeight.w400,
                                                            fontSize: 14.sp,
                                                            color: const Color(
                                                                0xff4A4A4A)),
                                                      ),
                                                    ),
                                                  ),
                                                  RatingBar(
                                                    itemSize: 12,
                                                    initialRating: double.parse(
                                                        reviewscontrollers
                                                            .reviews[index]
                                                            .rating),
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    ratingWidget: RatingWidget(
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
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 4.0),
                                                    onRatingUpdate: (rating) {
                                                      print(rating);
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.w),
                                                child: Text(
                                                  '''
${reviewscontrollers.reviews[index].description}
                                                    ''',
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyles.openSans(
                                                      color: const Color(
                                                        0xff636363,
                                                      ),
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
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
          );
  }

  Padding dayTile(
      {required String title,
      required String openTime,
      required String closeTime}) {
    return Padding(
      padding: EdgeInsets.only(left: 65.w),
      child: Row(
        children: [
          Text(
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
