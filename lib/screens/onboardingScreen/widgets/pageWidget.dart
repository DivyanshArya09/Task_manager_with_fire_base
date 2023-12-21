import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app_with_firebase/consts/colors.dart';

class PageOne extends StatelessWidget {
  final String pngUrl;
  final String content;
  const PageOne({super.key, required this.pngUrl, required this.content});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            spreadRadius: 5.0,
            offset: Offset(0, 5),
          ),
        ],
        gradient: AppColors.backgroundGradient,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                content,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 25),
              ),
              LottieBuilder.network(
                pngUrl,
                height: size.height * 0.6,
              ),
            ]),
      ),
    );
  }
}
