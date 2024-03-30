import 'package:application/materiels/Ajouter.dart';
import 'package:application/materiels/ListMateriels.dart';
import 'package:flutter/material.dart';

class MaterielsPage extends StatefulWidget {
  const MaterielsPage({super.key});

  @override
  State<MaterielsPage> createState() => _MaterielsPageState();
}

class _MaterielsPageState extends State<MaterielsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.amber[900],
              title: const Text(
                'Gestion des matériels',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.assignment_sharp,
                      size: 30,
                      color: Color.fromARGB(255, 6, 47, 81),
                    ),
                    child: Text(
                      'Ajouter',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.edit_attributes,
                      size: 30,
                      color: Color.fromARGB(255, 6, 47, 81),
                    ),
                    child: Text(
                      'List',
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
                Ajouter(),
                ListMateriels(),
              ],
            )));
  }
}
