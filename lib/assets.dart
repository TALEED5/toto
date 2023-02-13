import 'package:flutter/material.dart';

const String _imagesPath = "assets/images/";

const String _iconsPath = "${_imagesPath}icons/";

class Assets {
  static final shared = Assets();

  // Colors

  final Color GreenColor = const Color(0xff427859);

  final Color Gcolor = Color(0xFF3D553F);

  final Color BeigeColor = Color.fromARGB(255, 219, 201, 155);

  final Color RedColor = Color(0xFF913A3A);

  final Color iconColor = Color.fromARGB(181, 93, 125, 90);

  final Color scaffoldBackgroundColor = Color.fromARGB(255, 255, 238, 228);

  final Color hintColor = Color(0xFF909A99);

  final Color lightRedOrange = Color(0xFFB36248);

  final Color darkRedOrange = Color(0xFFA03C1B);

  final Color background1 = Color(0xFFF6F4F0);

  // Fonts

  final String primaryFont = 'NeoSansArabic';

  // Icons

  final String icLogo = "${_iconsPath}ic_logo.png";

  // Images

  final String bgSplash = "${_imagesPath}bg_splash.png";
}
