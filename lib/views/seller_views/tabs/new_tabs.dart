import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../controllers/homeSellerController.dart';
import '../../../utils/components/sellerScreenTiles/newSellerTile.dart';

class NewTabSeller extends StatelessWidget {
  final String storeId;

  const NewTabSeller({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {
    final HomeSellerController homeSellerController =
        Get.put(HomeSellerController(storeId));
    return Column(
      children: [
        Expanded(
            flex: 12,
            child: Obx(
              () => homeSellerController.isLoading.value
                  ? Scaffold(
                      backgroundColor: const Color(0xffFC8019),
                      body: Center(
                        child: LoadingAnimationWidget.inkDrop(
                            color: const Color(0xffE4E4E4), size: 200),
                      ),
                    )
                  : ListView.builder(
                      itemCount: homeSellerController.sellerDataList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: NewSellerCard(
                            storeCategory: homeSellerController
                                .sellerDataList[index].storeCategory,
                            storeSubCategory: homeSellerController
                                .sellerDataList[index].storeSubCategory,
                            brands: homeSellerController
                                .sellerDataList[index].brands,
                            date: DateFormat('yyyy-MM-dd').format(
                                homeSellerController
                                    .sellerDataList[index].date),
                            modelNo: homeSellerController
                                .sellerDataList[index].modelNo,
                            Qty: homeSellerController
                                .sellerDataList[index].quantity
                                .toString(),
                            size: homeSellerController
                                .sellerDataList[index].size
                                .toString(),
                            units: homeSellerController
                                .sellerDataList[index].units,
                            Requirement_in_details: homeSellerController
                                .sellerDataList[index].requirementInDetails,
                            requirementId: homeSellerController
                                .sellerDataList[index].requirementID,
                          ),
                        );
                      }),
            )),
      ],
    );
  }
}
