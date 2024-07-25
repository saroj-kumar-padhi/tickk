import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

import '../../../../controllers/newTabController.dart';
import '../../../../utils/components/buyerScreenTiles/new_tiles.dart';

class NewTab extends StatelessWidget {
  NewTabController newTabController = Get.put(NewTabController());

  NewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => newTabController.isLoading.value
        ? Scaffold(
            body: Center(child: LottieBuilder.asset("assest/mX2qe5gUvP.json")),
          )
        : newTabController.requirementsList.isEmpty
            ? Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.h),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          "Total Requirements : ${newTabController.requirementsList.length} "),
                    ),
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assest/empty.png'),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Text(
                        "Post your first requirement now",
                        style: TextStyles.openSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: const Color(0xff4A4A4A)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(RouteName.postRequirements);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(8),
                          backgroundColor:
                              const Color(0xffFC8019), // Button color
                          foregroundColor: Colors.white, // Icon color
                        ),
                        child: const Icon(Icons.add, size: 20),
                      )
                    ],
                  )
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.h),
                    child: Text(
                      "Total Requirements : ${newTabController.requirementsList.length}",
                    ),
                  ),
                  Expanded(
                    flex: 12,
                    child: newTabController.requirementsList.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/no_requirements_image.png', // Replace with your image path
                                  width: 150, // Adjust size as needed
                                  height: 150,
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'No requirements',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
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
                                      .requirementsList[index]
                                      .storeSubSubCategory,
                                  brands: newTabController
                                      .requirementsList[index].brands,
                                  modelNo: newTabController
                                      .requirementsList[index].modelNo,
                                  size: newTabController
                                      .requirementsList[index].size
                                      .toString(),
                                  quantity: newTabController
                                      .requirementsList[index].quantity
                                      .toString(),
                                  units: newTabController
                                      .requirementsList[index].units
                                      .toString(),
                                  requirementInDetails: newTabController
                                      .requirementsList[index]
                                      .requirementInDetails,
                                  date: newTabController
                                      .requirementsList[index].date
                                      .toString(),
                                  image: newTabController
                                          .requirementsList[index].addImage ??
                                      "",
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ));
  }
}
