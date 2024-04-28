import 'package:application/materiels/widget/materiel.list.dart';
import 'package:application/model/Materiel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListMateriels extends StatefulWidget {
  const ListMateriels({super.key});

  @override
  State<ListMateriels> createState() => _ListMaterielsState();
}

class _ListMaterielsState extends State<ListMateriels> {
  List<Materiel> listMateriels = [];
  List<Materiel> filteredMateriels = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  filteredMateriels = listMateriels
                      .where((materiel) =>
                          materiel.Nom.toLowerCase()
                              .contains(value.toLowerCase()) ||
                          materiel.Code_Etiquette.toLowerCase()
                              .contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                labelText: 'Rechercher par nom ou code étiquette',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Matériels')
                  .orderBy('Nom')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                listMateriels = snapshot.data!.docs
                    .map((doc) =>
                        Materiel.fromJson(doc.data() as Map<String, dynamic>))
                    .toList();
                if (filteredMateriels.isEmpty) {
                  filteredMateriels = listMateriels;
                }
                return ListM(Materiels: filteredMateriels);
              },
            ),
          ),
        ],
      ),
    );
  }
}
