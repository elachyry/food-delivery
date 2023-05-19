import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class IngredientRepository extends GetxController {
  final CollectionReference _ingredientCollection =
      FirebaseFirestore.instance.collection('ingredient');

  Stream<QuerySnapshot> getIngredientStream() {
    return _ingredientCollection.snapshots();
  }
}
