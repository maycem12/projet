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

  Stream<UserM>? get getCurrentUser {
    final user = FirebaseAuth.instance.currentUser;
    return user != null
        ? usercol.doc(user.uid).snapshots().map((user) {
            UserM.current = UserM.fromJson(user.data());
            return UserM.fromJson(user.data());
          })
        : null;
  }
}
