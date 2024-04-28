import 'package:application/admin/NotificationAdmin.dart';
import 'package:application/admin/admin.dart';
import 'package:application/admin/controlle_page.dart';
import 'package:application/materiels/Ajouter.dart';
import 'package:application/materiels/ListMateriels.dart';
import 'package:application/surveillance/surveillanceAdmin.dart';
import 'package:flutter/material.dart';

class MaterielAdmin extends StatefulWidget {
  const MaterielAdmin({super.key});

  @override
  State<MaterielAdmin> createState() => _MaterielAdminState();
}

class _MaterielAdminState extends State<MaterielAdmin> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber[900],
            title: const Text(
              'Gestion des matériels',
              style: TextStyle(
                  color: Color.fromARGB(255, 6, 47, 81), fontSize: 20),
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
                  MaterialPageRoute(builder: (context) => const AdminPage()),
                  (Route<dynamic> route) => false,
                );
              },
              child:
                  const Icon(Icons.arrow_back), // Ajoutez une icône de retour
            ),
          ),
          body: const TabBarView(
            children: [
              Ajouter(),
              ListMateriels(),
            ],
          ),
          bottomNavigationBar: NavigationBar(context),
        ));
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
              const BottomNavigationBarItem(
                label: 'Matériels',
                icon: Icon(
                  Icons.assignment_sharp,
                  size: 30,
                  color: Color.fromARGB(255, 29, 6, 121),
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
              BottomNavigationBarItem(
                label: 'Utilisateurs',
                icon: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ControllerPage(),
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
                      Icons.admin_panel_settings,
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
