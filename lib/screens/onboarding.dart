// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:application/screens/onboardingcontroller.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    final Controller = OnBoardingController.instance;

    return Scaffold(
        body: Stack(
      children: [
        //photooooooooooooooooo
        PageView(
          controller: controller.pageController,
          onPageChanged: controller.updatePageIndicator,
          children: const [
            OnBoardingPage(
                image: "images/pSodLefOBR.gif",
                title: "Sécurité Industrielle Renforcée",
                subTitle:
                    "Protégez l'intégrité de votre usine avec ELEONETECH SECURITY. Notre solution anti-vol offre une sécurité robuste pour vos équipements et installations."),
            OnBoardingPage(
                image: "images/Alert.gif",
                title: " Alertes en Temps Réel",
                subTitle:
                    "Recevez des alertes instantanées en cas d'intrusion ou d'activité suspecte. Soyez informé rapidement pour prendre des mesures immédiates."),
            OnBoardingPage(
                image: "images/mobile_development2.gif",
                title: "Surveillance à Distance",
                subTitle:
                    "Surveillez votre usine où que vous soyez. ELEONETECH SECURITY permet une surveillance à distance pour assurer la sécurité continue de votre site."),
          ],
        ),
        //bouton Skiiiiiiiiiiiiiiiiiiip
        Positioned(
          top: kToolbarHeight,
          right: 5,
          child: TextButton(
            onPressed: () => OnBoardingController.instance.skipPage(),
            child: const Text('ignorer'),
          ),
        ),
        //DOTTT navigator
        Positioned(
            bottom: 50,
            left: 20,
            child: SmoothPageIndicator(
                controller: Controller.pageController,
                onDotClicked: controller.dotNavigationClick,
                count: 3,
                effect: ExpandingDotsEffect(
                    activeDotColor: Colors.blueGrey, dotHeight: 6))),
        //boutton
        Positioned(
            right: 20,
            bottom: 40,
            child: ElevatedButton(
              onPressed: () => OnBoardingController.instance.nextPage(),
              style: ElevatedButton.styleFrom(shape: CircleBorder()),
              child: const Icon(Icons.last_page),
            ))
      ],
    ));
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image(width: 600, height: 600, image: AssetImage(image)),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
