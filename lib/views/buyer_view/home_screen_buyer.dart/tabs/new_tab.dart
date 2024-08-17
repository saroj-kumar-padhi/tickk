import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../controllers/newTabController.dart';
import '../../../../utils/components/buyerScreenTiles/new_tiles.dart';

class NewTab extends StatelessWidget {
  final NewTabController newTabController = Get.put(NewTabController());

  NewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => newTabController.isLoading.value
        ? Scaffold(
            body: Center(child: LottieBuilder.asset("assest/mX2qe5gUvP.json")),
          )
        : RefreshIndicator(
            onRefresh: newTabController.refreshData,
            child: newTabController.requirementsList.isEmpty
                ? _buildEmptyState(context)
                : _buildRequirementsList(context),
          ));
  }

  Widget _buildEmptyState(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.h),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                    "Total Requirements : ${newTabController.requirementsList.length} "),
              ),
            ),
            SizedBox(height: 100.h),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assest/empty.png'),
                SizedBox(height: 10.sp),
                Text(
                  "Post your requirement now",
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
                    backgroundColor: const Color(0xffFC8019),
                    foregroundColor: Colors.white,
                  ),
                  child: const Icon(Icons.add, size: 20),
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _buildRequirementsList(BuildContext context) {
    return Column(
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
          child: ListView.builder(
            itemCount: newTabController.requirementsList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: NewSquareCard(
                  mobile: newTabController.requirementsList[index].mobile
                      .toString(),
                  requirementId:
                      newTabController.requirementsList[index].requirementID,
                  storeCategory:
                      newTabController.requirementsList[index].storeCategory,
                  storeSubCategory:
                      newTabController.requirementsList[index].storeSubCategory,
                  storeSubSubCategory: newTabController
                      .requirementsList[index].storeSubSubCategory,
                  brands: newTabController.requirementsList[index].brands,
                  modelNo: newTabController.requirementsList[index].modelNo,
                  size:
                      newTabController.requirementsList[index].size.toString(),
                  quantity: newTabController.requirementsList[index].quantity
                      .toString(),
                  units:
                      newTabController.requirementsList[index].units.toString(),
                  requirementInDetails: newTabController
                      .requirementsList[index].requirementInDetails,
                  date:
                      newTabController.requirementsList[index].date.toString(),
                  image:
                      newTabController.requirementsList[index].addImage ?? "",
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
