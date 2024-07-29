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
              () => homeSellerController.isLoading.value
                  ? Scaffold(
                      body: Center(
                          child: LottieBuilder.asset("assest/mX2qe5gUvP.json")),
                    )
                  : homeSellerController.sellerDataList.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assest/empty.png'),
                            SizedBox(
                              height: 10.sp,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "No Requirement Yet.Tickk is working for $storeName to get Request",
                                style: TextStyles.openSans(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                    color: const Color(0xff4A4A4A)),
                              ),
                            ),
                          ],
                        ))
                      : ListView.builder(
                          itemCount: homeSellerController.sellerDataList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: NewSellerCard(
                                storeCategory: homeSellerController
                                    .sellerDataList[index].storeCategory,
                                storeSubCategory: homeSellerController
                                    .sellerDataList[index].storeSubCategory,
                                brands: homeSellerController
                                    .sellerDataList[index].brands,
                                date: DateFormat('yyyy-MM-dd').format(
                                    homeSellerController
                                        .sellerDataList[index].date),
                                modelNo: homeSellerController
                                    .sellerDataList[index].modelNo,
                                Qty: homeSellerController
                                    .sellerDataList[index].quantity
                                    .toString(),
                                size: homeSellerController
                                    .sellerDataList[index].size
                                    .toString(),
                                units: homeSellerController
                                    .sellerDataList[index].units,
                                Requirement_in_details: homeSellerController
                                    .sellerDataList[index].requirementInDetails,
                                requirementId: homeSellerController
                                    .sellerDataList[index].requirementID,
                                FCM: homeSellerController
                                    .sellerDataList[index].FCM,
                                image: homeSellerController
                                    .sellerDataList[index].addImage,
                                storeId: storeId,
                              ),
                            );
                          }),
            )),
      ],
    );
  }
}
