import 'package:application/model/user.dart';
import 'package:application/services/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SupprimerUsers extends StatefulWidget {
  List<UserM> users;
  SupprimerUsers({super.key, required this.users});

  @override
  State<SupprimerUsers> createState() => _SupprimerUsersState();
}

Future deleteUser(String id) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc(id);
  await docUser.delete();
}

class _SupprimerUsersState extends State<SupprimerUsers> {
  @override
  Widget build(BuildContext context) {
    final allusers = widget.users;
    return ListView.builder(
        itemCount: allusers.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 3, 63, 111),
                  child: Text(
                    allusers[index].np.isNotEmpty
                        ? allusers[index].np.substring(0, 2).toUpperCase()
                        : '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
              title: Text(
                allusers[index].np,
                style: const TextStyle(fontSize: 22),
              ),
              subtitle: Text(allusers[index].email.toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (allusers[index].admin == true)
                    const Icon(Icons.star,
                        color: Color.fromARGB(255, 255, 95, 59)),
                  if (!allusers[index].admin)
                    TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                    title: Text(
                                        'Voulez-vous vraiment supprimer ${allusers[index].np}?'),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            DBServices()
                                                .deleteUser(allusers[index]);
                                            Navigator.pop(context, 'Oui');
                                          },
                                          child: const Text('Oui')),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'Annuler');
                                          },
                                          child: const Text('Non')),
                                    ]));
                      },
                      child:
                          const Icon(Icons.delete, size: 32, color: Colors.red),
                    ),
                ],
              ),
            ),
          );
        });
  }
}
