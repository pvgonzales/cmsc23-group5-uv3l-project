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
        );
      }).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
}