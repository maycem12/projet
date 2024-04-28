import 'dart:async';

import 'package:application/admin/NotificationAdmin.dart';
import 'package:application/admin/controlle_page.dart';
import 'package:application/data/globals.dart';
import 'package:application/materiels/materielsadmin.dart';
import 'package:application/screens/faceregonition.dart';
import 'package:application/screens/loginAdmin.dart';
import 'package:application/screens/menu.dart';
import 'package:application/services/auth.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  AuthServices auth = AuthServices();
  final List<String> imagePaths = [
    "images/ele.jpg",
    "images/mayrou.jpg",
    "images/11.jpg",
    "images/1.jpg",
    "images/ll.jpg",
    "images/3.jfif",
    "images/222.jpg",
    "images/4.jfif",
    "images/jj.jpg",
  ];
  late List<Widget> _pages;
  int _activePage = 0;
  final PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 1,
  );
  Timer? _timer;
  @override
  //void initState() {
  //super.initState();
  //auth = AuthServices(); // Initialisation de l'objet auth ici
  //}
  @override
  void initState() {
    super.initState();
    _pages = List.generate(
        imagePaths.length,
        (index) => ImagePlaceholder(
              imagePath: imagePaths[index],
            ));
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.page == imagePaths.length - 1) {
        _pageController.animateToPage(0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      } else {
        _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(
          title: const Text(
            "Eleontech Security",
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 29, 6, 121),
          actions: [
            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  backgroundImage: currentUser?.image != null
                      ? NetworkImage(currentUser!.image)
                      : null,
                  child: currentUser?.image == null
                      // ignore: prefer_const_constructors
                      ? Icon(Icons.person,
                          color: const Color.fromARGB(255, 29, 6, 121))
                      : null,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  currentUser!.np,
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
              ],
            ),
            IconButton(
                icon: const Icon(
                  Icons.power_settings_new,
                  color: Colors.white,
                ),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                            title: const Text("Déconnection"),
                            content:
                                const Text("Voulez-vous vous déconnecter?"),
                            actions: [
                              ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text("Non"),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await auth.signOut();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginAdmin()),
                                  );
                                },
                                child: const Text("Oui"),
                              ),
                            ]);
                      });
                }),
          ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.744,
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount: imagePaths.length,
                      onPageChanged: (value) {
                        setState(() {
                          _activePage = value;
                        });
                      },
                      itemBuilder: ((context, index) {
                        return _pages[index];
                      })),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(
                            _pages.length,
                            (index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: InkWell(
                                    onTap: () {
                                      _pageController.animateToPage(index,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeIn);
                                    },
                                    child: CircleAvatar(
                                      radius: 4,
                                      backgroundColor: _activePage == index
                                          ? Colors.amber
                                          : Colors.grey,
                                    ),
                                  ),
                                ))),
                  ),
                )
              ],
            ),
          ],
        ),
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
                const BottomNavigationBarItem(
                  label: 'Acceuil',
                  icon: Icon(
                    Icons.home,
                    size: 30,
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
                          builder: (context) => ImageFromFirestore(),
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
}

class ImagePlaceholder extends StatelessWidget {
  final String? imagePath;
  const ImagePlaceholder({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath!,
      fit: BoxFit.cover,
    );
  }
}
