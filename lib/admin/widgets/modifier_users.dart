import 'package:application/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ModifierUsers extends StatefulWidget {
  List<UserM> users;
  ModifierUsers({super.key, required this.users});

  @override
  State<ModifierUsers> createState() => _ModifierUsersState();
}

Future updateUser(UserM user) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc(user.id);
  await docUser.update(user.toJson());
}

class _ModifierUsersState extends State<ModifierUsers> {
  @override
  Widget build(BuildContext context) {
    final allusers = widget.users;
    final _ctrupdatnp = TextEditingController();
    final _ctrupdatemail = TextEditingController();
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
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            title: Text('modifier:${allusers[index].np}'),
                            // ignore: avoid_unnecessary_containers
                            content: SingleChildScrollView(
                              // ignore: avoid_unnecessary_containers
                              child: Container(
                                height: 190,
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: _ctrupdatnp,
                                      style: const TextStyle(
                                          fontSize: 22,
                                          color: Colors.blueAccent),
                                      decoration: const InputDecoration(
                                          labelText: 'nom et prénom',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(40)))),
                                    ),
                                    const SizedBox(height: 5),
                                    TextField(
                                      controller: _ctrupdatemail,
                                      style: const TextStyle(
                                          fontSize: 22,
                                          color: Colors.blueAccent),
                                      decoration: const InputDecoration(
                                          labelText: 'email',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(40)))),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    final user = UserM(
                                        id: allusers[index].id,
                                        np: _ctrupdatnp.text,
                                        email: _ctrupdatemail.text);
                                    updateUser(user);
                                  },
                                  child: const Text('Modifier')),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context, 'Annuler');
                                },
                                child: const Text('Annuler'),
                              )
                            ]),
                      );
                    },
                    child: const Icon(Icons.edit,
                        size: 32, color: Color.fromARGB(255, 5, 36, 101)),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
