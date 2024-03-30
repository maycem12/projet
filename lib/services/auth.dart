import 'dart:async';

import 'package:application/model/user.dart';
import 'package:application/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  DBServices dbService = DBServices();
  Future<User?> get user async {
    final user = FirebaseAuth.instance.currentUser;
    return user;
  }

  Future<void> signup(String email, String pass, String np) async {
    try {
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      if (result.user != null) {
        // Saving user information to the database
        await dbService
            .saveUser(UserM(id: result.user!.uid, email: email, np: np));

        // Sending email to admin
        await sendEmailToAdmin(
            'NouvelUtilisateur', 'nouvelutilisateur@example.com');

        print('utilisateur sest inscrit avec succès.');
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          print('Le compte existe déjà pour cet e-mail. ');
        } else {
          print('Error: ${e.message}');
        }
      }
    }
  }

  Future<void> sendEmailToAdmin(String username, String email) async {
    final smtpServer = SmtpServer('smtp.gmail.com',
        username: 'your-email@example.com', password: 'your-email-password');

    final message = Message()
      ..from = Address('your-email@example.com')
      ..recipients.add('maycem.benlagha@gmail.com')
      ..subject = 'Nouvel utilisateur inscrit'
      ..text = 'Un nouvel utilisateur s\'est inscrit :\n\n'
          'Nom d\'utilisateur : $username\n'
          'Adresse e-mail : $email';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message envoyé : ${sendReport.toString()}');
    } catch (e) {
      print('Erreur lors de l\'envoi de l\'e-mail : $e');
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
      await setFirstTimeUser(true);
    } catch (e) {
      print("Erreur lors de la déconnexion : $e");
    }
  }

  Future<bool> isFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    return isFirstTime;
  }

  Future<void> setFirstTimeUser(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', value);
  }

  Future<UserM?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      await setFirstTimeUser(
          false); // Set isFirstTimeUser to false after successful sign-in

      // Get the current user details from the database
      return await dbService.getCurrentUser(userCredential.user!.uid);
    } catch (e) {
      print('Failed to sign in: $e');
      return null;
    }
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
