import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../controllers/inprocessTabSeller.dart';
import '../../../utils/components/sellerScreenTiles/process_tile.dart';
import '../../../utils/components/textstyle.dart';
import 'package:intl/intl.dart';

class ProcessTabSeller extends StatelessWidget {
  final String storeId;
  final String storeName;
  const ProcessTabSeller(
      {super.key, required this.storeId, required this.storeName});

  @override
  Widget build(BuildContext context) {
    final SellerInprocesscontroller sellerInprocesscontroller =
        Get.put(SellerInprocesscontroller(storeId: storeId));
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await sellerInprocesscontroller.refreshData();
        },
        child: Obx(() {
          if (sellerInprocesscontroller.isLoading.value) {
            return Center(child: LottieBuilder.asset("assest/mX2qe5gUvP.json"));
          } else if (sellerInprocesscontroller.requirementsList.isEmpty) {
            return ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assest/empty.png'),
                        SizedBox(height: 10.sp),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "No Requirement Yet. Tickk is working for $storeName to get Request",
                            style: TextStyles.openSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: const Color(0xff4A4A4A),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Text(
                    "Total requirement : ${sellerInprocesscontroller.requirementsList.length}",
                  ),
                ),
                ...sellerInprocesscontroller.requirementsList
                    .map((requirement) {
                  DateTime parsedDate = DateTime.parse(requirement.date);
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(parsedDate);
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ProcessSellerCard(
                        name: requirement.yourName,
                        category: requirement.storeCategory,
                        subCategory: requirement.storeSubCategory,
                        brands: requirement.brands,
                        date: formattedDate,
                        modelNo: requirement.modelNo,
                        quantity: requirement.quantity.toString(),
                        size: requirement.quantity.toString(),
                        units: requirement.units.toString(),
                        des: requirement.requirementInDetails,
                        qute: requirement.quote.toString(),
                        exact: requirement.exact,
                        image: requirement.addImage,
                        exactSimilarImage: requirement.exactSimilarImage,
                        requirementId: requirement.requirementID,
                        profileImage: requirement.profileImage),
                  );
                }),
              ],
            );
          }
        }),
      ),
    );
  }
}
