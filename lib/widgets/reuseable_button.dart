import 'package:flutter/material.dart';
import 'package:todo_app_with_firebase/consts/colors.dart';

class ReuseableButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const ReuseableButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(text)),
    );
  }
}
