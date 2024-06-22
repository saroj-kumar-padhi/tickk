import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:dekhlo/views/buyer_view/faq_screens/faqScreen.dart';
import 'package:dekhlo/views/buyer_view/faq_screens/terms&Condition.dart';
import 'package:dekhlo/views/buyer_view/home_screen_buyer.dart/home_screenBuyer.dart';
import 'package:dekhlo/views/lang.dart';
import 'package:dekhlo/views/buyer_view/locationPages/change_location.dart';
import 'package:dekhlo/views/login.dart';
import 'package:dekhlo/views/buyer_view/notificationsScreens/buyer_notification.dart';
import 'package:dekhlo/views/buyer_view/profileScreen/buyerProfile.dart';
import 'package:dekhlo/views/seller_views/sellerProfiles/seller_profile.dart';
import 'package:dekhlo/views/seller_views/seller_home_screens/seller_home.dart';
import 'package:dekhlo/views/seller_views/seller_home_screens/storeEditScreen.dart';
import 'package:dekhlo/views/seller_views/seller_notification.dart';
import 'package:dekhlo/views/seller_views/set_up_store.dart';
import 'package:dekhlo/views/seller_views/store_screens/mystore.dart';
import 'package:dekhlo/views/singUpPages/Signup_otp.dart';
import 'package:dekhlo/views/singUpPages/Singup_phone.dart';
import 'package:get/get.dart';

import '../../views/buyer_view/faq_screens/deleteScreen.dart';
import '../../views/buyer_view/loginPages/basicDetails.dart';
import '../../views/buyer_view/loginPages/login_otp.dart';
import '../../views/buyer_view/loginPages/login_phone.dart';
import '../../views/buyer_view/postRequements/postRequements.dart';
import '../../views/buyer_view/profileScreen/editProfile.dart';
import '../../views/seller_views/custoum_category/coustoum_sub_sub.dart';
import '../../views/seller_views/custoum_category/custoumSubCategory.dart';
import '../../views/seller_views/custoum_category/custoum_category.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: RouteName.loginOptional, page: () => const Login()),
    GetPage(name: RouteName.signPhoneScreen, page: () => const Phone()),
    GetPage(name: RouteName.signOtpScreen, page: () => const OTP()),
    GetPage(name: RouteName.langScreen, page: () => const Lag()),
    GetPage(name: RouteName.logInphoneScreen, page: () => const LogInPhone()),
    GetPage(name: RouteName.logInotpScreen, page: () => const LogINOTP()),
    GetPage(name: RouteName.homeBuyerScreen, page: () => const HomeBuyer()),
    GetPage(name: RouteName.changeLocation, page: () => ChangeLocation()),
    GetPage(
        name: RouteName.postRequirements, page: () => const PostRequirements()),
    GetPage(name: RouteName.buyerProfile, page: () => const BuyerProfile()),
    GetPage(name: RouteName.editProfile, page: () => const EditProfile()),
    GetPage(
        name: RouteName.faqScreens, page: () => const ExpansionTileExample()),
    GetPage(
        name: RouteName.termsCondition, page: () => const TermsAndCondition()),
    GetPage(name: RouteName.deleteScreen, page: () => const DeleteScreen()),
    GetPage(name: RouteName.buyerNotification, page: () => BuyerNotification()),
    GetPage(name: RouteName.basicDetails, page: () => const BasicDetails()),
    GetPage(name: RouteName.setUpProduct, page: () => SetUpProduct()),
    GetPage(name: RouteName.myStore, page: () => MyStore()),
    GetPage(
        name: RouteName.sellerNotification, page: () => SellerNotification()),
    GetPage(name: RouteName.custoumCategory, page: () => CustoumCategory()),
    GetPage(
        name: RouteName.custoumSubCategory, page: () => CustoumSubCategory()),
    GetPage(
        name: RouteName.custoumSubSubCategory,
        page: () => CustoumSubSubCategory()),
    GetPage(name: RouteName.storeEditScreen, page: () => StoreEditScreen()),
    GetPage(name: RouteName.sellerProfile, page: () => const SellerProfile()),
  ];
}
