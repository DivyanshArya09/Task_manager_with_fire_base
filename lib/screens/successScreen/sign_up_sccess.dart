import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_with_firebase/screens/appScreens/home_screen.dart';
import 'package:todo_app_with_firebase/services/auth_service.dart';
import '../../styles/text_button_style.dart';

class SignUpSuccessFul extends StatefulWidget {
  const SignUpSuccessFul({super.key});

  @override
  State<SignUpSuccessFul> createState() => _SignUpSuccessFulState();
}

class _SignUpSuccessFulState extends State<SignUpSuccessFul> {
  @override
  void initState() {
    // TODO: implement initState
    navigateToLoginScreen();
    super.initState();
  }

  void navigateToLoginScreen() {
    final _formKey = GlobalKey<FormState>();
    TextEditingController controller = TextEditingController();

    Timer(const Duration(seconds: 3), () {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("What's your name"),
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  AuthService.userName = controller.text.toString();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (
                        context,
                      ) =>
                          const AppScreen(),
                    ),
                  );
                },
                style: TextButtonStyle.defaultStyle,
                child: const Text(
                  'Done',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 1000),
              child: Image(
                image: const AssetImage('assets/signUpSuccess.png'),
                height: size.height * .5,
              ),
            ),
            FadeInDown(
              duration: const Duration(milliseconds: 1400),
              child: const Text(
                "Sign Up Successfull, Our todo app will help you stay organized and on track, so you can focus on what's important.",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
