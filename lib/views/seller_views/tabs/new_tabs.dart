import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:lottie/lottie.dart';
import '../../../controllers/homeSellerController.dart';
import '../../../utils/components/sellerScreenTiles/newSellerTile.dart';

class NewTabSeller extends StatelessWidget {
  final String storeId;
  final String storeName;

  const NewTabSeller(
      {super.key, required this.storeId, required this.storeName});

  @override
  Widget build(BuildContext context) {
    final HomeSellerController homeSellerController =
        Get.put(HomeSellerController(storeId));
    return Column(
      children: [
        Expanded(
          flex: 12,
          child: Obx(
            () => RefreshIndicator(
              onRefresh: homeSellerController.refreshData,
              child: homeSellerController.isLoading.value
                  ? Scaffold(
                      body: Center(
                          child: LottieBuilder.asset("assest/mX2qe5gUvP.json")),
                    )
                  : homeSellerController.sellerDataList.isEmpty
                      ? ListView(
                          // Wrap empty state in ListView to make it scrollable
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset('assest/empty.png'),
                                    SizedBox(height: 10.sp),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        "No Requirement Yet.Tickk is working for $storeName to get Request",
                                        style: TextStyles.openSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp,
                                            color: const Color(0xff4A4A4A)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : ListView(
                          // Use ListView instead of Column for non-empty state
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: Text(
                                  "Total requirement : ${homeSellerController.sellerDataList.length}"),
                            ),
                            ...homeSellerController.sellerDataList
                                .asMap()
                                .entries
                                .map((entry) {
                              int index = entry.key;
                              var data = entry.value;
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: NewSellerCard(
                                  storeCategory: data.storeCategory,
                                  storeSubCategory: data.storeSubCategory,
                                  brands: data.brands,
                                  date: DateFormat('yyyy-MM-dd')
                                      .format(data.date),
                                  modelNo: data.modelNo,
                                  Qty: data.quantity.toString(),
                                  size: data.size.toString(),
                                  units: data.units,
                                  Requirement_in_details:
                                      data.requirementInDetails,
                                  requirementId: data.requirementID,
                                  FCM: data.FCM,
                                  image: data.addImage,
                                  storeId: storeId,
                                  name: data.yourName,
                                  index: index,
                                ),
                              );
                            }),
                          ],
                        ),
            ),
          ),
        ),
      ],
    );
  }
}
