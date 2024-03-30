import 'package:application/model/Materiel.dart';
import 'package:application/services/materiels.repo.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListM extends StatefulWidget {
  List<Materiel> Materiels;
  ListM({super.key, required this.Materiels});

  @override
  State<ListM> createState() => _ListMState();
}

class _ListMState extends State<ListM> {
  @override
  Widget build(BuildContext context) {
    final ListMateriels = widget.Materiels;
    final controllerupdatenom = TextEditingController();
    final controllerupdatecode = TextEditingController();
    return ListView.builder(
        itemCount: ListMateriels.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 6, 47, 81),
                child: Text(
                  ListMateriels[index].Nom.substring(0, 2).toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                ListMateriels[index].Nom,
                style: const TextStyle(fontSize: 22),
              ),
              subtitle: Text(ListMateriels[index].Code_Etiquette),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                    title: Text(
                                        'Modifier  ${ListMateriels[index].Nom}'),
                                    content: SingleChildScrollView(
                                      child: Container(
                                        height: 200,
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: controllerupdatenom,
                                              style: const TextStyle(
                                                  fontSize: 22,
                                                  color: Colors.amber),
                                              decoration: const InputDecoration(
                                                  labelText: 'Nom Matériel',
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  40)))),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextField(
                                              controller: controllerupdatecode,
                                              style: const TextStyle(
                                                  fontSize: 22,
                                                  color: Colors.amber),
                                              decoration: const InputDecoration(
                                                  labelText: 'Code Etiquette',
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  40)))),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                final materiel = Materiel(
                                                    id: ListMateriels[index].id,
                                                    Nom: controllerupdatenom
                                                        .text,
                                                    Code_Etiquette:
                                                        controllerupdatecode
                                                            .text);
                                                updateM(materiel);
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                child: const Text('Modifier'),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'Annuler');
                                          },
                                          child: const Text('Annuler'))
                                    ]));
                      },
                      child: const Icon(Icons.edit,
                          size: 30, color: Color.fromARGB(255, 6, 47, 81))),
                  TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              title: Text(
                                  'Voulez-vous vraiment supprimer ${ListMateriels[index].Nom} ?'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context, 'Annuler');
                                    },
                                    child: const Text('Non')),
                                ElevatedButton(
                                    onPressed: () {
                                      deleteM(ListMateriels[index].id);
                                      Navigator.pop(context, 'Oui');
                                    },
                                    child: const Text('Oui')),
                              ]),
                        );
                      },
                      child: const Icon(
                        Icons.delete,
                        size: 30,
                        color: Color.fromARGB(255, 255, 85, 7),
                      )),
                ],
              ),
            ),
          );
        });
  }
}
