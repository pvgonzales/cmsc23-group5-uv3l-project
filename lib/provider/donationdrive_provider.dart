import 'package:flutter/material.dart';
import 'package:flutter_project/model/donationdrive_model.dart';

class DonationDriveProvider extends ChangeNotifier {
  final bool _isLoading = false;
  final List<DonationDrive> _orgdrives = [
    DonationDrive(
        id: 1,
        name: "School supply drives",
        description:
            "A school supply drive can help local schools provide quality education to all children, especially those from underserved communities for whom school supplies are a major expense.",
        ),
    DonationDrive(
        id: 2,
        name: "Food drive",
        description:
            "Food insecurity is one of the country’s most prevalent issues.",
        ),
    DonationDrive(
        id: 3,
        name: "Clothing Drive",
        description:
          "No matter the time of year, a clothing drive is one of the best ways to support people in need."
        ),
  ];

  bool get isLoading => _isLoading;
  List<DonationDrive> get orgdrives => _orgdrives;

  void addDrive(DonationDrive newDonationDrive) {
    _orgdrives.add(newDonationDrive);
    notifyListeners();
  }

  void editDrive(int index, DonationDrive updatedDrive) {
    _orgdrives[index] = updatedDrive;
    notifyListeners();
  }

  void deleteDrive(int id) {
    for (int i = 0; i < _orgdrives.length; i++) {
      if (_orgdrives[i].id == id) {
        _orgdrives.removeAt(i);
        break;
      }
    }
    notifyListeners();
  }
}
