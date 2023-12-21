import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_firebase/consts/colors.dart';
import 'package:todo_app_with_firebase/screens/appScreens/model/fire_store_model.dart';
import 'package:todo_app_with_firebase/screens/authScreens/sign_up_screen.dart';
import 'package:todo_app_with_firebase/screens/successScreen/login_sccess.dart';
import 'package:todo_app_with_firebase/utils/utils_toast.dart';
import 'package:todo_app_with_firebase/widgets/reuseable_button.dart';

import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 800),
              child: SvgPicture.asset(
                'assets/login2.svg',
                height: size.height * .4,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInDown(
                        duration: const Duration(milliseconds: 1000),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FadeInDown(
                        duration: const Duration(milliseconds: 1200),
                        // Text form field
                        child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email id';
                              } else {
                                return null;
                              }
                            },
                            controller: email,
                            decoration: const InputDecoration(
                                hintText: 'Email ID',
                                prefixIcon: Icon(
                                  Icons.attach_email_outlined,
                                  color: AppColors.unHighlight,
                                ))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeInDown(
                        duration: const Duration(milliseconds: 1400),
                        child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              } else {
                                return null;
                              }
                            },
                            controller: password,
                            obscureText: true,
                            decoration: const InputDecoration(
                                hintText: 'Password',
                                prefixIcon: Icon(
                                  Icons.lock_outline_rounded,
                                  color: AppColors.unHighlight,
                                ))),
                      ),
                    ]),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            FadeInDown(
                duration: const Duration(milliseconds: 1600),
                child: ReuseableButton(
                    text: 'Login',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                        await authService
                            .signInWithEmailAndPassword(
                                email.text.toString(), password.text.toString())
                            .then((value) {
                          categoryModel.email = email.text.toString();
                          // FireStoreServices.dummyData(email.text.toString());
                          // FireStoreServices.dummyData(email.text);
                          // FireStoreServices.dummyData(email.text.toString());

                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginSuccessFul(),
                            ),
                          );
                        }).onError((error, stackTrace) {
                          Utils().toastMessage(error.toString(), true);
                          Navigator.pop(context);
                        });
                      }
                    })),
            const SizedBox(
              height: 20,
            ),
            FadeInDown(
              duration: const Duration(milliseconds: 1800),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ));
                      })
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
