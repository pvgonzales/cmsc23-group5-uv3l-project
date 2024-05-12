import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String? fullname;
  String? username;
  String? phoneNumber;
  String? address;

  void updateUserDetails({
    String? fullname,
    String? username,
    String? phoneNumber,
    String? address,
  }) {
    this.fullname = fullname;
    this.username = username;
    this.phoneNumber = phoneNumber;
    this.address = address;
    notifyListeners();
  }
}
