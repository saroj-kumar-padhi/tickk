import 'package:dekhlo/views/seller_views/tabs/rejectedCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // Add your refresh logic here
          await rejectedTabController.refreshData();
        },
        child: Obx(() {
          if (rejectedTabController.isLoading.value) {
            return Center(child: LottieBuilder.asset("assest/mX2qe5gUvP.json"));
          } else if (rejectedTabController.rejectedItems.isEmpty) {
            return ListView(
              // Wrap with ListView to make it scrollable for RefreshIndicator
              children: [
                // Center the content
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assest/empty.png'),
                    SizedBox(height: 10.sp),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "No Rejection Yet.",
                        style: TextStyles.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: const Color(0xff4A4A4A),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return ListView.builder(
              itemCount: rejectedTabController.rejectedItems.length,
              itemBuilder: (context, index) {
                var item = rejectedTabController.rejectedItems[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RejectedSellerSquareCard(
                    requirementID: item.requirementID,
                    category: item.storeCategory,
                    subCategory: "not getting",
                    brands: item.brands,
                    dateTime: item.date,
                    modelNo: item.modelNo,
                    qty: item.quantity.toString(),
                    size: item.size.toString(),
                    units: item.units,
                    des: item.requirementInDetails,
                    image: item.addImage,
                    requirementId: item.requirementID,
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
