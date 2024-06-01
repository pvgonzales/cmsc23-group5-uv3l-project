import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/model/org_model.dart';

class OrgApi {
  final CollectionReference orgCollection = FirebaseFirestore.instance.collection("organizations");

  Future<List<Organizations>> fetchOrganizations() async {
    try {
      QuerySnapshot snapshot = await orgCollection.get();
      print("======= Organizations ========");

      snapshot.docs.forEach((doc) {
        print(doc.id);
      });

      return snapshot.docs.map((doc) {
        return Organizations(
          // id: doc['id'],
          name: doc['name'],
          description: doc['description'],
          image: doc['image'],
          status: doc['status'],
          type: doc['type'],
        );
      }).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
}