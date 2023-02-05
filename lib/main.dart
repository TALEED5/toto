// ignore_for_file: prefer_const_constructors
//<<<<<<< HEAD
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toto/BottomNavBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:toto/chat_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//=======
// no thing new again
import 'package:toto/home.dart';
import 'package:toto/searchUser.dart';
import 'package:toto/help.dart';
import 'package:toto/utils/utils/assets.dart';



//>>>>>>> c6fb5ddc85d7be78f665ff694e30f29d178d71ca
import './forgetpassword.dart';
import 'package:flutter/material.dart';

//import 'package:intl/intl.dart';
import './CreateAccount.dart';
//<<<<<<< HEAD
// tttte
//=======
import './home.dart';
import 'TaleedApp.dart';
import 'utils/utils/custom_loader.dart';
import 'utils/utils/loader.dart';

//just a comment to test github
//>>>>>>> c6fb5ddc85d7be78f665ff694e30f29d178d71ca
//import './forgetpassword.dart';
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(
//     home: CreateAccount(),//ChatScreen(),//CreateAccount(),
//     debugShowCheckedModeBanner: false,
//   ));
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
  String fcmToken;

  FirebaseMessaging.onMessage.listen((message) {
    // Handle your message here
    log("fcmToken: ${message.data}");
  });

  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

  _fcm.getToken().then((token) async {
    log("fcmToken: ${token}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fcmToken', token!);
    fcmToken = token;

    if (FirebaseAuth.instance.currentUser != null) {
      await TaleedApp().updateFCMUser(id: FirebaseAuth.instance.currentUser!.uid);
    }
    //
  });

  runApp(const MyApp());
}

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  print("sssss_myBackgroundMessageHandler ");
  // Or do other work.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, _) {
          return Stack(
            children: [
              GetMaterialApp(
                locale: const Locale("ar"),
                //fallbackLocale: Get.deviceLocale,
                localizationsDelegates: const [
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('ar', 'AE'),
                ],
                //initialBinding: Binding(),
                debugShowCheckedModeBanner: false,
                title: "قصتي",
                theme: ThemeData(
                  primaryColor: Assets.shared.primaryColor,
                  scaffoldBackgroundColor:
                      Assets.shared.scaffoldBackgroundColor,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  colorScheme: ColorScheme.fromSwatch().copyWith(
                    secondary: Assets.shared.secondaryColor,
                  ),
                  appBarTheme: AppBarTheme(
                    color: Assets.shared.primaryColor,
                  ),
                  fontFamily: Assets.shared.primaryFont,
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: Assets.shared.primaryColor,
                  ),
                ),
                home: CreateAccount(),
              ),
              GetBuilder<LoaderViewModel>(
                init: LoaderViewModel(),
                builder: (controller) {
                  return Visibility(
                    visible: controller.isActiveLoader,
                    child: const CustomLoader(),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
