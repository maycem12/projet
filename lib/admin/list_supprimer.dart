import 'package:application/admin/widgets/supprimer_users.dart';
import 'package:application/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListSupprimer extends StatefulWidget {
  const ListSupprimer({super.key});

  @override
  State<ListSupprimer> createState() => _ListSupprimerState();
}

class _ListSupprimerState extends State<ListSupprimer> {
  @override
  Widget build(BuildContext context) {
    List<UserM> allusers = [];
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .orderBy('np')
              .snapshots(),
          builder: (context, snp) {
            if (snp.hasError) {
              return const Center(
                child: Text('Error'),
              );
            }
            if (snp.hasData) {
              allusers = snp.data!.docs
                  .map((doc) =>
                      UserM.fromJson(doc.data() as Map<String, dynamic>))
                  .toList();
              return SupprimerUsers(users: allusers);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
