import 'package:flutter/material.dart';
import 'package:todo_app_with_firebase/consts/colors.dart';

class TextButtonStyle {
  static ButtonStyle defaultStyle = TextButton.styleFrom(
    // foregroundColor: Colors.black,
    // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    backgroundColor: AppColors.primary,
    textStyle:
        const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    // minimumSize: Size(0, 40),
    elevation: 0,
  );
}
