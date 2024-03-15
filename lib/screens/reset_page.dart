import 'package:application/services/auth.dart';
import 'package:application/utiles/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Reset extends StatefulWidget {
  const Reset({super.key});

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  AuthServices auth = AuthServices();
  late String email, msg = "";
  final keys = GlobalKey<FormState>();
  bool hidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connectez-vous "),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: keys,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  //title
                  Text('Connectez-vous',
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 40, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 50),
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
                          decoration: const InputDecoration(
                            hintText: 'E-mail',
                            prefixIcon: Icon(Icons.mail,
                                color: Color.fromARGB(255, 4, 8, 115)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  //sign in
                  MaterialButton(
                    onPressed: () async {
                      if (keys.currentState!.validate()) {
                        loading(context);
                        bool send = await auth.reset(email);
                        if (send) {
                          msg =
                              "Accéder à votre email pour reinitialiser votre mot de passe ";
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }

                          setState(() {});
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
                                  'Envoyer',
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
                  Text(msg),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
