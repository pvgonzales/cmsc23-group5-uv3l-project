import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/model/donationdrive_model.dart';

class DonationDriveApi {
  final CollectionReference donationDriveCollection = FirebaseFirestore.instance.collection("donationdrives");
  
  // Create
  Future<void> addDonationDrive(DonationDrive donationDrive) async {
    try {
      DocumentReference docRef = await donationDriveCollection.add({
        "name": donationDrive.name,
        "description": donationDrive.description,
        "org": donationDrive.org,
      });

      await donationDriveCollection.doc(docRef.id).update({
        "id": docRef.id,
      });
    } catch(e) {
      print(e);
    }
  }

  // Fetch all drive (for admin)
  Future<List<DonationDrive>> fetchDonationDrives() async {
    try {
      QuerySnapshot snapshot = await donationDriveCollection.get();
      print("======= Donation Drives ========");

      snapshot.docs.forEach((doc) {
        print(doc.id);
      });

      return snapshot.docs.map((doc) {
        return DonationDrive(
          id: doc['id'],
          name: doc['name'],
          description: doc['description'],
          org: doc['org'],
        );
      }).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  // Fetch all drive by org
  Future<List<DonationDrive>> fetchDonationDrivesByOrg(String org) async {
    try {
      QuerySnapshot snapshot = await donationDriveCollection.where('org', isEqualTo: org).get();
      return snapshot.docs.map((doc) {
        return DonationDrive(
          id: doc['id'],
          name: doc['name'],
          description: doc['description'],
          org: doc['org'],
        );
      }).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  //Update
  Future<void> updateDonationDrive(DonationDrive donationDrive) async {
    try {
      await donationDriveCollection.doc(donationDrive.id).update({
        'name': donationDrive.name,
        'description': donationDrive.description,
      });
      print("Donation drive updated with ID: ${donationDrive.id}");
    } catch (e) {
      print("Failed to update donation drive: $e");
    }
  }

  // Delete
  Future<void> deleteDonationDrive(String id) async {
    try {
      await donationDriveCollection.doc(id).delete();
      print("Donation drive deleted with ID: $id");
    } catch (e) {
      print("Failed to delete donation drive: $e");
    }
  }
}