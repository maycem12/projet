import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:application/admin/admin.dart';
import 'package:application/model/user.dart';
import 'package:application/screens/menu.dart';
import 'package:application/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthServices auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    final userm = Provider.of<UserM>(context);
    UserM.currentUser = userm;
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(
          title: const Text("Home Page"),
          backgroundColor: Colors.blue,
          actions: [
            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  backgroundImage:
                      userm.image.isNotEmpty ? NetworkImage(userm.image) : null,
                  child: userm.image.isEmpty
                      ? null
                      : const Icon(Icons.person, color: Colors.black),
                ),
                Text(userm.np),
                IconButton(
                    icon: const Icon(Icons.person),
                    onPressed: () async {
                      await auth.signOut();
                      setState(() {});
                    }),
              ],
            )
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

            //utilisateurs
            buildUserManagementButton(userm),
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

  Widget buildUserManagementButton(UserM userm) {
    if (userm.admin) {
      return MaterialButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => const AdminPage()));
        },
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
                  'Gestion des utilisateurs',
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
      );
    } else {
      // ignore: prefer_const_constructors
      return SizedBox(
          height:
              0); // Retourne un SizedBox pour ne pas afficher le bouton si l'utilisateur n'est pas administrateur
    }
  }
}
