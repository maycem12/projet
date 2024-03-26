import 'package:application/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Lusers extends StatefulWidget {
  List<UserM> users;
  Lusers({super.key, required this.users});

  @override
  State<Lusers> createState() => _LusersState();
}

Future updateUser(UserM user) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc(user.id);
  await docUser.update(user.toJson());
}

Future deleteUser(String id) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc(id);
  await docUser.delete();
}

class _LusersState extends State<Lusers> {
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
                  backgroundColor: Color.fromARGB(255, 3, 63, 111),
                  child: Text(
                    allusers[index].np.substring(0, 2).toUpperCase(),
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
                                height: 100,
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
                                    const SizedBox(height: 20),
                                    TextField(
                                      controller: _ctrupdatemail,
                                      style: const TextStyle(
                                          fontSize: 22,
                                          color: Colors.blueAccent),
                                      decoration: const InputDecoration(
                                          labelText: 'email',
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(40)))),
                                    ),
                                    const SizedBox(height: 20),
                                    MaterialButton(
                                      onPressed: () {
                                        final user = UserM(
                                            id: allusers[index].id,
                                            np: _ctrupdatnp.text,
                                            email: _ctrupdatemail.text);
                                        updateUser(user);
                                      },
                                      // ignore: sized_box_for_whitespace
                                      child: Container(
                                          width: double.infinity,
                                          child: const Text('Modifier')),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context, 'Annuler');
                                },
                                child: const Text('Annuler'),
                              )
                            ]),
                      );
                    },
                    child:
                        const Icon(Icons.edit, size: 32, color: Colors.green),
                  ),
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
                                          deleteUser(allusers[index].id);
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
                  TextButton(
                    onPressed: () {},
                    child: const Icon(Icons.block, size: 32, color: Colors.red),
                  )
                ],
              ),
            ),
          );
        });
  }
}
