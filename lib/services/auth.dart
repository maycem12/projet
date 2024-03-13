import 'dart:async';

import 'package:application/model/user.dart';
import 'package:application/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  DBServices dbService = DBServices();
  Future<User?> get user async {
    final user = FirebaseAuth.instance.currentUser;
    return user;
  }

  Future<void> signup(String email, String pass, String np) async {
    final result =
        await auth.createUserWithEmailAndPassword(email: email, password: pass);
    if (result.user != null) {
      await dbService
          .saveUser(UserM(id: result.user!.uid, email: email, np: np));
    }
  }

  Future signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      return null;
    }
  }

  Future<UserM?> signin(String email, String password) async {
    final authResult =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return await dbService.getCurrentUser(authResult.user!.uid);
  }

  // Future<bool> signin(String email, String pass) async {
  //   try {
  //     final result =
  //         await auth.signInWithEmailAndPassword(email: email, password: pass);
  //     if (result.user != null) return true;
  //     return false;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  Future<bool> reset(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }
}
