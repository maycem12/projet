import 'package:application/model/Materiel.dart';
import 'package:application/services/materiels.repo.dart';
import 'package:flutter/material.dart';

class Ajouter extends StatefulWidget {
  const Ajouter({super.key});

  @override
  State<Ajouter> createState() => _AjouterState();
}

class _AjouterState extends State<Ajouter> {
  final TextEditingController controllerNom = TextEditingController();
  final TextEditingController controllerCodeEtiquette = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: controllerNom,
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                labelText: 'Nom Matériel',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controllerCodeEtiquette,
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                labelText: 'Code Etiquette',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (controllerNom.text.isNotEmpty &&
                    controllerCodeEtiquette.text.isNotEmpty) {
                  final materiel = Materiel(
                    Nom: controllerNom.text,
                    Code_Etiquette: controllerCodeEtiquette.text,
                  );
                  AjouterM(materiel);
                  _afficherMessage(context, 'Matériel ajouté avec succès!');
                } else {
                  _afficherMessage(
                      context, 'Veuillez remplir tous les champs.');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 29, 6, 121),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Ajouter',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _afficherMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2), // Durée du message
      ),
    );
  }
}
