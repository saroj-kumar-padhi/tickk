import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:dekhlo/views/buyer_view/home_screen_buyer.dart/tabs/new_tab.dart';
import 'package:dekhlo/views/buyer_view/home_screen_buyer.dart/tabs/rejected_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/components/coustoum_serch_bar.dart';
import '../../../utils/components/textstyle.dart';

import 'tabs/deal_done.dart';
import 'tabs/inprocess_tab.dart';

class HomeBuyer extends StatelessWidget {
  const HomeBuyer({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: GlobalSizes.getDeviceHeight(context) * 0.012,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: GlobalSizes.getDeviceHeight(context) * 0.019,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: GlobalSizes.getDeviceWidth(context) * 0.6,
                      child: SlimSearchBar(),
                    ),
                    SizedBox(
                      width: GlobalSizes.getDeviceHeight(context) * 0.015,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(RouteName.buyerNotification);
                      },
                      child: SizedBox(
                          height: GlobalSizes.getDeviceHeight(context) * 0.03,
                          child: Image.asset(
                            "assest/bell.png",
                            fit: BoxFit.fitHeight,
                          )),
                    ),
                    SizedBox(
                      width: GlobalSizes.getDeviceHeight(context) * 0.015,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(RouteName.buyerProfile);
                      },
                      child: SizedBox(
                        height: GlobalSizes.getDeviceHeight(context) * 0.03,
                        child: Image.asset(
                          "assest/user.png",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: GlobalSizes.getDeviceHeight(context) * 0.015,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(RouteName.setUpProduct);
                      },
                      child: SizedBox(
                        height: GlobalSizes.getDeviceHeight(context) * 0.036,
                        child: Image.asset(
                          "assest/sellerShop.png",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: GlobalSizes.getDeviceHeight(context) * 0.001,
                    ),
                  ],
                ),
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
                        'In process (02)',
                        style: TextStyles.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Deal Done',
                        style: TextStyles.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Rejected',
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
              Expanded(
                child: TabBarView(
                  children: [
                    NewTab(), // inprocess tab
                    const InProcessTab(), // inprocess tab
                    const DealDoneTab(), //Deal Done
                    const RejectedTab(), // rejected tab
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Image.asset(
                        "assest/buying.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(RouteName.postRequirements);
                      },
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Image.asset("assest/post.png")),
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
