import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_firebase/screens/authScreens/auth_screen.dart';
import 'package:todo_app_with_firebase/services/auth_service.dart';
import 'package:todo_app_with_firebase/services/fire_store_services.dart';
import 'package:todo_app_with_firebase/services/todos_services.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (context) => AuthService(),
        ),
        ChangeNotifierProvider(create: (context) => FireStoreServices()),
        ChangeNotifierProvider(create: (context) => TodosServices()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: AuthScreen(),
        // home: SignUpSuccessFul(),
        // home: TaskDetail(),
        // home: AddTodo(),
        // home: AppScreen(),
      ),
    );
  }
}
