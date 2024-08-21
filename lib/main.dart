import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dekhlo/firebase_options.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:dekhlo/services/notificationServices.dart';
import 'package:dekhlo/utils/no_internet.dart';
import 'package:dekhlo/utils/pagenotfound.dart';
import 'package:dekhlo/views/buyer_view/home_screen_buyer.dart/home_screenBuyer.dart';

import 'package:dekhlo/views/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dekhlo/utils/routes/routes_controller.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'views/seller_views/seller_home_screens/seller_home.dart';

import 'package:hive_flutter/hive_flutter.dart';

/// The main function initializes various services and retrieves a Firebase Cloud Messaging token to
/// send push notifications.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('myBox');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// This block of code in the `main` function is responsible for initializing Firebase Cloud Messaging
  /// (FCM) services and handling push notifications in the Flutter application. Here's a breakdown of
  /// what each step does:
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  PushNotificationServices notificationServices = PushNotificationServices();
  notificationServices.requestNotificationPermission();
  notificationServices.firebaseInit();
  final box = Hive.box('myBox');
  final String formattedPhoneNumber = box.get('phone') ?? "";

  if (formattedPhoneNumber != "") {
    try {
      Logger().d(fcmToken);
      await restClient.fcmCreation(formattedPhoneNumber, {"FCM": fcmToken});
    } catch (e) {
      Logger().d(e);
    }
  }
  // notificationServices.clearAllNotifications();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingHandler);
  runApp(const MyApp());
}

/// The function `firebaseMessagingHandler` initializes Firebase and handles incoming remote messages
/// asynchronously.
///
/// Args:
///   message (RemoteMessage): The `message` parameter in the `firebaseMessagingHandler` function is of
/// type `RemoteMessage`. This parameter represents the message received from Firebase Cloud Messaging
/// (FCM) and contains information such as the data payload, notification payload, and message metadata.
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
        title: 'Tickk',
        // home: const OTP(),

        home: const AuthWrapper(),

        // home: const Phone(),
        getPages: AppPages.pages,
      ),
    );
  }
}

/// The `AuthWrapper` class in Dart is responsible for checking the user's status and displaying the
/// appropriate widget based on the response, handling cases such as internet connectivity, user roles,
/// and error scenarios.
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
    final box = Hive.box('myBox');
    final String formattedPhoneNumber = box.get('phone') ?? "";
    Logger().d(formattedPhoneNumber);
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (!connectivityResult.contains(ConnectivityResult.mobile) &&
        !connectivityResult.contains(ConnectivityResult.wifi)) {
      setState(() {
        destinationWidget = const NoInternet();
        isLoading = false;
      });
      return;
    }

    /// This block of code is responsible for checking the user's status based on their phone number and
    /// determining the appropriate destination widget to display in the application. Here's a breakdown of
    /// what it does:
    try {
      final response =
          await restClient.checkBuyerOrSeller(int.parse(formattedPhoneNumber));

      if (response.message == 'Mobile registered for buyer') {
        destinationWidget = const HomeBuyer();
      } else if (response.message == 'Mobile registered for buyer and seller') {
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

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: LottieBuilder.asset("assest/mX2qe5gUvP.json")),
      );
    } else {
      return destinationWidget ?? const Pagenotfound();
    }
  }
}
