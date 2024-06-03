import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/model/user_model.dart';
import 'package:provider/provider.dart';
import '../api/auth_api.dart';

class UserAuthProvider with ChangeNotifier {
  late FirebaseAuthApi authService;
  late Stream<User?> _userStream;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<UserModel> _users = [];
  List<UserModel> _donors = [];
  String? _currentUsername;

  List<UserModel> get users => _users;
  List<UserModel> get donors => _donors;

  Stream<User?> get userStream => _userStream;
  User? get user => authService.getUser();
  String? get currentUsername => _currentUsername;

  UserAuthProvider() {
    authService = FirebaseAuthApi();
    fetchUser();
    _userStream.listen((user) {
      if (user != null) {
        fetchCurrentUserData(user.uid);
      } else {
        _currentUsername = null;
        notifyListeners();
      }
    });
    fetchAllDonors();
  }

  void fetchUser() {
    _userStream = authService.fetchUser();
  }

  Future<void> fetchCurrentUserData(String uid) async {
    try {
      final userDoc = await _firestore.collection("users").doc(uid).get();
      if (userDoc.exists) {
        final data = userDoc.data()!;
        _currentUsername = data["username"];
        notifyListeners();
      }
    } catch (error) {
      print("Error fetching current user data: $error");
    }
  }

  Future<void> fetchUserData(String uid, BuildContext context) async {
    final userDoc = await _firestore.collection("users").doc(uid).get();
    if (userDoc.exists) {
      final data = userDoc.data()!;
      Provider.of<UserModel>(context, listen: false).updateUserDetails(
        uid: uid,
        fullname: data["fullName"],
        username: data["username"],
        phoneNumber: data["contact"],
        address: data["address"],
        usertype: data["usertype"], // Include the usertype field
      );
    }
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }

  Future<bool> isEmailAlreadyInUse(String email) async {
    return await authService.isEmailAlreadyInUse(email);
  }

  Future<bool> isUsernameAlreadyInUse(String username) async {
    return await authService.isUsernameAlreadyInUse(username);
  }

  Future<void> fetchAllUsers() async {
    try {
      final usersSnapshot = await _firestore.collection("users").get();
      _users.clear(); // Clear the existing list before adding new users
      usersSnapshot.docs.forEach((userDoc) {
        final userData = userDoc.data();
        if (userData != null) {
          UserModel user = UserModel();
          user.updateUserDetails(
            uid: userDoc.id,
            fullname: userData["fullName"],
            username: userData["username"],
            phoneNumber: userData["contact"],
            address: userData["address"],
            usertype: userData["usertype"],
            photo: userData["photo"],
          );
          _users.add(user); // Add the user to the list
        }
      });
      notifyListeners();
    } catch (error) {
      print("Error fetching users: $error");
    }
  }

  Future<void> fetchAllDonors() async {
    try {
      final donorsSnapshot = await _firestore
          .collection("users")
          .where("usertype", isEqualTo: "donor")
          .get();
      _donors.clear(); // Clear the existing list before adding new donors
      donorsSnapshot.docs.forEach((donorDoc) {
        final donorData = donorDoc.data();
        if (donorData != null) {
          UserModel donor = UserModel();
          donor.updateUserDetails(
            uid: donorDoc.id,
            fullname: donorData["fullName"],
            username: donorData["username"],
            phoneNumber: donorData["contact"],
            address: donorData["address"],
            usertype: donorData["usertype"],
            photo: donorData["photo"],
          );
          _donors.add(donor); // Add the donor to the list
        }
      });
      notifyListeners();
    } catch (error) {
      print("Error fetching donors: $error");
    }
  }
}
