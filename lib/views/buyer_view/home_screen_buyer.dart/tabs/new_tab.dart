import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../controllers/newTabController.dart';
import '../../../../utils/components/buyerScreenTiles/new_tiles.dart';

class NewTab extends StatelessWidget {
  NewTabController newTabController = Get.put(NewTabController());

  NewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => newTabController.isLoading.value
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
                    itemCount: newTabController.requirementsList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: NewSquareCard(
                          mobile: newTabController
                              .requirementsList[index].mobile
                              .toString(),
                          requirementId: newTabController
                              .requirementsList[index].requirementID,
                          storeCategory: newTabController
                              .requirementsList[index].storeCategory,
                          storeSubCategory: newTabController
                              .requirementsList[index].storeSubCategory,
                          storeSubSubCategory: newTabController
                              .requirementsList[index].storeSubSubCategory,
                          brands:
                              newTabController.requirementsList[index].brands,
                          modelNo:
                              newTabController.requirementsList[index].modelNo,
                          size: newTabController.requirementsList[index].size
                              .toString(),
                          quantity: newTabController
                              .requirementsList[index].quantity
                              .toString(),
                          units: newTabController.requirementsList[index].units
                              .toString(),
                          requirementInDetails: newTabController
                              .requirementsList[index].requirementInDetails,
                          date: newTabController.requirementsList[index].date
                              .toString(),
                        ),
                      );
                    }),
              ),
            ],
          ));
  }
}
