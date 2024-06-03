import 'package:flutter/material.dart';
import 'package:flutter_project/api/org_api.dart';
import 'package:flutter_project/model/org_model.dart';

class OrganizationProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<Organizations> _filteredOrgs = [];

  OrganizationProvider() {
    _filteredOrgs = [];
  }

  bool get isLoading => _isLoading;

  List<Organizations> get organizations => _filteredOrgs; 

  Future<void> fetchOrganizations() async {
    _isLoading = true;
    notifyListeners();

    List<Organizations> orgs = await OrgApi().fetchOrganizations();
    _filteredOrgs = orgs;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchApprovedOrganizations() async {
    _isLoading = true;
    notifyListeners();

    List<Organizations> orgs = await OrgApi().fetchApprovedOrganizations();
    _filteredOrgs = orgs;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchOrganizationByUsername(String username) async {
    _isLoading = true;
    notifyListeners();

    try {
      List<Organizations> fetchedOrg = await OrgApi().fetchOrganizationByUsername(username);
      _filteredOrgs = fetchedOrg;
      notifyListeners();

    } catch (e) {
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }

Future<List<Organizations>> filterOrganizationsByCategory(String category) async {
    List<Organizations> orgs = await OrgApi().filterOrganizationsByCategory(category);
    _filteredOrgs = orgs;
    notifyListeners();
    return _filteredOrgs;
  }

  Future<void> updateOrganizationStatus(String id, bool newStatus) async{
    await OrgApi().updateOrganizationStatus(id, newStatus);
    notifyListeners();
  }

}
