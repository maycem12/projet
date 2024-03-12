// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, use_build_context_synchronously, avoid_print, curly_braces_in_flow_control_structures

import 'package:application/screens/homescreen.dart';
import 'package:application/screens/reset_page.dart';
import 'package:application/services/auth.dart';
import 'package:application/utiles/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  AuthServices auth = AuthServices();
  late String email, pass;
  final keys = GlobalKey<FormState>();
  bool hidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connectez-vous "),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: keys,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //image
                  CircleAvatar(
                    radius: 100.0,
                    backgroundImage: AssetImage('images/log.gif'),
                  ),
                  SizedBox(height: 20),
                  //title
                  Text('Connectez-vous',
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 40, fontWeight: FontWeight.bold)),
                  SizedBox(height: 50),
                  //emaill
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          onChanged: (e) => email = e,
                          validator: (e) => e!.isEmpty ? "champ vide" : null,
                          decoration: InputDecoration(
                            hintText: 'E-mail',
                            prefixIcon: Icon(Icons.mail,
                                color: Color.fromARGB(255, 4, 8, 115)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          onChanged: (e) => pass = e,
                          validator: (e) => e!.isEmpty
                              ? "champ vide"
                              : e.length < 6
                                  ? "le mot de passe doit être au moins 6 caractères"
                                  : null,
                          obscureText: hidden,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: hidden
                                  ? Icon(Icons.visibility_off,
                                      color: Color.fromARGB(255, 4, 8, 115))
                                  : Icon(Icons.visibility,
                                      color: Color.fromARGB(255, 4, 8, 115)),
                              onPressed: () {
                                setState(() {
                                  hidden = !hidden;
                                });
                              },
                            ),
                            hintText: 'Mot de passe',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color.fromARGB(255, 4, 8, 115),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  //mot de passe oublié
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => Reset()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 220.0),
                      child: Text(
                        "Mot de passe oublié?",
                        style: TextStyle(color: Color.fromARGB(255, 4, 8, 115)),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  //sign in
                  MaterialButton(
                    onPressed: () async {
                      if (keys.currentState!.validate()) {
                        loading(context);
                        bool login = await auth.signin(email, pass);
                        if (login != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                          );
                          if (!login)
                            print("E-mail ou mot de passe incorrecte");
                        }
                      }
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
                            child: Column(
                              children: [
                                Text(
                                  'Connecter',
                                  style: GoogleFonts.robotoCondensed(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
