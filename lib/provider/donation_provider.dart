import 'package:flutter/material.dart';
import 'package:flutter_project/model/donation_model.dart';

class DonationProvider extends ChangeNotifier {
  final bool _isLoading = false;
  final List<Donation> _donations = [
    Donation(
        id: 7984656454,
        items: ['Clothes', 'Cash'],
        logistics: 'Pick up',
        address: 'Los Banos, Laguna',
        phoneNum: '09123456789',
        date: 'May 31, 2024',
        time: '8:00 AM',
        status: 'Scheduled for Pick-up'),
    Donation(
        id: 995234965,
        items: ['Food', 'Others'],
        logistics: 'Drop-off',
        date: 'June 11, 2024',
        time: '01:30 PM',
        status: 'Pending'),
    Donation(
        id: 012534588,
        items: ['Necessities'],
        logistics: 'Pick up',
        address: 'Calamba, Laguna',
        phoneNum: '09987456321',
        date: 'July 27, 2024',
        time: '10:00 AM',
        status: 'Pending'),
  ];

  bool get isLoading => _isLoading;
  List<Donation> get donations => _donations;

  void addDonation(Donation newDonation) {
    _donations.add(newDonation);
    notifyListeners();
  }

  void editDonationStatus(int index, String newStatus) {
    _donations[index].status = newStatus;
    notifyListeners();
  }
}
