import 'package:application/admin/NotificationAdmin.dart';
import 'package:application/admin/admin.dart';
import 'package:application/admin/list_bloquer.dart';
import 'package:application/admin/list_supprimer.dart';
import 'package:application/admin/list_users.dart';
import 'package:application/materiels/materielsadmin.dart';
import 'package:application/surveillance/surveillanceAdmin.dart';
import 'package:flutter/material.dart';

class ControllerPage extends StatelessWidget {
  const ControllerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gestion des utilisateurs',
              style: TextStyle(fontSize: 20, color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 29, 6, 121),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.update,
                  size: 20,
                  color: Color.fromARGB(255, 255, 94, 7),
                ),
                child: Text(
                  'Modifier',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.block_outlined,
                  size: 20,
                  color: Color.fromARGB(255, 255, 94, 7),
                ),
                child: Text(
                  'Dé/bloquer',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.delete_forever,
                  size: 20,
                  color: Color.fromARGB(255, 255, 94, 7),
                ),
                child: Text(
                  'Supprimer',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          // Ajoutez un GestureDetector pour détecter le clic sur l'AppBar
          leading: GestureDetector(
            onTap: () {
              // Utilisez Navigator pour naviguer vers la page d'accueil
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const AdminPage()),
                (Route<dynamic> route) => false,
              );
            },
            child: const Icon(Icons.arrow_back), // Ajoutez une icône de retour
          ),
        ),
        body: const TabBarView(
          children: [
            ListUsers(),
            ListBloquer(),
            ListSupprimer(),
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
            selectedFontSize: 9,
            unselectedFontSize: 9,
            unselectedItemColor: Colors.grey.withOpacity(0.7),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                label: 'Acceuil',
                icon: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminPage(),
                      ),
                    );
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MaterielAdmin(),
                      ),
                    );
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
              BottomNavigationBarItem(
                label: 'Surveillance ',
                icon: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SurveillanceAdmin(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationAdmin(),
                      ),
                    );
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
              const BottomNavigationBarItem(
                label: 'Utilisateurs',
                icon: Icon(
                  Icons.admin_panel_settings,
                  size: 30,
                  color: Color.fromARGB(255, 29, 6, 121),
                ),
              ),
            ]),
      ),
    ),
  );
}
