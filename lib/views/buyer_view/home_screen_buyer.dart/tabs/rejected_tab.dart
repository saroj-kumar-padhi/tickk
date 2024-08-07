import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

import '../../../../controllers/rejectedTabController.dart';
import '../../../../utils/components/buyerScreenTiles/rejected_tiles.dart';
import '../../../../utils/components/textstyle.dart';

class RejectedTab extends StatelessWidget {
  const RejectedTab({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('myBox');
    final String formattedPhoneNumber = box.get('phone');

    RejectedBuyerTabController buyerRejectedController =
        Get.put(RejectedBuyerTabController(mobileNo: formattedPhoneNumber));

    return Obx(() => RefreshIndicator(
          onRefresh: buyerRejectedController.refreshData,
          child: buyerRejectedController.isLoading.value
              ? Scaffold(
                  body: Center(
                      child: LottieBuilder.asset("assest/mX2qe5gUvP.json")),
                )
              : buyerRejectedController.rejectedItems.isEmpty
                  ? ListView(
                      // Wrap the empty state in a ListView
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10.h),
                                  child: Text(
                                      "Total Requirements : ${buyerRejectedController.rejectedItems.length} "),
                                ),
                                SizedBox(height: 120.h),
                                Column(
                                  children: [
                                    Center(
                                        child: Image.asset('assest/empty.png')),
                                    SizedBox(height: 10.sp),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        "No Rejection Yet.",
                                        style: TextStyles.openSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp,
                                            color: const Color(0xff4A4A4A)),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : ListView(
                      // Use ListView instead of Column for the non-empty state
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.h),
                          child: Text(
                              "Total Requirements : ${buyerRejectedController.rejectedItems.length} "),
                        ),
                        ...buyerRejectedController.rejectedItems
                            .map((data) => Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: RejectedSquareCard(
                                    reqId: data.requirementID,
                                    subCategories: data.storeCategory,
                                    brands: data.brands,
                                    modelNo: data.modelNo,
                                    qty: data.quantity.toString(),
                                    size: data.size.toString(),
                                    units: data.units,
                                    des: data.requirementInDetails,
                                    date: data.date,
                                  ),
                                )),
                      ],
                    ),
        ));
  }
}
