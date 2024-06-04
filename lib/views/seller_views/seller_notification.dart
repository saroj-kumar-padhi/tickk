import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/components/textstyle.dart';

class SellerNotification extends StatelessWidget {
  SellerNotification({super.key});

  final List<String> images = [
    "assest/rejected.svg",
    "assest/accepted.svg",
    "assest/dealCloased.svg",
    "assest/inprocess.svg",
    "assest/rejected.svg",
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          title: Text(
            "Notifications",
            style: TextStyles.openSans(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xff4A4A4A)),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xff4A4A4A),
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Seller'), // Tab for Seller
              Tab(text: 'Buyer'), // Tab for Buyer
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Seller Tab
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Seller notifications content

                  sellerTab(),
                ],
              ),
            ),
            // Buyer Tab
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Buyer notifications content
                  sellerTab()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Flexible sellerTab() {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: Text(
                "Today",
                style: TextStyles.openSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: const Color(0xff828282)),
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount:
                    6, // Increase itemCount to accommodate the additional disabled tile
                itemBuilder: (context, index) {
                  if (index == 5) {
                    // Check if it's the last item in the list
                    // Render the disabled list tile
                    return const ListTile(
                      enabled: false, // Disable the tile
                      trailing: Text("20 min ago"),
                      leading: CircleAvatar(
                        backgroundColor:
                            Color(0xffFFD361), // Background color of the avatar
                        child: Text(
                          'DG', // Replace 'A' with the first letter of the name or text
                          style: TextStyle(
                            color: Colors.white, // Color of the letter
                            fontWeight: FontWeight
                                .bold, // Bold text for better visibility
                          ),
                        ),
                      ),

                      title: Text(
                        "Store Name",
                        style: TextStyle(
                          color: Colors
                              .grey, // Change color to indicate it's disabled
                          fontStyle: FontStyle.italic, // Italicize the text
                        ),
                      ),
                      subtitle: Text(
                        "Rejected by you.",
                        style: TextStyle(
                          color: Colors
                              .grey, // Change color to indicate it's disabled
                          fontStyle: FontStyle.italic, // Italicize the text
                        ),
                      ),
                    );
                  } else {
                    // Render regular list tiles for other items
                    return Material(
                      elevation: 1,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: ListTile(
                          leading: SizedBox(
                            height: double.infinity,
                            width: 40.h,
                            child: Image.asset(
                              "assest/notification_profile.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          trailing: Column(
                            children: [
                              SizedBox(
                                height: 20.h,
                                width: 57.w,
                                child: SvgPicture.asset(
                                  images[index],
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "20 min ago",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.sp,
                                  color: const Color(0xff4A4A4A),
                                ),
                              )
                            ],
                          ),
                          title: Text(
                            "Store Name",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                          subtitle: Text(
                            "Deal done successfully.",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: Text(
                "This Week",
                style: TextStyles.openSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: const Color(0xff828282)),
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Material(
                    elevation: 1,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: ListTile(
                        trailing: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                              width: 57.w,
                              child: SvgPicture.asset(
                                images[index],
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "20 min ago",
                              style: TextStyles.openSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.sp,
                                  color: const Color(0xff4A4A4A)),
                            )
                          ],
                        ),
                        leading: SizedBox(
                            height: double
                                .infinity, // Set height to fill available height
                            width: 40.h,
                            child: Image.asset(
                              "assest/ganja.png",
                              fit: BoxFit.fill,
                            )),
                        title: Text(
                          "This Week",
                          style: TextStyles.openSans(
                              fontWeight: FontWeight.w600, fontSize: 14.sp),
                        ),
                        subtitle: Text(
                          "Deal done successfully.",
                          style: TextStyles.openSans(
                              fontWeight: FontWeight.w600, fontSize: 12.sp),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
