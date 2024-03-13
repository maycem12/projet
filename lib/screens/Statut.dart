import 'package:application/screens/ls_screen.dart';
import 'package:application/screens/login.dart';
import 'package:application/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Statut extends StatefulWidget {
  const Statut({super.key});

  @override
  State<Statut> createState() => _StatutState();
}

class _StatutState extends State<Statut> {
  late User? user;
  AuthServices auth = AuthServices();

  Future<void> getUser() async {
    final userResult = await auth.user;
    setState(() {
      user = userResult!;
    });
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return user == null ? const LogIn() : const LSScreen();
  }
}
