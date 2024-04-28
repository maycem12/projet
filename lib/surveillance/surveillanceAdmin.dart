import 'package:application/admin/NotificationAdmin.dart';
import 'package:application/admin/admin.dart';
import 'package:application/admin/controlle_page.dart';
import 'package:application/materiels/materielsadmin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

class SurveillanceAdmin extends StatefulWidget {
  const SurveillanceAdmin({super.key});

  @override
  State<SurveillanceAdmin> createState() => _SurveillanceAdminState();
}

class _SurveillanceAdminState extends State<SurveillanceAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surveillance'),
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
      body: const Center(
        child: Mjpeg(
          isLive: true,
          stream: 'http://192.168.100.166/mjpeg/1',
          timeout:
              Duration(seconds: 10), // Définir le délai d'attente à 10 secondes
        ),
      ),
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
              const BottomNavigationBarItem(
                label: 'Surveillance',
                icon: Icon(
                  Icons.camera_alt_rounded,
                  size: 30,
                  color: Color.fromARGB(255, 29, 6, 121),
                ),
              ),
              BottomNavigationBarItem(
                label: 'Historiques ',
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
