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
  final TextEditingController controllerupdatenom = TextEditingController();
  final TextEditingController controllerupdatecode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.Materiels.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        final materiel = widget.Materiels[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 6, 47, 81),
              child: Text(
                controllerupdatenom.text.isNotEmpty
                    ? controllerupdatenom.text.substring(0, 2).toUpperCase()
                    : "",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              materiel.Nom,
              style: const TextStyle(fontSize: 18),
            ),
            subtitle: Text(
              materiel.Code_Etiquette,
              style: const TextStyle(fontSize: 16),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => _modifierMateriel(context, materiel),
                  icon: const Icon(Icons.edit, color: Colors.blue),
                ),
                IconButton(
                  onPressed: () => _supprimerMateriel(context, materiel),
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _modifierMateriel(BuildContext context, Materiel materiel) {
    controllerupdatenom.text = materiel.Nom;
    controllerupdatecode.text = materiel.Code_Etiquette;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Modifier ${materiel.Nom}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controllerupdatenom,
                decoration: const InputDecoration(labelText: 'Nom Matériel'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controllerupdatecode,
                decoration: const InputDecoration(labelText: 'Code Etiquette'),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              final updatedMateriel = Materiel(
                id: materiel.id,
                Nom: controllerupdatenom.text,
                Code_Etiquette: controllerupdatecode.text,
              );
              updateM(updatedMateriel);
              Navigator.pop(context);
            },
            child: const Text('Modifier'),
          ),
        ],
      ),
    );
  }

  void _supprimerMateriel(BuildContext context, Materiel materiel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Voulez-vous vraiment supprimer ${materiel.Nom} ?'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Non'),
          ),
          ElevatedButton(
            onPressed: () {
              deleteM(materiel.id);
              Navigator.pop(context);
            },
            child: const Text('Oui'),
          ),
        ],
      ),
    );
  }
}
