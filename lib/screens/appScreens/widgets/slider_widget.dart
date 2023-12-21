import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../consts/colors.dart';

class SliderScreen extends StatelessWidget {
  final String url, quote;
  const SliderScreen({super.key, required this.url, required this.quote});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            url,
            height: size.height * .2,
          ),
          const Divider(),
          SizedBox(
            width: size.width * .5,
            child: Text(quote,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                )),
          ),
        ],
      ),
    );
  }
}
