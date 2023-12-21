import 'package:flutter/material.dart';
import 'package:todo_app_with_firebase/consts/colors.dart';

class GridButton extends StatelessWidget {
  final VoidCallback onTap;
  const GridButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                offset: const Offset(0, 4),
                blurRadius: 10,
                spreadRadius: 2,
              ),
              const BoxShadow(
                color: Colors.white,
                offset: Offset(0, -2),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(
            Icons.add,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
