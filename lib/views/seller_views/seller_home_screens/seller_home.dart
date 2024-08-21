import 'package:dekhlo/controllers/flavourController.dart';
import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:dekhlo/views/seller_views/store_screens/mystore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:lottie/lottie.dart';

import '../../../controllers/categoriesController.dart';
import '../../../services/injection.dart';
import '../../../utils/components/textstyle.dart';
import '../../buyer_view/home_screen_buyer.dart/tabs/deal_done.dart';
import '../../buyer_view/home_screen_buyer.dart/tabs/inprocess_tab.dart';
import '../../buyer_view/home_screen_buyer.dart/tabs/new_tab.dart';
import '../../buyer_view/home_screen_buyer.dart/tabs/rejected_tab.dart';
import '../sellerProfiles/seller_profile.dart';
import '../tabs/accepted_tab.dart';
import '../tabs/deal_done.dart';
import '../tabs/new_tabs.dart';
import '../tabs/process_panding.dart';
import '../tabs/rejectedTabSeller.dart';

class HomeSeller extends StatelessWidget {
  final String storeId;

  const HomeSeller({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {
    FlavourContoler flavourContoler =
        Get.put(FlavourContoler(storeID: storeId));
    CategoriesController categoriesController = Get.put(CategoriesController());
    return Obx(() => flavourContoler.isLoading.value
        ? Scaffold(
            body: Center(child: LottieBuilder.asset("assest/mX2qe5gUvP.json")),
          )
        : flavourContoler.isBuying.value
            ? PopScope(
                onPopInvoked: (onPoped) async {
                  await SystemNavigator.pop();
                },
                child: DefaultTabController(
                  length: 4, // Number of tabs
                  child: Scaffold(
                    floatingActionButton: Padding(
                      padding: EdgeInsets.only(bottom: 30.h),
                      child: FloatingActionButton(
                        backgroundColor: const Color(0xffFC8019),
                        onPressed: () {
                          Get.toNamed(RouteName.postRequirements);
                        },
                        child: const Icon(Icons.add),
                      ),
                    ),
                    body: SafeArea(
                      child: Column(
                        children: [
                          SizedBox(
                            height:
                                GlobalSizes.getDeviceHeight(context) * 0.012,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalSizes.getDeviceHeight(context) * 0.010,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: GlobalSizes.getDeviceWidth(context) *
                                      0.25,
                                  child:
                                      SvgPicture.asset("assest/small_tick.svg"),
                                ),
                                SizedBox(
                                  width: 150.w,
                                ),
                                SizedBox(
                                  width: 40.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => const SellerProfile());
                                  },
                                  child: SizedBox(
                                    height:
                                        GlobalSizes.getDeviceHeight(context) *
                                            0.03,
                                    child: SvgPicture.asset(
                                      "assest/user (1).svg",
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                InkWell(
                                  onTap: () async {
                                    final box = Hive.box('myBox');
                                    final String formattedPhoneNumber =
                                        box.get('phone') ?? "";
                                    final storeData =
                                        await restClient.checkStoreId(
                                            int.parse(formattedPhoneNumber));
                                    final storeId = storeData.StoreID;

                                    Get.to(() => MyStore(
                                        StoreId: storeId, isFromSeller: true));
                                  },
                                  child: SvgPicture.asset(
                                    height: 20.h,
                                    width: 20.w,
                                    "assest/seller_hut.svg",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  width: GlobalSizes.getDeviceHeight(context) *
                                      0.001,
                                ),
                              ],
                            ),
                          ),

                          /// The above Dart code is a part of a Flutter application. It is using the
                          /// `Obx` widget from the GetX package to observe changes in the `isLoading`
                          /// value of `categoriesController`.
                          Obx(() {
                            if (categoriesController.isLoading.value) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: Color(0xffFC8019),
                              ));
                            }

                            return SizedBox(
                              height: 90.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: flavourContoler.categoryData.length,
                                itemBuilder: (context, index) {
                                  // Sort the categories
                                  List<MapEntry<String, String>>
                                      sortedCategories = flavourContoler
                                          .categoryData.entries
                                          .toList()
                                        ..sort((a, b) {
                                          bool isAEnabled = categoriesController
                                              .categories
                                              .contains(a.key);
                                          bool isBEnabled = categoriesController
                                              .categories
                                              .contains(b.key);
                                          if (isAEnabled && !isBEnabled) {
                                            return -1;
                                          }
                                          if (!isAEnabled && isBEnabled) {
                                            return 1;
                                          }
                                          return 0;
                                        });

                                  String categoryName =
                                      sortedCategories[index].key;
                                  String imagePath =
                                      sortedCategories[index].value;
                                  bool isEnabled = categoriesController
                                      .categories
                                      .contains(categoryName);

                                  return GestureDetector(
                                    onTap: isEnabled
                                        ? () async {
                                            categoriesController
                                                .selectedCategory
                                                .value = categoryName;
                                            await categoriesController
                                                .fetchSubcategories(
                                                    categoriesController
                                                        .selectedCategory
                                                        .value = categoryName);
                                            Get.toNamed(
                                                RouteName.postRequirements);
                                          }
                                        : () {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "This category is comming soon on tickk");
                                          },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 10.h),
                                      child: Column(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Material(
                                                elevation: 4,
                                                shadowColor: Colors.grey
                                                    .withOpacity(0.2),
                                                shape: const CircleBorder(),
                                                child: CircleAvatar(
                                                  radius: 25.r,
                                                  backgroundColor:
                                                      const Color(0xffFFF5EC),
                                                  child: imagePath.isNotEmpty
                                                      ? SvgPicture.asset(
                                                          imagePath)
                                                      : const Icon(
                                                          Icons.category,
                                                          color: Colors.grey),
                                                ),
                                              ),
                                              if (!isEnabled)
                                                Container(
                                                  width: 50.r,
                                                  height: 50.r,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white
                                                        .withOpacity(0.7),
                                                  ),
                                                ),
                                              if (!isEnabled)
                                                Icon(Icons.info_outline,
                                                    color: Colors.grey,
                                                    size: 20.r),
                                            ],
                                          ),
                                          SizedBox(height: 5.h),
                                          Text(
                                            categoryName,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: isEnabled
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                          const SizedBox(
                            height:
                                14, // Adjust spacing between search bar and tab bar
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

                          /// The above code is creating a TabBarView widget with four tabs: NewTab,
                          /// InProcessTab, DealDoneTab, and RejectedTab. Each tab corresponds to a
                          /// different state of a process, such as in process, deal done, or rejected.
                          /// The TabBarView widget allows the user to switch between these tabs to view
                          /// different content associated with each state.
                          Expanded(
                            child: TabBarView(
                              children: [
                                NewTab(), // inprocess tab
                                const InProcessTab(),

                                const DealDoneTab(), //Deal Done
                                const RejectedTab(), // rejected tab
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50.h,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    flavourContoler.isBuying.value =
                                        !flavourContoler.isBuying.value;
                                  },
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: SvgPicture.asset(
                                          "assest/selling_white.svg")),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: SvgPicture.asset(
                                          "assest/buying_orange.svg")),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : DefaultTabController(
                // selling TabController
                length: 5, // Number of tabs
                child: Scaffold(
                  floatingActionButton: Obx(() {
                    return Visibility(
                      visible: flavourContoler.isBuying.value,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 30.h),
                        child: FloatingActionButton(
                          backgroundColor: const Color(0xffFC8019),
                          onPressed: () {
                            CategoriesController categoriesController =
                                Get.put(CategoriesController());
                            Get.toNamed(RouteName.postRequirements);
                          },
                          child: const Icon(Icons.add),
                        ),
                      ),
                    );
                  }),

                  // this is selling part and above are the buying part

                  body: SafeArea(
                    child: Column(
                      children: [
                        SizedBox(
                          height: GlobalSizes.getDeviceHeight(context) * 0.01,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: GlobalSizes.getDeviceWidth(context) * 0.25,
                              child: SvgPicture.asset("assest/small_tick.svg"),
                            ),
                            SizedBox(
                              width: 160.w,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(RouteName.sellerNotification);
                              },
                              child: SizedBox(
                                  height: GlobalSizes.getDeviceHeight(context) *
                                      0.03,
                                  child: SvgPicture.asset(
                                    height: 20.h,
                                    width: 20.w,
                                    "assest/bell_seller.svg",
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => const SellerProfile());
                              },
                              child: SvgPicture.asset(
                                height: 20.h,
                                width: 20.w,
                                "assest/user (1).svg",
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => MyStore(
                                    StoreId: storeId, isFromSeller: true));
                              },
                              child: SvgPicture.asset(
                                height: 20.h,
                                width: 20.w,
                                "assest/seller_hut.svg",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10
                              .h, // Adjust spacing between search bar and tab bar
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
                                  'Accepted',
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
                              NewTabSeller(
                                storeId: storeId,
                                storeName:
                                    flavourContoler.comapamyName.storeName,
                              ),
                              ProcessTabSeller(
                                storeId: storeId,
                                storeName:
                                    flavourContoler.comapamyName.storeName,
                              ),
                              AcceptedTabSeller(
                                storeName:
                                    flavourContoler.comapamyName.storeName,
                                storeId: storeId,
                              ),
                              DealDoneTabSeller(
                                storeName:
                                    flavourContoler.comapamyName.storeName,
                                storeId: storeId,
                              ),
                              RejectedTabSeller(
                                storeId: storeId,
                                storeName:
                                    flavourContoler.comapamyName.storeName,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  flavourContoler.isBuying.value =
                                      flavourContoler.isBuying.value;
                                },
                                child: Obx(() {
                                  return flavourContoler.isBuying.value
                                      ? SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: SvgPicture.asset(
                                              "assest/selling_white.svg"))
                                      : SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: SvgPicture.asset(
                                              "assest/selling_orange.svg"));
                                }),
                              ),
                              InkWell(
                                onTap: () {
                                  // Get.toNamed(RouteName.homeBuyerScreen);
                                  flavourContoler.isBuying.value =
                                      !flavourContoler.isBuying.value;
                                },
                                child: Obx(() {
                                  return flavourContoler.isBuying.value
                                      ? SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: SvgPicture.asset(
                                              "assest/buying_orange.svg"))
                                      : SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
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
              ));
  }
}
