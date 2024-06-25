import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../controllers/inprocessTabSeller.dart';
import '../../../utils/components/sellerScreenTiles/process_tile.dart';
import 'package:intl/intl.dart';

class ProcessTabSeller extends StatelessWidget {
  final String storeId;
  const ProcessTabSeller({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {
    final SellerInprocesscontroller sellerInprocesscontroller =
        Get.put(SellerInprocesscontroller(storeId: storeId));
    return Scaffold(
      body: Obx(() {
        if (sellerInprocesscontroller.isLoading.value) {
          return Center(
            child: LoadingAnimationWidget.inkDrop(
              color: const Color(0xffE4E4E4),
              size: 200,
            ),
          );
        } else {
          if (sellerInprocesscontroller.requirementsList.isEmpty) {
            return const Center(
              child: Text(
                'No data available',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  flex: 12,
                  child: ListView.builder(
                    itemCount:
                        sellerInprocesscontroller.requirementsList.length,
                    itemBuilder: (context, index) {
                      final requirement =
                          sellerInprocesscontroller.requirementsList[index];

                      DateTime parsedDate = DateTime.parse(requirement.date);
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(parsedDate);
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ProcessSellerCard(
                          name: requirement.yourName,
                          category: requirement.storeCategory.first,
                          subCategory: requirement.storeSubCategory.first,
                          brands: requirement.brands,
                          date: formattedDate,
                          modelNo: requirement.modelNo,
                          quantity: requirement.quantity.toString(),
                          size: requirement.quantity.toString(),
                          units: requirement.units.toString(),
                          des: requirement.requirementInDetails,
                          qute: requirement.quote.toString(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        }
      }),
    );
  }
}
