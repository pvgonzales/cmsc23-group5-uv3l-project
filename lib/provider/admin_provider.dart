// Inside your AdminProvider class

import 'package:flutter/material.dart';
import 'package:flutter_project/model/donation_model.dart';
import 'package:flutter_project/model/org_model.dart';
import 'package:flutter_project/provider/donation_provider.dart';
import 'package:flutter_project/provider/orgdrive_provider.dart';
import 'package:flutter_project/api/org_api.dart'; // Import your OrgApi class

class AdminProvider extends ChangeNotifier {
  final OrganizationProvider _organizationProvider;
  final DonationProvider _donationProvider;
  final OrgApi _orgApi = OrgApi(); // Instance of your OrgApi class

  AdminProvider(this._organizationProvider, this._donationProvider);

  List<Organizations> get organizations => _organizationProvider.organizations;
  List<Donation> get donations => _donationProvider.donations;

  void approveOrganizationSignUp(Organizations organization) async {
    int index = _organizationProvider.organizations
        .indexWhere((org) => org.uid == organization.uid);
    _organizationProvider.organizations[index].status = true;
    notifyListeners();

    try {
      // Call the updateOrganizationStatus method from your OrgApi class
      await _orgApi.updateOrganizationStatus(organization.uid, true);
    } catch (e) {
      print("Error updating organization status: $e");
      // Handle error if necessary
    }
  }
}
