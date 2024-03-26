import 'dart:io';

import 'package:application/data/globals.dart';
import 'package:application/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path; // Import the path package

class DBServices {
  final CollectionReference usercol =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference carouselcol =
      FirebaseFirestore.instance.collection("carsouel");
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

  //Future updateUser(UserM user) async {
  //final docUser = FirebaseFirestore.instance.collection('users').doc(user.id);
  //await docUser.update(user.toJson());
  //}
  Future updateUser(UserM user) async {
    try {
      await usercol.doc(user.id).update(user.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteUser(UserM user) async {
    try {
      await usercol.doc(user.id).delete();
      return true;
    } catch (e) {
      print("Error deleting user: $e");
      return false;
    }
  }

  Future<String?> uploadImage(File file, {String? path}) async {
    var time = DateTime.now().toString();
    var ext = Path.basename(file.path).split(".")[1].toString();
    String image = "${path}_$time.$ext";
    try {
      Reference ref = FirebaseStorage.instance.ref().child("$path/$image");
      UploadTask upload = ref.putFile(file);
      await upload.whenComplete(() => null);
      return ref.getDownloadURL();
    } catch (e) {
      // Handle error
      print(e.toString());
      return null;
    }
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
