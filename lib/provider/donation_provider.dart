import 'package:flutter/material.dart';
import 'package:flutter_project/model/donation_model.dart';

class DonationProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<Donation> _donations = [];

  bool get isLoading => _isLoading;
  List<Donation> get donations => _donations;

  void addDonation(Donation newDonation) {
    _donations.add(newDonation);
    notifyListeners();
  }
}
