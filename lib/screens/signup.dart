// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'package:application/services/auth.dart';
import 'package:application/utiles/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthServices auth = AuthServices();
  late String email, pass, cpass, np;
  final keys = GlobalKey<FormState>();
  bool hidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Créer un compte "),
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
                  Text('Créer un compte',
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 40, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 50,
                  ),
                  //nom etttttttttttt prenom
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
                          keyboardType: TextInputType.text,
                          onChanged: (e) => np = e,
                          validator: (e) => e!.isEmpty ? "champ vide" : null,
                          decoration: InputDecoration(
                            hintText: 'Nom et Prénom',
                            prefixIcon: Icon(Icons.account_circle,
                                color: Color.fromARGB(255, 4, 8, 115)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //emaiiiiiiiiiiiiiiiiiiiiiiiiiil
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
                          keyboardType: TextInputType.emailAddress,
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
                  //confirm password
                  SizedBox(height: 10),
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
                          onChanged: (e) => cpass = e,
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
                            hintText: 'Confirmer votre mot de passe ',
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
                  //boutttttonnnnnn
                  MaterialButton(
                    onPressed: () async {
                      if (keys.currentState!.validate()) {
                        loading(context);
                        bool register = await auth.signup(email, pass, np);
                        // ignore: unnecessary_null_comparison
                        if (register != null) {
                          Navigator.of(context).pop();
                          if (register) {
                            Navigator.of(context).pop();
                          }
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
                                  'Enregistrer',
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
