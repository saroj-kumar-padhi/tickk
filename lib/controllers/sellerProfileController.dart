import 'package:dekhlo/models/sellerProfieModel.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SellerProfileController extends GetxController {
  final String mobileNo;
  SellerProfileController(this.mobileNo);
  RxBool isLoading = false.obs;

  User? user = User(
      id: "",
      mobile: "",
      yourName: "",
      email: "",
      gender: "",
      age: 12,
      otp: 123456,
      fcm: "hcei",
      v: 0);

  @override
  void onInit() {
    // TODO: implement onInit
    fetchProfile();

    super.onInit();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      user = await restClient.getProfileDetails(int.parse(mobileNo));
    } catch (e) {
      Logger().d(e);
    }
    isLoading.value = false;
  }
}
