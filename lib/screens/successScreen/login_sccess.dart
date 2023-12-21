import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app_with_firebase/screens/appScreens/home_screen.dart';

class LoginSuccessFul extends StatefulWidget {
  const LoginSuccessFul({super.key});

  @override
  State<LoginSuccessFul> createState() => _LoginSuccessFulState();
}

class _LoginSuccessFulState extends State<LoginSuccessFul> {
  @override
  void initState() {
    // TODO: implement initState
    navigateToLoginScreen();
    super.initState();
  }

  void navigateToLoginScreen() {
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (
          context,
        ) =>
                const AppScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LottieBuilder.asset(
          'assets/new.json',
          height: size.height * .7,
        ),
      ),
    );
  }
}
