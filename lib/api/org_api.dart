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
          uid: doc['uid'],
          email: doc['email'],
          name: doc['name'],
          username: doc['username'],
          address: doc['address'],
          contact: doc['contact'],
          approved: doc['approved'],
          description: doc['description'],
          image: doc['photo'],
          status: doc['status'],
          type: doc['orgtype'],
        );
      }).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

Future<List<Organizations>> fetchApprovedOrganizations() async {
  try {
    QuerySnapshot snapshot = await orgCollection.get();
    print("======= Organizations ========");

    // Printing the IDs of the documents
    snapshot.docs.forEach((doc) {
      print(doc.id);
    });

    // Filtering approved organizations and mapping to Organizations objects
    List<Organizations> approvedOrganizations = snapshot.docs
        .where((doc) => doc['approved'] == true && doc['status'] == true)
        .map((doc) {
          return Organizations(
            uid: doc['uid'],
            email: doc['email'],
            name: doc['name'],
            username: doc['username'],
            address: doc['address'],
            contact: doc['contact'],
            approved: doc['approved'],
            description: doc['description'],
            image: doc['photo'],
            status: doc['status'],
            type: doc['orgtype'],
          );
        })
        .toList();

    return approvedOrganizations;
  } catch (e) {
    print(e);
    return [];
  }
}


  Future<List<Organizations>> fetchOrganizationByUsername(String username) async {
    try {
      QuerySnapshot snapshot = await orgCollection.where('username', isEqualTo: username).get();
      return snapshot.docs.map((doc) {
        return Organizations(
          uid: doc['uid'],
          email: doc['email'],
          name: doc['name'],
          username: doc['username'],
          address: doc['address'],
          contact: doc['contact'],
          approved: doc['approved'],
          description: doc['description'],
          image: doc['photo'],
          status: doc['status'],
          type: doc['orgtype'],
        );
      }).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> updateOrganizationStatus(String id, bool status) async {
    try {
      await orgCollection.doc(id).update({
        "status": status
      });
    } catch (e) {
      print("Error updating organization status: $e");
    }
  }

  Future<List<Organizations>> filterOrganizationsByCategory(String category) async {
  try {
    QuerySnapshot snapshot = await orgCollection.get();

    // Filtering approved organizations and mapping to Organizations objects
    List<Organizations> approvedOrganizations = snapshot.docs
        .where((doc) => doc['approved'] == true && doc['status'] == true && doc['orgtype'] == category)
        .map((doc) {
          return Organizations(
            uid: doc['uid'],
            email: doc['email'],
            name: doc['name'],
            username: doc['username'],
            address: doc['address'],
            contact: doc['contact'],
            approved: doc['approved'],
            description: doc['description'],
            image: doc['photo'],
            status: doc['status'],
            type: doc['orgtype'],
          );
        })
        .toList();

    return approvedOrganizations;
  } catch (e) {
    print(e);
    return [];
  }
}

}