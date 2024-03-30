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
  @override
  Widget build(BuildContext context) {
    List<Materiel> ListMateriels = [];
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Matériels')
            .orderBy('Nom')
            .snapshots(),
        builder: (context, snp) {
          if (snp.hasError) {
            return const Center(
              child: Text('error'),
            );
          }
          if (snp.hasData) {
            ListMateriels = snp.data!.docs
                .map((doc) =>
                    Materiel.fromJson(doc.data() as Map<String, dynamic>))
                .toList();
            return ListM(Materiels: ListMateriels);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
