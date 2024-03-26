import 'dart:async';

import 'package:application/model/user.dart';
import 'package:application/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

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
      await sendEmailToAdmin(email);
    }
  }

  Future<void> sendEmailToAdmin(String userEmail) async {
    final smtpServer = gmail('your@gmail.com', 'your_password');

    final message = Message()
      ..from = Address('your@gmail.com', 'Your Name')
      ..recipients.add(
          'maycem.benlagha@gmail.com') // Remplacez par l'e-mail de l'administrateur
      ..subject = 'Nouvel utilisateur inscrit'
      ..text =
          'Un nouvel utilisateur s\'est inscrit avec l\'adresse e-mail : $userEmail';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print("Erreur lors de la déconnexion : $e");
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
