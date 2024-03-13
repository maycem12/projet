import 'package:application/services/auth.dart';
import 'package:application/utiles/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        title: const Text("Créer un compte "),
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
                  const CircleAvatar(
                    radius: 100.0,
                    backgroundImage: AssetImage('images/log.gif'),
                  ),
                  const SizedBox(height: 20),
                  //title
                  Text('Créer un compte',
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 40, fontWeight: FontWeight.bold)),
                  const SizedBox(
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
                          decoration: const InputDecoration(
                            hintText: 'Nom et Prénom',
                            prefixIcon: Icon(Icons.account_circle,
                                color: Color.fromARGB(255, 4, 8, 115)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                          decoration: const InputDecoration(
                            hintText: 'E-mail',
                            prefixIcon: Icon(Icons.mail,
                                color: Color.fromARGB(255, 4, 8, 115)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                                  ? const Icon(Icons.visibility_off,
                                      color: Color.fromARGB(255, 4, 8, 115))
                                  : const Icon(Icons.visibility,
                                      color: Color.fromARGB(255, 4, 8, 115)),
                              onPressed: () {
                                setState(() {
                                  hidden = !hidden;
                                });
                              },
                            ),
                            hintText: 'Mot de passe',
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color.fromARGB(255, 4, 8, 115),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //confirm password
                  const SizedBox(height: 10),
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
                                  ? const Icon(Icons.visibility_off,
                                      color: Color.fromARGB(255, 4, 8, 115))
                                  : const Icon(Icons.visibility,
                                      color: Color.fromARGB(255, 4, 8, 115)),
                              onPressed: () {
                                setState(() {
                                  hidden = !hidden;
                                });
                              },
                            ),
                            hintText: 'Confirmer votre mot de passe ',
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color.fromARGB(255, 4, 8, 115),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  //boutttttonnnnnn
                  MaterialButton(
                    onPressed: () async {
                      if (keys.currentState!.validate()) {
                        loading(context);
                        await auth.signup(email, pass, np).then((value) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Get.dialog(const AlertDialog(
                            title: Text(
                              "succéé",
                            ),
                            content:
                                Text("votre compte a été crée avec succée"),
                          ));
                        }).onError((error, stackTrace) {
                          Navigator.of(context).pop();
                          Get.dialog(AlertDialog(
                            title: const Text(
                              "Error",
                            ),
                            content: Text(
                              error.toString(),
                            ),
                          ));
                        });
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
