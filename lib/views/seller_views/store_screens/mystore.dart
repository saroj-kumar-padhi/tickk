import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/myStoreController.dart';
import '../../../utils/components/textstyle.dart';
import '../../../utils/routes/routes_names.dart';

class MyStore extends StatelessWidget {
  MyStore({super.key});

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
    return Scaffold(
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "The Big Bookstore",
                                  style: TextStyles.openSans(
                                      color: const Color(0xff4A4A4A),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Book store",
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
                      Padding(
                        padding: EdgeInsets.only(left: 60.w),
                        child: ElevatedButton(
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
                          onPressed: () {
                            Get.toNamed(RouteName.storeEditScreen);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                              "Manage Account",
                              style: TextStyles.openSans(
                                  color: const Color(0xff4A4A4A),
                                  fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Divider(),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Row(
                          children: [
                            Image.asset(
                              "assest/bus_tracking.png",
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text("Home delivery Available",
                                style: TextStyles.openSans(
                                    color: const Color(0xff4A4A4A),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50.w),
                        child: Text("Approximate delivery time : 1-3 days",
                            style: TextStyles.openSans(
                                color: const Color(0xff4A4A4A),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400)),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
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
                                      leading: Image.asset("assest/clock.png"),
                                      title: const Row(
                                        children: [
                                          Text(
                                            "Open now",
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                          Text(
                                            " - 7am - 9:30pm",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 65.w),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Mon",
                                                style: TextStyles.openSans(
                                                    color:
                                                        const Color(0xff4A4A4A),
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                width: 30.w,
                                              ),
                                              Text(
                                                "7:00am - 9:30pm",
                                                style: TextStyles.openSans(
                                                    color:
                                                        const Color(0xff4A4A4A),
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        dayTile(title: 'Tue'),
                                        dayTile(title: 'Thu'),
                                        Padding(
                                          padding: EdgeInsets.only(left: 60.w),
                                          child: Row(
                                            children: [
                                              Text(
                                                "wed",
                                                style: TextStyles.openSans(
                                                    color:
                                                        const Color(0xffC11F1F),
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              SizedBox(
                                                width: 35.w,
                                              ),
                                              Text(
                                                "7:00am - 9:30pm",
                                                style: TextStyles.openSans(
                                                    color:
                                                        const Color(0xffC11F1F),
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(
                                                "close",
                                                style: TextStyles.openSans(
                                                    color:
                                                        const Color(0xffC11F1F),
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 2.w),
                                            child: dayTile(title: 'Fri')),
                                        Padding(
                                            padding: EdgeInsets.only(left: 2.w),
                                            child: dayTile(title: 'sat')),
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
                                    "M.G.Railway Colony,\n South Street ,11073",
                                    style: TextStyles.openSans(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400)),
                                const Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: Image.asset("assest/small_map.png"),
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
                                  "+915346238648",
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
                              fontWeight: FontWeight.w600, fontSize: 16.sp),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '''
                      We have selling books custoners for the past 2 years and have sold v 1 million copies. We have great collection of books which includes all genres..more
                      ''',
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
                              fontWeight: FontWeight.w600, fontSize: 16.sp),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Column(
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
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.sp,
                                        color: const Color(0xff4A4A4A)),
                                  ),
                                  trailing:
                                      const Flexible(child: Text("4.7 (5)")),
                                  title: Text(
                                    "Camelio",
                                    style: TextStyles.openSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: const Color(0xff4A4A4A)),
                                  ),
                                ),
                              ),
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
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                              '''
                      I read it 451 over ten years ago in my early teens. At the time, I remember really wanting to read 1984, although I never managed to get my hands on it.
                      ''',
                              textAlign: TextAlign.justify,
                              style: TextStyles.openSans(
                                  color: const Color(
                                    0xff636363,
                                  ),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),

                          //second review

                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        child: Image.asset("assest/kane.png"),
                                      ),
                                      subtitle: Text(
                                        "05 Sep 2021",
                                        style: TextStyles.openSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10.sp,
                                            color: const Color(0xff4A4A4A)),
                                      ),
                                      trailing: const Flexible(
                                          child: Text("4.7 (5)")),
                                      title: Text(
                                        "Camelio",
                                        style: TextStyles.openSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp,
                                            color: const Color(0xff4A4A4A)),
                                      ),
                                    ),
                                  ),
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
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Text(
                                  '''
                      I read it 451 over ten years ago in my early teens. At the time, I remember really wanting to read 1984, although I never managed to get my hands on it.
                      ''',
                                  textAlign: TextAlign.justify,
                                  style: TextStyles.openSans(
                                      color: const Color(
                                        0xff636363,
                                      ),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("Show More",
                                      style: TextStyles.openSans(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xffFC8019))),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50.h,
              child: Row(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: SvgPicture.asset("assest/selling_orange.svg")),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouteName.homeBuyerScreen);
                    },
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: SvgPicture.asset("assest/buying_white.svg")),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding dayTile({required String title}) {
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
            "7:00am - 9:30pm",
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
