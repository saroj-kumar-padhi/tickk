import 'package:dekhlo/views/seller_views/tabs/rejectedCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../controllers/rejectTabSeller.dart';

class RejectedTabSeller extends StatelessWidget {
  final String storeId;
  const RejectedTabSeller({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {
    RejectedTabController rejectedTabController =
        Get.put(RejectedTabController(storeId: storeId));
    return Obx(() {
      return rejectedTabController.isLoading.value
          ? Scaffold(
              backgroundColor: const Color(0xffFC8019),
              body: Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: const Color(0xffE4E4E4), size: 200),
              ),
            )
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
                            dateTime:
                                rejectedTabController.rejectedItems[index].date,
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
                          ),
                        );
                      }),
                ),
              ],
            );
    });
  }
}
