import 'package:application/model/Materiel.dart';
import 'package:application/services/materiels.repo.dart';
import 'package:flutter/material.dart';

class Ajouter extends StatefulWidget {
  const Ajouter({super.key});

  @override
  State<Ajouter> createState() => _AjouterState();
}

class _AjouterState extends State<Ajouter> {
  @override
  Widget build(BuildContext context) {
    final controllerNom = TextEditingController();
    final controllerCodeEtiquette = TextEditingController();
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextField(
                controller: controllerNom,
                style: TextStyle(fontSize: 22),
                decoration: InputDecoration(
                  labelText: 'Nom Matériel',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controllerCodeEtiquette,
                style: TextStyle(fontSize: 22),
                decoration: InputDecoration(
                  labelText: 'Code Etiquette',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    final materiel = Materiel(
                        Nom: controllerNom.text,
                        Code_Etiquette: controllerCodeEtiquette.text);
                    AjouterM(materiel);
                  },
                  child: Container(
                    width: double.infinity,
                    color: const Color.fromARGB(255, 4, 37, 63),
                    child: const Icon(
                      Icons.add,
                      color: Color.fromARGB(255, 242, 68, 5),
                      size: 30,
                    ),
                  ))
            ],
          )),
    ));
  }
}
