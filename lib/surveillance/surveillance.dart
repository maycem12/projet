import 'package:application/data/globals.dart';
import 'package:application/materiels/material.dart';
import 'package:application/screens/NotificationScreen.dart';
import 'package:application/screens/homescreen.dart';
import 'package:application/utiles/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

class Surveillancc extends StatefulWidget {
  const Surveillancc({super.key});

  @override
  State<Surveillancc> createState() => _SurveillanccState();
}

class _SurveillanccState extends State<Surveillancc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surveillance'),
        leading: GestureDetector(
          onTap: () {
            // Utilisez Navigator pour naviguer vers la page d'accueil
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (Route<dynamic> route) => false,
            );
          },
          child: const Icon(Icons.arrow_back), // Ajoutez une icône de retour
        ),
      ),
      body: const Center(
          child: Mjpeg(isLive: true, stream: 'http://192.168.100.166/mjpeg/1')),
      bottomNavigationBar: NavigationBar(context),
    );
  }
}

Widget NavigationBar(BuildContext context) {
  return Container(
    color: Colors.white,
    child: Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 5,
          blurRadius: 10,
        ),
      ]),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: BottomNavigationBar(
            selectedItemColor: const Color.fromARGB(255, 29, 6, 121),
            selectedFontSize: 12,
            unselectedFontSize: 12,
            unselectedItemColor: Colors.grey.withOpacity(0.7),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                label: 'Acceuil',
                icon: GestureDetector(
                  onTap: () {
                    if (currentUser != null) {
                      if (currentUser!.enable) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      } else {
                        messages("Votre compte a été bloqué");
                      }
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.home,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: 'Matériels',
                icon: GestureDetector(
                  onTap: () {
                    if (currentUser != null) {
                      if (currentUser!.enable) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MaterielsPage(),
                          ),
                        );
                      } else {
                        messages("Votre compte a été bloqué");
                      }
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.assignment_sharp,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const BottomNavigationBarItem(
                label: 'Surveillance',
                icon: Icon(
                  Icons.camera_alt_outlined,
                  size: 30,
                  color: Color.fromARGB(255, 29, 6, 121),
                ),
              ),
              BottomNavigationBarItem(
                label: 'Historiques',
                icon: GestureDetector(
                  onTap: () {
                    if (currentUser != null) {
                      if (currentUser!.enable) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationScreen(),
                          ),
                        );
                      } else {
                        messages("Votre compte a été bloqué");
                      }
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.history,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ]),
      ),
    ),
  );
}
