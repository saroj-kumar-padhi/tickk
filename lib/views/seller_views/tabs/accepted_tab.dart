import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controllers/acceptedTabSellerCotroller.dart';
import '../../../utils/components/sellerScreenTiles/accepted_tile.dart';
import '../../../utils/components/textstyle.dart';

class AcceptedTabSeller extends StatelessWidget {
  final String storeName;
  final String storeId;
  const AcceptedTabSeller(
      {super.key, required this.storeName, required this.storeId});

  @override
  Widget build(BuildContext context) {
    Acceptedtabsellercotroller acceptedtabsellercotroller =
        Get.put(Acceptedtabsellercotroller(storeId));

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // Add your refresh logic here
          await acceptedtabsellercotroller.refreshData();
        },
        child: Obx(() {
          if (acceptedtabsellercotroller.isLoading.value) {
            return Center(child: LottieBuilder.asset("assest/mX2qe5gUvP.json"));
          } else {
            return acceptedtabsellercotroller.sentItems.isEmpty
                ? ListView(
                    // Wrap with ListView to make it scrollable for RefreshIndicator
                    children: [
                      // Center the content
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assest/empty.png'),
                            SizedBox(height: 10.sp),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                    ],
                  )
                : ListView.builder(
                    itemCount: acceptedtabsellercotroller.sentItems.length,
                    itemBuilder: (context, index) {
                      var data = acceptedtabsellercotroller.sentItems[index];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AcceptedSellerCard(
                          yourName: data.yourName,
                          category: data.storeCategory,
                          subCategories: data.storeSubCategory,
                          brands: data.brands,
                          date: data.date,
                          modelNo: data.modelNo,
                          oty: data.quantity.toString(),
                          size: data.size.toString(),
                          units: data.units,
                          des: data.requirementInDetails,
                          quote: data.quote,
                          image: data.addImage,
                          exactImage: data.exactSimilarImage,
                          exact: data.exact,
                          addImage: data.addImage,
                          mobile: data.mobile,
                          requirementId: data.requirementId,
                          profileImage: data.profileImage,
                        ),
                      );
                    },
                  );
          }
        }),
      ),
    );
  }
}
