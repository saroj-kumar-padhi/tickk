// import 'package:dekhlo/firebase_options.dart';
// import 'package:dekhlo/services/injection.dart';
// import 'package:dekhlo/views/buyer_view/home_screen_buyer.dart/home_screenBuyer.dart';
// import 'package:dekhlo/views/login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// import 'package:dekhlo/utils/routes/routes_controller.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:logger/web.dart';

// import 'models/isBuyer.dart';
// import 'views/seller_views/seller_home_screens/seller_new.dart'; // Ensure this import is correct

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(360, 742),
//       minTextAdapt: true,
//       builder: (BuildContext context, child) => GetMaterialApp(
//         theme: ThemeData(
//           useMaterial3: false,
//           primaryColor: Colors.white,
//           appBarTheme: const AppBarTheme(
//             backgroundColor: Colors.white,
//           ),
//           scaffoldBackgroundColor: Colors.white,
//         ),
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         home: const AuthWrapper(),
//         getPages: AppPages.pages,
//       ),
//     );
//   }
// }

// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     User? user = FirebaseAuth.instance.currentUser;
//     String PhoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber ?? "";
//     String formattedPhoneNumber = PhoneNumber.substring(3);

//     if (user != null) {
//       return FutureBuilder<BuyerResponse>(
//         future: restClient.checkBuyerOrSeller(int.parse(formattedPhoneNumber)),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Scaffold(
//               backgroundColor: const Color(0xffFC8019),
//               body: Center(
//                 child: LoadingAnimationWidget.inkDrop(
//                     color: const Color(0xffE4E4E4), size: 200),
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return const Center(child: Text('Error occurred'));
//           } else if (snapshot.hasData) {
//             final response = snapshot.data!;
//             if (response.message == 'Mobile registered for buyer') {
//               return const HomeBuyer();
//             } else if (response.message ==
//                 'Mobile registered as both buyer and seller') {
//               try {
//                 dynamic storeId =
//                     restClient.checkStoreId(int.parse(formattedPhoneNumber));
//                 Logger().d(storeId);
//               } catch (e) {
//                 Logger().d(e);
//               }
//               return const HomeSeller(
//                 storeId: '',
//               ); // Replace with the seller screen
//             } else {
//               return const Login();
//             }
//           } else {
//             return const Login();
//           }
//         },
//       );
//     } else {
//       return const Login();
//     }
//   }

// }

import 'package:dekhlo/firebase_options.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:dekhlo/views/buyer_view/home_screen_buyer.dart/home_screenBuyer.dart';
import 'package:dekhlo/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dekhlo/utils/routes/routes_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import 'models/isBuyer.dart';
import 'views/seller_views/seller_home_screens/seller_home.dart'; // Ensure this import is correct

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
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
        getPages: AppPages.pages,
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String phoneNumber = FirebaseAuth.instance.currentUser?.phoneNumber ?? "";
    String formattedPhoneNumber =
        phoneNumber.isNotEmpty ? phoneNumber.substring(3) : "";

    if (user != null) {
      return FutureBuilder<BuyerResponse>(
        future: restClient.checkBuyerOrSeller(int.parse(formattedPhoneNumber)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: const Color(0xffFC8019),
              body: Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: const Color(0xffE4E4E4), size: 200),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error occurred'));
          } else if (snapshot.hasData) {
            final response = snapshot.data!;
            if (response.message == 'Mobile registered for buyer') {
              return const HomeBuyer();
            } else if (response.message ==
                'Mobile registered as both buyer and seller') {
              return FutureBuilder<dynamic>(
                future:
                    restClient.checkStoreId(int.parse(formattedPhoneNumber)),
                builder: (context, storeSnapshot) {
                  if (storeSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Scaffold(
                      backgroundColor: const Color(0xffFC8019),
                      body: Center(
                        child: LoadingAnimationWidget.inkDrop(
                            color: const Color(0xffE4E4E4), size: 200),
                      ),
                    );
                  } else if (storeSnapshot.hasError) {
                    return const Center(child: Text('Error fetching store ID'));
                  } else if (storeSnapshot.hasData) {
                    final storeData = storeSnapshot.data!;
                    final storeId = storeData.StoreID;
                    Logger().d(storeId);
                    return HomeSeller(
                      storeId: storeId.toString(),
                    );
                  } else {
                    return const Login();
                  }
                },
              );
            } else {
              return const Login();
            }
          } else {
            return const Login();
          }
        },
      );
    } else {
      return const Login();
    }
  }
}
