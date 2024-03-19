import 'package:application/data/globals.dart';
import 'package:application/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBServices {
  final CollectionReference usercol =
      FirebaseFirestore.instance.collection("users");
  Future saveUser(UserM user) async {
    try {
      await usercol.doc(user.id).set(user.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future getUser(String id) async {
    try {
      final data = await usercol.doc(id).get();
      final user = data.data();
      return user;
    } catch (e) {
      return false;
    }
  }

  Future<UserM?> getAuthUser() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      UserM? user = await getCurrentUser(firebaseUser.uid);
      return user;
    } else {
      return null;
    }
  }

  Future<UserM?> getCurrentUser(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> userDocument =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userDocument.exists) {
      currentUser = UserM.fromJson(userDocument.data()!);
      return UserM.fromJson(userDocument.data()!);
    }
    return null;
  }

  Future updateUser(UserM user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(user.id);
    await docUser.update(user.toJson());
  }

  // Stream<UserM>? get getCurrentUser {
  //   final user = FirebaseAuth.instance.currentUser;
  //   return user != null
  //       ? usercol.doc(user.uid).snapshots().map((user) {
  //           UserM.current = UserM.fromJson(user.data());
  //           return UserM.fromJson(user.data());
  //         })
  //       : null;
  // }
}
