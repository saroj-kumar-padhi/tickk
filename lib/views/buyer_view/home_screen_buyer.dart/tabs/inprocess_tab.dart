import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

import '../../../../controllers/buyerInprocessController.dart';
import '../../../../utils/components/buyerScreenTiles/inprocess_tile.dart';
import '../../../../utils/components/textstyle.dart';

class InProcessTab extends StatelessWidget {
  const InProcessTab({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('myBox');
    final String formattedPhoneNumber = box.get('phone');
    Buyerinprocesscontroller buyerinprocesscontroller =
        Get.put(Buyerinprocesscontroller(mobileNo: formattedPhoneNumber));

    return Obx(() {
      return buyerinprocesscontroller.isLoading.value
          ? Scaffold(
              body:
                  Center(child: LottieBuilder.asset("assest/mX2qe5gUvP.json")),
            )
          : RefreshIndicator(
              onRefresh: buyerinprocesscontroller.refreshData,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.h),
                      child: Text(
                        "Total Requirements : ${buyerinprocesscontroller.requirementsList.length}",
                      ),
                    ),
                  ),
                  buyerinprocesscontroller.requirementsList.isEmpty
                      ? SliverFillRemaining(child: emptyStateBuild())
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
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
                                  requirementImge: data.addImage,
                                  image: data.addImage,
                                ),
                              );
                            },
                            childCount: buyerinprocesscontroller
                                .requirementsList.length,
                          ),
                        ),
                ],
              ),
            );
    });
  }

  Center emptyStateBuild() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
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
    ));
  }
}
