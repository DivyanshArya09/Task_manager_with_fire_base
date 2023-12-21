import 'package:flutter/material.dart';

class AppColors {
  // Define your custom colors here
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.white,
      Color(0xC0FFFFFF),
      Color(0xFFFFFFFF),
      Color(0x7DFFFFFF),
      Color.fromARGB(206, 255, 255, 255),
    ],
  );
  static const Color secondaryColor = Color(0xFF789ABC);
  static const Color text = Color(0xFFFFFFFF);
  static const Color accentColor = Color(0xFFDEF123);
  static const Color primary = Color.fromARGB(255, 82, 88, 237);
  static const Color unHighlight = Color.fromARGB(255, 142, 143, 144);

  // Add more color constants as needed

  // Example: static const Color myCustomColor = Color(0xFFABCDEF);
}
