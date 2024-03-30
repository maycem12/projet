import 'package:application/screens/homescreen.dart';
import 'package:application/screens/onboarding.dart';
import 'package:application/services/auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final AuthServices auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<bool>(
          future: auth.isFirstTimeUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.data == true) {
                return const HomeScreen();
              } else {
                return const OnBoardingScreen();
              }
            }
          },
        ),
      ),
    );
  }
}
