import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/model/donation_model.dart';

class DonationApi {
  final CollectionReference donationCollection = FirebaseFirestore.instance.collection("donations");

  Future<void> addDonation(Donation donation) async {
    try {
      await donationCollection.add({
        "id": donation.id,
        "items": donation.items,
        "logistics": donation.logistics,
        "address": donation.address,
        "phoneNum": donation.phoneNum,
        "date": donation.date,
        "time": donation.time,
        "status": donation.status,
        "donationdrive": donation.donationdrive,
        "donor": donation.donor,
        "proof": donation.proof,
      });
    } catch(e) {
      print(e);
    }
  }

  Future<List<Donation>> fetchDonations() async {
    try {
      QuerySnapshot snapshot = await donationCollection.get();
      print("======= Documents ========");

      snapshot.docs.forEach((doc) {
        print(doc.id);
      });

      return snapshot.docs.map((doc) {
        return Donation(
          id: doc['id'],
          items: List<String>.from(doc['items']),
          logistics: doc['logistics'],
          address: doc['address'],
          phoneNum: doc['phoneNum'],
          date: doc['date'],
          time: doc['time'],
          status: doc['status'],
          donationdrive: doc['donationdrive'],
          proof: doc['proof'],
        );
      }).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Donation>> fetchDonationsByUsername(String username) async {
    try {
      QuerySnapshot snapshot = await donationCollection.where('donor', isEqualTo: username).get();
      return snapshot.docs.map((doc) {
        return Donation(
          id: doc['id'],
          items: List<String>.from(doc['items']),
          logistics: doc['logistics'],
          address: doc['address'],
          phoneNum: doc['phoneNum'],
          date: doc['date'],
          time: doc['time'],
          status: doc['status'],
          donationdrive: doc['donationdrive'],
          proof: doc['proof'],
          donor: doc['donor'],
          // proof: doc['proof'] != null ? XFile(doc['proof']) : null,
        );
      }).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> editDropOffStatus(int id, String status) async {
    try {
      QuerySnapshot querySnapshot = await donationCollection.where("id", isEqualTo: id).get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot document = querySnapshot.docs.first;
        await donationCollection.doc(document.id).update({"status": status});
      }
    } catch (e) {
      print("Error updating donation status: $e");
    }
  }

  Future<String> editDonation(int id, Map<String, dynamic> editedDonation) async {
    try {
      QuerySnapshot querySnapshot = await donationCollection.where("id", isEqualTo: id).get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot document = querySnapshot.docs.first;
        await donationCollection.doc(document.id).update(editedDonation);
      }
      return "Successfully edited Donation!";
    } catch (e) {
      return "Error updating donation status: $e";
    }
  }

  Future<void> deleteDonation(int id) async {
    try {
      QuerySnapshot querySnapshot = await donationCollection.where("id", isEqualTo: id).get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot document = querySnapshot.docs.first;
        await donationCollection.doc(document.id).delete();
      }
    } catch (e) {
      print("Error deleting donation: $e");
    }
  }
}