import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../controllers/buyerDealDoneController.dart';
import '../../../../utils/components/buyerScreenTiles/deal_done_tile.dart';
import '../../../../utils/components/textstyle.dart';

class DealDoneTab extends StatelessWidget {
  const DealDoneTab({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String phoneNumber = user?.phoneNumber ?? "";
    String formattedPhoneNumber =
        phoneNumber.isNotEmpty ? phoneNumber.substring(3) : "";
    BuyerDealDonecontroller buyerDealDonecontroller =
        Get.put(BuyerDealDonecontroller(mobileNo: formattedPhoneNumber));
    return Obx(() => buyerDealDonecontroller.isLoading.value
        ? Scaffold(
            backgroundColor: const Color(0xffFC8019),
            body: Center(
              child: LoadingAnimationWidget.inkDrop(
                  color: const Color(0xffE4E4E4), size: 200),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.h),
                child: Text(
                    "Total Requirements : ${buyerDealDonecontroller.requirementsList.length} "),
              ),
              Expanded(
                flex: 12,
                child: buyerDealDonecontroller.requirementsList.isEmpty
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assest/empty.png'),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Text(
                            "No Requirement Yet.",
                            style: TextStyles.openSans(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: const Color(0xff4A4A4A)),
                          ),
                        ],
                      ))
                    : ListView.builder(
                        itemCount:
                            buyerDealDonecontroller.requirementsList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: DealDoneCard(
                              requirementId: buyerDealDonecontroller
                                  .requirementsList[index].requirementID,
                              category: buyerDealDonecontroller
                                  .requirementsList[index].storeCategory,
                              subCategory: "Table lamp",
                              brands: buyerDealDonecontroller
                                  .requirementsList[index].brands,
                              modelNo: buyerDealDonecontroller
                                  .requirementsList[index].modelNo,
                              qty: buyerDealDonecontroller
                                  .requirementsList[index].quantity
                                  .toString(),
                              size: buyerDealDonecontroller
                                  .requirementsList[index].size
                                  .toString(),
                              units: buyerDealDonecontroller
                                  .requirementsList[index].units,
                              des: buyerDealDonecontroller
                                  .requirementsList[index].requirementInDetails,
                              date: buyerDealDonecontroller
                                  .requirementsList[index].date,
                              stores: buyerDealDonecontroller
                                  .requirementsList[index].stores,
                            ),
                          );
                        }),
              ),
            ],
          ));
  }
}
