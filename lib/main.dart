// ignore_for_file: prefer_const_constructors

import 'package:application/firebase_options.dart';
import 'package:application/model/user.dart';
import 'package:application/screens/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<UserM>(
        create: (context) =>
            UserM(id: '', email: '', np: ''), // Providing an instance of UserM
        child: OnBoardingScreen(),
      ),
    );
  }
}
