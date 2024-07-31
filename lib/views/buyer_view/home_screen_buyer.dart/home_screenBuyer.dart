import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:dekhlo/views/buyer_view/home_screen_buyer.dart/tabs/new_tab.dart';
import 'package:dekhlo/views/buyer_view/home_screen_buyer.dart/tabs/rejected_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../controllers/basicControllerEdit.dart';
import '../../../controllers/categoriesController.dart';
import '../../../controllers/flavourController.dart';
import '../../../utils/components/textstyle.dart';

import '../../seller_views/welcome_screen.dart';
import 'tabs/deal_done.dart';
import 'tabs/inprocess_tab.dart';

class HomeBuyer extends StatelessWidget {
  const HomeBuyer({super.key});

  @override
  Widget build(BuildContext context) {
    FlavourContoler flavourContoler = Get.put(FlavourContoler(storeID: ""));
    CategoriesController categoriesController = Get.put(CategoriesController());
    return PopScope(
      onPopInvoked: (onPoped) async {
        await SystemNavigator.pop();
      },
      child: DefaultTabController(
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
                        width: GlobalSizes.getDeviceWidth(context) * 0.3,
                        child: SvgPicture.asset("assest/small_tick.svg"),
                      ),
                      SizedBox(
                        width: 140.w,
                      ),
                      SizedBox(
                        width: GlobalSizes.getDeviceHeight(context) * 0.015,
                      ),
                      InkWell(
                        onTap: () async {
                          BasiccontrollerEdit basiccontrollerEdit =
                              Get.put(BasiccontrollerEdit());
                          final box = Hive.box('myBox');
                          final String formattedPhoneNumber =
                              box.get('phone') ?? "";
                          await basiccontrollerEdit.fetchBasicDetailsEdit(
                              mobile: formattedPhoneNumber);
                          Get.toNamed(RouteName.buyerProfile);
                        },
                        child: SizedBox(
                          height: GlobalSizes.getDeviceHeight(context) * 0.03,
                          child: SvgPicture.asset(
                            "assest/user (1).svg",
                            fit: BoxFit.fitHeight,
                          ),
                        ),

                        // child: const Icon(
                        //   Icons.person_2_outlined,
                        //   color: Color(0xff4A4A4A),
                        // ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(const EnhancedWelcomeScreen());
                        },
                        child: SizedBox(
                          height: GlobalSizes.getDeviceHeight(context) * 0.036,
                          width: 30.w,
                          child: SvgPicture.asset(
                            "assest/storeIcon.svg",
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
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                    height: 90.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: flavourContoler.categoryData.length,
                      itemBuilder: (context, index) {
                        String categoryName =
                            flavourContoler.categoryData.keys.elementAt(index);
                        String imagePath = flavourContoler.categoryData.values
                            .elementAt(index);

                        return GestureDetector(
                          onTap: () async {
                            categoriesController.selectedCategory.value =
                                categoryName;
                            await categoriesController.fetchSubcategories(
                                categoriesController.selectedCategory.value =
                                    categoryName);

                            Get.toNamed(RouteName.postRequirements);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 10.h),
                            child: Column(
                              children: [
                                Material(
                                  elevation: 4,
                                  shadowColor: Colors.grey.withOpacity(0.2),
                                  shape: const CircleBorder(),
                                  child: CircleAvatar(
                                    radius: 25.r,
                                    backgroundColor: const Color(0xffFFF5EC),
                                    child: imagePath.isNotEmpty
                                        ? SvgPicture.asset(imagePath)
                                        : const Icon(Icons.category,
                                            color:
                                                Colors.grey), // Fallback icon
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  categoryName,
                                  style: TextStyle(fontSize: 12.sp),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                SizedBox(
                  height: 4.h, // Adjust spacing between search bar and tab bar
                ),
                SizedBox(
                  height: GlobalSizes.getDeviceHeight(context) * 0.05,
                  child: TabBar(
                    labelColor: const Color(0xffFC8019),
                    unselectedLabelColor: const Color(0xff4A4A4A),
                    tabs: [
                      Tab(
                        child: Text(
                          'New',
                          style: TextStyles.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'In process',
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
                        child: SvgPicture.asset(
                          "assest/buying.svg",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteName.postRequirements);
                        },
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child:
                                SvgPicture.asset("assest/postRequirement.svg")),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
