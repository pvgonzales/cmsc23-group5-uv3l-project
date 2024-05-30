import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String? uid;
  String? fullname;
  String? username;
  String? phoneNumber;
  String? address;
  String? usertype;
  String? photo;

  void updateUserDetails({
    String? uid,
    String? fullname,
    String? username,
    String? phoneNumber,
    String? address,
  }) {
    this.uid = uid;
    this.fullname = fullname;
    this.username = username;
    this.phoneNumber = phoneNumber;
    this.address = address;
    notifyListeners();
  }
}
