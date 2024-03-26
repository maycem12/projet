import 'package:application/admin/list_bloquer.dart';
import 'package:application/admin/list_supprimer.dart';
import 'package:application/admin/list_users.dart';
import 'package:flutter/material.dart';

class ControllerPage extends StatelessWidget {
  const ControllerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Gestion des utilisateurs',
                style: TextStyle(fontSize: 20, color: Colors.white)),
            backgroundColor: const Color.fromARGB(255, 6, 79, 112),
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.update,
                    size: 20,
                    color: Color.fromARGB(255, 255, 94, 7),
                  ),
                  child: Text(
                    'Modifier',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.block_outlined,
                    size: 20,
                    color: Color.fromARGB(255, 255, 94, 7),
                  ),
                  child: Text(
                    'Bloquer/Débloquer',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.delete_forever,
                    size: 20,
                    color: Color.fromARGB(255, 255, 94, 7),
                  ),
                  child: Text(
                    'Supprimer',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              ListUsers(),
              ListBloquer(),
              ListSupprimer(),
            ],
          )),
    );
  }
}
