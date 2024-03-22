import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:application/data/globals.dart';
import 'package:application/screens/menu.dart';
import 'package:application/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthServices auth = AuthServices();
  @override
  void initState() {
    super.initState();
    auth = AuthServices(); // Initialisation de l'objet auth ici
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(
          title: const Text(
            "Page d'aceuil",
          ),
          backgroundColor: Colors.yellow,
          actions: [
            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  backgroundImage: currentUser?.image != null
                      ? NetworkImage(currentUser!.image)
                      : null,
                  child: currentUser?.image != null
                      ? Container()
                      : Icon(Icons.person, color: Colors.black),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(currentUser!.np),
              ],
            ),
            IconButton(
                icon: const Icon(Icons.person),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                            title: Text("Déconnection"),
                            content: Text("Voulez-vous vous déconnecter?"),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Non"),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await auth.signOut();
                                  setState(() {});
                                  Navigator.of(context).pop();
                                },
                                child: Text("Oui"),
                              ),
                            ]);
                      });
                }),
          ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText(
                  'Bienvenue!',
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 4, 8, 115),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),

            //materielssssssssssss
            MaterialButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        'Gestion des matériels',
                        style: GoogleFonts.robotoCondensed(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            MaterialButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        'Historique',
                        style: GoogleFonts.robotoCondensed(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),

            MaterialButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        'Paramètres',
                        style: GoogleFonts.robotoCondensed(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
