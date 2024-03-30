import 'package:application/model/Materiel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future AjouterM(Materiel materiel) async {
  final docMateriels = FirebaseFirestore.instance.collection("Matériels").doc();
  materiel.id = docMateriels.id;
  await docMateriels.set(materiel.toJson());
}

Future updateM(Materiel materiel) async {
  final docMateriels =
      FirebaseFirestore.instance.collection('Matériels').doc(materiel.id);
  await docMateriels.update(materiel.toJson());
}

Future deleteM(String id) async {
  final docMateriels =
      FirebaseFirestore.instance.collection('Matériels').doc(id);
  await docMateriels.delete();
}
