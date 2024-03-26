import 'package:application/model/user.dart';
import 'package:application/services/db.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BloquerUsers extends StatefulWidget {
  List<UserM> users;
  BloquerUsers({super.key, required this.users});

  @override
  State<BloquerUsers> createState() => _BloquerUsersState();
}

class _BloquerUsersState extends State<BloquerUsers> {
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
                    allusers[index].np.substring(0, 2).toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
              title: Text(
                allusers[index].np,
                style: const TextStyle(fontSize: 22),
              ),
              subtitle: Text(allusers[index].email.toString()),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                if (allusers[index].admin)
                  const Icon(
                    Icons.star,
                    color: Colors.red,
                  ),
                if (!allusers[index].admin)
                  IconButton(
                    icon: Icon(
                        allusers[index].enable ? Icons.lock_open : Icons.lock,
                        color:
                            allusers[index].enable ? Colors.green : Colors.red),
                    onPressed: () async {
                      await DBServices().updateUser(
                          allusers[index]..enable = !allusers[index].enable);
                    },
                  ),
              ]),
            ),
          );
        });
  }
}
