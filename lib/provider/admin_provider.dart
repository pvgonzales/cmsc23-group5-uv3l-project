import 'package:flutter/material.dart';
import 'package:flutter_project/model/donation_model.dart';
import 'package:flutter_project/model/org_model.dart';
import 'package:flutter_project/provider/orgdrive_provider.dart';
import 'package:flutter_project/provider/donation_provider.dart';

class AdminProvider extends ChangeNotifier {
  final OrganizationProvider _organizationProvider;
  final DonationProvider _donationProvider;

  AdminProvider(this._organizationProvider, this._donationProvider);

  List<Organizations> get organizations => _organizationProvider.orgdrives;
  List<Donation> get donations => _donationProvider.donations;

  // Add methods for approving organization sign up
  void approveOrganizationSignUp(Organizations organization) {
    // Implement logic to approve organization sign up
  }
}
