import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../controllers/buyerDealDoneController.dart';
import '../../../../utils/components/buyerScreenTiles/deal_done_tile.dart';

class DealDoneTab extends StatelessWidget {
  const DealDoneTab({super.key});

  @override
  Widget build(BuildContext context) {
    BuyerDealDonecontroller buyerDealDonecontroller =
        Get.put(BuyerDealDonecontroller(mobileNo: '9'));
    return Obx(() => buyerDealDonecontroller.isLoading.value
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
                    itemCount: buyerDealDonecontroller.requirementsList.length,
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
