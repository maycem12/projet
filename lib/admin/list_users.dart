import 'package:application/admin/widgets/l_users.dart';
import 'package:application/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({super.key});

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
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
              return Lusers(users: allusers);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
