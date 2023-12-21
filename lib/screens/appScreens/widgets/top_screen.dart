import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_firebase/screens/appScreens/widgets/slider_widget.dart';
import 'package:todo_app_with_firebase/services/auth_service.dart';
import 'package:todo_app_with_firebase/styles/text_button_style.dart';

import '../../../consts/colors.dart';
import '../../authScreens/login_screen.dart';

class CarouselSliderContainer extends StatelessWidget {
  const CarouselSliderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<AuthService>(context);
    Size size = MediaQuery.of(context).size;
    List items = [
      ["assets/motivation2.svg", "Turn your to-dos into ta-das!"],
      [
        "assets/motivation2.svg",
        "Keep your face towards the sunshine and let the shadows fall behind you."
      ],
      ["assets/motivation3.svg", "Turn your to-dos into ta-das!"],
    ];
    return Container(
        height: size.height * .48,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          // borderRadius: BorderRadiusDirectional.only(
          //   bottomEnd: Radius.circular(),
          //   bottomStart: Radius.circular(250),
          // )),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 30,
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Welcome, ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          )),
                      TextSpan(
                          text: AuthService.userName,
                          style: const TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ))
                    ],
                  )),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('Are you sure you want to logout?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    myProvider.signOut().then((value) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()),
                                      );
                                    });
                                  },
                                  style: TextButtonStyle.defaultStyle,
                                  child: const Text('Confirm',
                                      style: TextStyle(color: Colors.white)),
                                )
                              ],
                            );
                          });
                    },
                    icon: const Icon(Icons.logout),
                    color: Colors.white,
                  ),
                ],
              ),
              CarouselSlider.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index, index2) {
                    return SliderScreen(
                      url: items[index][0],
                      quote: items[index][1],
                    );
                  },
                  options: CarouselOptions(
                    viewportFraction: 1,
                    autoPlay: true,
                    pageSnapping: true,
                  )),
            ],
          ),
        ));
  }
}
