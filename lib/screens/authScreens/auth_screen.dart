import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_firebase/screens/appScreens/home_screen.dart';
import 'package:todo_app_with_firebase/screens/appScreens/model/fire_store_model.dart';
import 'package:todo_app_with_firebase/screens/onboardingScreen/on_boarding_screen.dart';

import '../../models/user_model.dart';
import '../../services/auth_service.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          categoryModel.email = snapshot.data!.email.toString();
          return const AppScreen();
        }
        return const OnBoardingScreen();
      },
    );
  }
}
