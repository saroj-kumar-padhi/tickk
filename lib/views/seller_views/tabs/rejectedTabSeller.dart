import 'package:dekhlo/views/seller_views/tabs/rejectedCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

import '../../../controllers/rejectTabSeller.dart';
import '../../../utils/components/textstyle.dart';

class RejectedTabSeller extends StatelessWidget {
  final String storeId;
  final String storeName;
  const RejectedTabSeller(
      {super.key, required this.storeId, required this.storeName});

  @override
  Widget build(BuildContext context) {
    RejectedTabController rejectedTabController =
        Get.put(RejectedTabController(storeId: storeId));
    return Obx(() {
      return rejectedTabController.isLoading.value
          ? Scaffold(
              body:
                  Center(child: LottieBuilder.asset("assest/XyglI35BZO.json")),
            )
          : rejectedTabController.rejectedItems.isEmpty
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
              : Column(
                  children: [
                    Expanded(
                      flex: 12,
                      child: ListView.builder(
                          itemCount: rejectedTabController.rejectedItems.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: RejectedSellerSquareCard(
                                requirementID: rejectedTabController
                                    .rejectedItems[index].requirementID,
                                category: rejectedTabController
                                    .rejectedItems[index].storeCategory,
                                subCategory: "not getting",
                                brands: rejectedTabController
                                    .rejectedItems[index].brands,
                                dateTime: rejectedTabController
                                    .rejectedItems[index].date,
                                modelNo: rejectedTabController
                                    .rejectedItems[index].modelNo,
                                qty: rejectedTabController
                                    .rejectedItems[index].quantity
                                    .toString(),
                                size: rejectedTabController
                                    .rejectedItems[index].size
                                    .toString(),
                                units: rejectedTabController
                                    .rejectedItems[index].units,
                                des: rejectedTabController
                                    .rejectedItems[index].requirementInDetails,
                                image: rejectedTabController
                                    .rejectedItems[index].addImage,
                              ),
                            );
                          }),
                    ),
                  ],
                );
    });
  }
}
