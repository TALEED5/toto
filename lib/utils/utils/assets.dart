import 'package:flutter/material.dart';

const String _imagesPath = "assets/images/";

const String _iconsPath = "${_imagesPath}icons/";

class Assets {
  static final shared = Assets();

  // Colors

  final Color primaryColor = const Color(0xff427859);

  final Color secondaryColor = const Color(0xffCCEEF7);

  final Color emptyColor = const Color(0xffa09d9d);

  final Color scaffoldBackgroundColor = const Color(0xffffffff);

  // Fonts

  final String primaryFont = 'NeoSansArabic';

  // Icons

  final String icLogo = "${_iconsPath}ic_logo.png";

  // Images

  final String bgSplash = "${_imagesPath}bg_splash.png";
}
