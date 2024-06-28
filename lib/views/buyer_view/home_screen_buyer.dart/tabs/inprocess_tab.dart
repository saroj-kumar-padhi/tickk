import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../controllers/buyerInprocessController.dart';
import '../../../../utils/components/buyerScreenTiles/inprocess_tile.dart';

class InProcessTab extends StatelessWidget {
  const InProcessTab({super.key});

  @override
  Widget build(BuildContext context) {
    Buyerinprocesscontroller buyerinprocesscontroller =
        Get.put(Buyerinprocesscontroller(mobileNo: '9'));
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
              children: [
                Expanded(
                  flex: 12,
                  child: ListView.builder(
                      itemCount:
                          buyerinprocesscontroller.requirementsList.length,
                      itemBuilder: (context, index) {
                        var data =
                            buyerinprocesscontroller.requirementsList[index];
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
                            date: "05 feb 24",
                            stores: data.stores,
                          ),
                        );
                      }),
                ),
              ],
            );
    });
  }
}
