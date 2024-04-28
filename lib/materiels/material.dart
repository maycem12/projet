import 'package:application/data/globals.dart';
import 'package:application/materiels/Ajouter.dart';
import 'package:application/materiels/ListMateriels.dart';
import 'package:application/screens/NotificationScreen.dart';
import 'package:application/screens/homescreen.dart';
import 'package:application/surveillance/surveillance.dart';
import 'package:application/utiles/constant.dart';
import 'package:flutter/material.dart';

class MaterielsPage extends StatefulWidget {
  const MaterielsPage({super.key});

  @override
  State<MaterielsPage> createState() => _MaterielsPageState();
}

class _MaterielsPageState extends State<MaterielsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber[900],
          title: const Text(
            'Gestion des matériels',
            style:
                TextStyle(color: Color.fromARGB(255, 6, 47, 81), fontSize: 20),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.assignment_sharp,
                  size: 30,
                  color: Color.fromARGB(255, 6, 47, 81),
                ),
                child: Text(
                  'Ajouter',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.edit_attributes,
                  size: 30,
                  color: Color.fromARGB(255, 6, 47, 81),
                ),
                child: Text(
                  'List',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
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
        body: const TabBarView(
          children: [
            Ajouter(),
            ListMateriels(),
          ],
        ),
        bottomNavigationBar: NavigationBar(context),
      ),
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
              const BottomNavigationBarItem(
                label: 'Matériels',
                icon: Icon(
                  Icons.assignment_sharp,
                  size: 30,
                  color: Color.fromARGB(255, 29, 6, 121),
                ),
              ),
              BottomNavigationBarItem(
                label: 'Surveillance',
                icon: GestureDetector(
                  onTap: () {
                    if (currentUser != null) {
                      if (currentUser!.enable) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Surveillancc(),
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
                      Icons.camera_alt_outlined,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
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
