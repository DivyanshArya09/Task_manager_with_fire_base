import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_app_with_firebase/screens/onboardingScreen/widgets/pageWidget.dart';

import '../authScreens/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();
  bool lastpage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
            onPageChanged: (value) {
              if (value == 2) {
                setState(() {
                  lastpage = true;
                });
              }
            },
            controller: pageController,
            children: const [
              PageOne(
                content:
                    'Welcome to our Todo app - the ultimate tool for staying organized and boosting productivity!',
                pngUrl:
                    'https://assets6.lottiefiles.com/packages/lf20_4wledibb.json',
              ),
              PageOne(
                content:
                    'Unlock your full potential and accomplish more than you ever thought possible with our Todo app - your key to productivity and success!',
                pngUrl:
                    'https://assets5.lottiefiles.com/packages/lf20_v9cc6fwd.json',
              ),
              PageOne(
                content:
                    'Get started on your journey to efficient task management and start conquering your to-do list with our user-friendly Todo app today!',
                pngUrl:
                    'https://assets2.lottiefiles.com/packages/lf20_vnnr8lra.json',
              ),
            ]),
        Container(
            alignment: const Alignment(0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    pageController.jumpToPage(2);
                  },
                  child: const Text("Skip"),
                ),
                SmoothPageIndicator(controller: pageController, count: 3),
                lastpage
                    ? TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 32, 38, 221),
                        )),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const Text("Done",
                            style: TextStyle(color: Colors.white)),
                      )
                    : GestureDetector(
                        onTap: () {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: const Text("Next"),
                      ),
              ],
            )),
      ]),
    );
  }
}
