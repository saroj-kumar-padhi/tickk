import 'package:dekhlo/controllers/languageController.dart';
import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:dekhlo/utils/components/buttons.dart';
import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/components/textstyle.dart';

class Lag extends StatelessWidget {
  const Lag({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // Wrap the list with RxList and .obs to make it observable
    final LanguageController languageController = Get.put(LanguageController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: GlobalSizes.getDeviceHeight(context) * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: GlobalSizes.getDeviceWidth(context) * 0.06,
                  vertical: GlobalSizes.getDeviceHeight(context) * 0.02),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Choose your app Language",
                    style: GoogleFonts.openSans(
                        fontSize: 17, fontWeight: FontWeight.w600),
                  )),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3.8 / 2,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      // onTap: () {
                      //   languageController.laguageTile[index].select =
                      //       !languageController.laguageTile[index].select;
                      //   languageController.laguageTile.refresh();
                      // },
                      onTap: () {
                        // Deselect all items
                        languageController.isTileSeclected.value = true;
                        for (int i = 0;
                            i < languageController.laguageTile.length;
                            i++) {
                          languageController.laguageTile[i].select = false;
                        }

                        // Select the tapped item
                        languageController.laguageTile[index].select = true;

                        // Refresh the UI
                        languageController.laguageTile.refresh();
                      },

                      child: Obx(() {
                        return Container(
                          height: size.height * 0.1,
                          width: size.width * 0.2,
                          decoration: BoxDecoration(
                            color: languageController.laguageTile[index].select
                                ? const Color(0xffFC8019)
                                : languageController.laguageTile[index].color,
                            borderRadius: BorderRadius.circular(
                                8), // Set border radius here
                          ),
                          margin: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                languageController.laguageTile[index].text,
                                style: TextStyles.openSans(fontSize: 18),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  languageController
                                      .laguageTile[index].nativeLang,
                                  style: TextStyles.openSans(fontSize: 16),
                                ),
                              ),
                            ],
                          )),
                        );
                      }),
                    );
                  },
                  itemCount: languageController.laguageTile.length,
                ),
              ),
            ),
            Obx(() {
              if (languageController.isTileSeclected.value) {
                return Buttons.longButton(
                  buttonText: "Next",
                  color: const Color(0xffFC8019),
                  textColor: Colors.white,
                  context: context,
                  onPressedCallback: () async {
                    // Get.toNamed(RouteName.homeBuyerScreen);

                    Get.toNamed(RouteName.basicDetails);
                    // to be continued
                  },
                );
              } else {
                return Buttons.longButton(
                  buttonText: "Next",
                  color: const Color(0xffbea77e),
                  textColor: Colors.white,
                  context: context,
                  onPressedCallback: () {
                    // Get.toNamed(RoutesN)
                    // to be continued
                    Fluttertoast.showToast(
                        msg: 'Select a language',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
