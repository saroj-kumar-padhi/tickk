import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../controllers/buyerInprocessController.dart';
import '../../../../utils/components/buyerScreenTiles/inprocess_tile.dart';
import '../../../../utils/components/textstyle.dart';

class InProcessTab extends StatelessWidget {
  const InProcessTab({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String phoneNumber = user?.phoneNumber ?? "";
    String formattedPhoneNumber =
        phoneNumber.isNotEmpty ? phoneNumber.substring(3) : "";
    Buyerinprocesscontroller buyerinprocesscontroller =
        Get.put(Buyerinprocesscontroller(mobileNo: formattedPhoneNumber));

    return Obx(() {
      return buyerinprocesscontroller.isLoading.value
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
                      "Total Requirements : ${buyerinprocesscontroller.requirementsList.length} "),
                ),
                Expanded(
                  flex: 12,
                  child: buyerinprocesscontroller.requirementsList.isEmpty
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
                              buyerinprocesscontroller.requirementsList.length,
                          itemBuilder: (context, index) {
                            var data = buyerinprocesscontroller
                                .requirementsList[index];
                            return Padding(
                              padding: EdgeInsets.all(10.0.h),
                              child: InprocessTile(
                                requirementId: data.requirementID,
                                catagory: data.storeCategory,
                                subCategory: data.storeSubSubCategory,
                                brands: data.storeSubCategory,
                                modelNo: data.modelNo,
                                oty: data.quantity.toString(),
                                size: data.size.toString(),
                                units: data.units.toString(),
                                des: data.requirementInDetails,
                                date: data.Date,
                                stores: data.stores,
                                mobile: formattedPhoneNumber,
                              ),
                            );
                          }),
                ),
              ],
            );
    });
  }
}
