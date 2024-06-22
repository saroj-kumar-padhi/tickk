import 'package:dekhlo/controllers/sellerPandingController.dart';
import 'package:dekhlo/models/sellerPandingQueta.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../utils/components/sellerScreenTiles/pandingSellerTile.dart';

class PandingTabSeller extends StatelessWidget {
  final String storeId;

  const PandingTabSeller({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {
    final Sellerpandingcontroller sellerpandingcontroller =
        Get.put(Sellerpandingcontroller(storeId: storeId));
    return Obx(() => sellerpandingcontroller.isLoading.value
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
                    itemCount: sellerpandingcontroller.requirementsList.length,
                    itemBuilder: (context, index) {
                      Data data =
                          sellerpandingcontroller.requirementsList.value[index];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: PandingSellerCard(
                          subCategories: data.storeSubCategory.first,
                          category: data.storeSubCategory.first,
                          brands: data.brands,
                          date: data.date,
                          modelNo: data.modelNo,
                          qty: data.quantity.toString(),
                          size: data.size.toString(),
                          units: data.units,
                          yourName: data.yourName,
                          des: data.requirementInDetails,
                          storeId: storeId,
                          requirementId: data.requirementID,
                        ),
                      );
                    }),
              ),
            ],
          ));
  }
}
