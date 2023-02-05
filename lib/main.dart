import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toto/utils/assets.dart';
import 'package:toto/welcomePage.dart';
import './forgetpassword.dart';
//import 'package:intl/intl.dart';
import './CreateAccount.dart';
import './home.dart';
import 'utils/custom_loader.dart';
import 'utils/loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  runApp(const MyApp());
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
                // initialBinding: Binding(),
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
                home: welcome(),
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
