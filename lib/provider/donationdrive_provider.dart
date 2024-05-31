import 'package:flutter/material.dart';
import 'package:flutter_project/api/donationdrive_api.dart';
import 'package:flutter_project/model/donationdrive_model.dart';

class DonationDriveProvider extends ChangeNotifier {
  final DonationDriveApi donationDriveApi = DonationDriveApi();
  final bool _isLoading = false;
  List<DonationDrive> _orgdrives = [
    // DonationDrive(
    //     id: 1,
    //     name: "School supply drives",
    //     description:
    //         "A school supply drive can help local schools provide quality education to all children, especially those from underserved communities for whom school supplies are a major expense.",
    //     ),
    // DonationDrive(
    //     id: 2,
    //     name: "Food drive",
    //     description:
    //         "Food insecurity is one of the country’s most prevalent issues.",
    //     ),
    // DonationDrive(
    //     id: 3,
    //     name: "Clothing Drive",
    //     description:
    //       "No matter the time of year, a clothing drive is one of the best ways to support people in need."
    //     ),
  ];

  bool get isLoading => _isLoading;
  List<DonationDrive> get orgdrives => _orgdrives;

  // void addDrive(DonationDrive newDonationDrive) {
  //   _orgdrives.add(newDonationDrive);
  //   notifyListeners();
  // }

  Future<void> addDrive(DonationDrive newDonationDrive) async {
    try {
      await donationDriveApi.addDonationDrive(newDonationDrive);
      // _orgdrives.add(newDonationDrive);
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchDonationDrives() async {
    try {
      List<DonationDrive> fetchedDrives = await donationDriveApi.fetchDonationDrives();
      _orgdrives.clear();
      _orgdrives.addAll(fetchedDrives);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<void> fetchCurrentOrgDrives(String org) async {
    try {
      List<DonationDrive> fetchedDrives = await donationDriveApi.fetchDonationDrivesByOrg(org);
      _orgdrives.clear();
      _orgdrives.addAll(fetchedDrives);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<void> editDrive(int index, DonationDrive updatedDrive) async {
    // _orgdrives[index] = updatedDrive;
    // notifyListeners();
    try {
      await donationDriveApi.updateDonationDrive(updatedDrive);
      _orgdrives[index] = updatedDrive;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteDrive(String id) async {
    try {
      await donationDriveApi.deleteDonationDrive(id);
      _orgdrives.removeWhere((element) => element.id == id);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
