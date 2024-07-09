import 'package:dekhlo/firebase_options.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:dekhlo/services/notificationServices.dart';
import 'package:dekhlo/views/buyer_view/home_screen_buyer.dart/home_screenBuyer.dart';
import 'package:dekhlo/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dekhlo/utils/routes/routes_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import 'views/seller_views/seller_home_screens/seller_home.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  PushNotificationServices notificationServices = PushNotificationServices();
  notificationServices.requestNotificationPermission();
  notificationServices.firebaseInit();
  User? user = FirebaseAuth.instance.currentUser;
  String phoneNumber = user?.phoneNumber ?? "";
  String formattedPhoneNumber =
      phoneNumber.isNotEmpty ? phoneNumber.substring(3) : "";

  try {
    Logger().d(fcmToken);
    await restClient.fcmCreation(formattedPhoneNumber, {"FCM": fcmToken});
  } catch (e) {
    Logger().d(e);
  }
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingHandler);
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 742),
      minTextAdapt: true,
      builder: (BuildContext context, child) => GetMaterialApp(
        theme: ThemeData(
          useMaterial3: false,
          primaryColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: const AuthWrapper(),
        // home: const HomeSeller(
        //   storeId: 'TS156235HP',
        // ),
        // home: const HomeBuyer(),
        // home: const Login(),

        getPages: AppPages.pages,
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool isLoading = true;
  Widget? destinationWidget;

  @override
  void initState() {
    super.initState();
    checkUserStatus();
  }

  Future<void> checkUserStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    String phoneNumber = user?.phoneNumber ?? "";
    String formattedPhoneNumber =
        phoneNumber.isNotEmpty ? phoneNumber.substring(3) : "";

    if (user != null) {
      try {
        final response = await restClient
            .checkBuyerOrSeller(int.parse(formattedPhoneNumber));

        if (response.message == 'Mobile registered for buyer') {
          destinationWidget = const HomeBuyer();
        } else if (response.message ==
            'Mobile registered as both buyer and seller') {
          try {
            final storeData =
                await restClient.checkStoreId(int.parse(formattedPhoneNumber));
            final storeId = storeData.StoreID;
            Logger().d(storeId);
            destinationWidget = HomeSeller(storeId: storeId.toString());
          } catch (e) {
            print('Error fetching store ID: $e');
            destinationWidget = const Login();
          }
        } else {
          destinationWidget = const Login();
        }
      } catch (e) {
        print('Error checking buyer or seller: $e');
        destinationWidget = const Login();
      }
    } else {
      destinationWidget = const Login();
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xffFC8019),
        body: Center(
          child: LoadingAnimationWidget.inkDrop(
              color: const Color(0xffE4E4E4), size: 200),
        ),
      );
    } else {
      return destinationWidget ?? const Login();
    }
  }
}
