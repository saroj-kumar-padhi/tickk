import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../controllers/rejectedTabController.dart';
import '../../../../utils/components/buyerScreenTiles/rejected_tiles.dart';
import '../../../../utils/components/textstyle.dart';

class RejectedTab extends StatelessWidget {
  RejectedTab({super.key});

  RejectedBuyerTabController buyerRejectedController =
      Get.put(RejectedBuyerTabController(mobileNo: '1234567890'));

  @override
  Widget build(BuildContext context) {
    return Obx(() => buyerRejectedController.isLoading.value
        ? Scaffold(
            backgroundColor: const Color(0xffFC8019),
            body: Center(
              child: LoadingAnimationWidget.inkDrop(
                  color: const Color(0xffE4E4E4), size: 200),
            ),
          )
        : buyerRejectedController.rejectedItems.isEmpty
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
                      "No Requirement Yet.Tickk is working for ABC Store to get Request",
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
                        itemCount: buyerRejectedController.rejectedItems.length,
                        itemBuilder: (context, index) {
                          var data =
                              buyerRejectedController.rejectedItems[index];
                          return Padding(
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
                          );
                        }),
                  ),
                ],
              ));
  }
}
