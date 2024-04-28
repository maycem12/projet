import 'package:application/admin/admin.dart';
import 'package:application/admin/controlle_page.dart';
import 'package:application/materiels/materielsadmin.dart';
import 'package:application/surveillance/surveillanceAdmin.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class NotificationAdmin extends StatefulWidget {
  const NotificationAdmin({super.key});

  @override
  State<NotificationAdmin> createState() => _NotificationAdminState();
}

class _NotificationAdminState extends State<NotificationAdmin> {
  final databaseReference = FirebaseDatabase.instance.ref('Notifications');
  List<NotificationModel> notifications = [];
  List<NotificationModel> filteredNotifications = [];

  @override
  void initState() {
    super.initState();
    _getNotifications();
  }

  void _getNotifications() async {
    final snapshot = await databaseReference.once();
    // Vérifiez si la snapshot contient des données
    if (snapshot.snapshot.value != null) {
      final data = snapshot.snapshot.value as Map<dynamic, dynamic>;
      data.forEach((key, value) {
        final notification = NotificationModel.fromJson(value);
        notifications.add(notification);
      });
      setState(() {
        filteredNotifications = List.from(notifications);
      });
    }
  }

  void _filterNotifications(String query) {
    setState(() {
      filteredNotifications = notifications.where((notification) {
        // Filter notifications by formattedDate
        return notification.formattedDate
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Historiques des Vols',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 29, 6, 121),
        leading: GestureDetector(
          onTap: () {
            // Utilisez Navigator pour naviguer vers la page d'accueil
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const AdminPage()),
              (Route<dynamic> route) => false,
            );
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ), // Ajoutez une icône de retour
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged:
                  _filterNotifications, // Call filter function on text change
              decoration: InputDecoration(
                labelText: 'Rechercher par date',
                prefixIcon: Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 225, 81, 24),
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredNotifications.length,
              itemBuilder: (context, index) {
                final notification = filteredNotifications[index];
                return ListTile(
                  title: Text(notification.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${notification.formattedDate} ${notification.formattedTime}',
                      ),
                      Text(
                        notification.body,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 29, 6, 121),
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(
                    Icons.notifications,
                    color: Color.fromARGB(255, 225, 81, 24),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(),
    );
  }

  Widget NavigationBar() {
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
                const BottomNavigationBarItem(
                  label: 'Historiques',
                  icon: Icon(
                    Icons.history,
                    size: 30,
                    color: Color.fromARGB(255, 29, 6, 121),
                  ),
                  // Ajoutez la propriété suivante pour la couleur bleue du label
                  activeIcon: Icon(
                    Icons.history,
                    size: 30,
                    color: Color.fromARGB(255, 29, 6, 121),
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
}

class NotificationModel {
  final String title;
  final String body;
  final String formattedDate;
  final String formattedTime;

  NotificationModel({
    required this.title,
    required this.body,
    required this.formattedDate,
    required this.formattedTime,
  });

  factory NotificationModel.fromJson(Map<dynamic, dynamic> json) {
    return NotificationModel(
      title: json['title'] as String,
      body: json['body'] as String,
      formattedDate: json['formattedDate'] as String,
      formattedTime: json['formattedTime'] as String,
    );
  }
}
