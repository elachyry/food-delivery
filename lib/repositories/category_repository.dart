import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  final CollectionReference _categoryCollection =
      FirebaseFirestore.instance.collection('categories');

  Stream<QuerySnapshot> getCategoryStream() {
    return _categoryCollection.snapshots();
  }
}
