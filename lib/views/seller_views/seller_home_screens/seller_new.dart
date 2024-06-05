import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/homeSellerController.dart';
import '../../../utils/components/coustoum_serch_bar.dart';
import '../../../utils/components/textstyle.dart';
import '../sellerProfiles/seller_profile.dart';
import '../tabs/accepted_tab.dart';
import '../tabs/deal_done.dart';
import '../tabs/new_tabs.dart';
import '../tabs/panding.dart';
import '../tabs/process_panding.dart';

class HomeSeller extends StatelessWidget {
  const HomeSeller({super.key});

  @override
  Widget build(BuildContext context) {
    HomeSellerController homeSellerController = Get.put(HomeSellerController());
    return DefaultTabController(
      length: 5, // Number of tabs
      child: Scaffold(
        floatingActionButton: Obx(() {
          return Visibility(
            visible: homeSellerController.isBuying.value,
            child: Padding(
              padding: EdgeInsets.only(bottom: 30.h),
              child: FloatingActionButton(
                backgroundColor: const Color(0xffFC8019),
                onPressed: () {
                  Get.toNamed(RouteName.postRequirements);
                },
                child: const Icon(Icons.add),
              ),
            ),
          );
        }),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: GlobalSizes.getDeviceHeight(context) * 0.012,
              ),
              Row(
                children: [
                  SizedBox(
                    width: GlobalSizes.getDeviceWidth(context) * 0.7,
                    child: SlimSearchBar(),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouteName.sellerNotification);
                    },
                    child: SizedBox(
                        height: GlobalSizes.getDeviceHeight(context) * 0.03,
                        child: SvgPicture.asset(
                          height: 20.h,
                          width: 20.w,
                          "assest/bell_seller.svg",
                          fit: BoxFit.fill,
                        )),
                  ),
                  SizedBox(
                    width: GlobalSizes.getDeviceHeight(context) * 0.015,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouteName.myStore);
                    },
                    child: SvgPicture.asset(
                      height: 20.h,
                      width: 20.w,
                      "assest/seller_hut.svg",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: GlobalSizes.getDeviceHeight(context) * 0.015,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const SellerProfile());
                    },
                    child: SvgPicture.asset(
                      height: 20.h,
                      width: 20.w,
                      "assest/user.svg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 14, // Adjust spacing between search bar and tab bar
              ),
              SizedBox(
                height: GlobalSizes.getDeviceHeight(context) * 0.05,
                child: TabBar(
                  labelColor: const Color(0xffFC8019),
                  unselectedLabelColor: const Color(0xff4A4A4A),
                  tabs: [
                    Tab(
                      child: Text(
                        'New (05)',
                        style: TextStyles.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Pending quotes (02)',
                        style: TextStyles.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'In process (02)',
                        style: TextStyles.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Accepted (03)',
                        style: TextStyles.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Deal Done (01)',
                        style: TextStyles.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                  isScrollable: true,
                  indicatorColor: const Color(0xffFC8019),
                ),
              ),
              const Divider(),
              const Expanded(
                child: TabBarView(
                  children: [
                    NewTabSeller(),
                    PandingTabSeller(),
                    ProcessTabSeller(),
                    AcceptedTabSeller(),
                    DealDoneTabSeller(),
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        homeSellerController.isBuying.value =
                            !homeSellerController.isBuying.value;
                      },
                      child: Obx(() {
                        return homeSellerController.isBuying.value
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: SvgPicture.asset(
                                    "assest/selling_white.svg"))
                            : SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: SvgPicture.asset(
                                    "assest/selling_orange.svg"));
                      }),
                    ),
                    InkWell(
                      onTap: () {
                        // Get.toNamed(RouteName.homeBuyerScreen);
                        homeSellerController.isBuying.value =
                            !homeSellerController.isBuying.value;
                      },
                      child: Obx(() {
                        return homeSellerController.isBuying.value
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: SvgPicture.asset(
                                    "assest/buying_orange.svg"))
                            : SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: SvgPicture.asset(
                                    "assest/buying_white.svg"));
                      }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
