import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../api/auth_api.dart';

class UserAuthProvider with ChangeNotifier {
  late FirebaseAuthApi authService;
  late Stream<User?> _userStream;

  Stream<User?> get userStream => _userStream;
  User? get user => authService.getUser();
  
  // Class constructor
  UserAuthProvider() {
    // TODO init _userStream
    authService = FirebaseAuthApi();
    fetchUser();
  }

  void fetchUser() {
    _userStream = authService.fetchUser();
  }

  Future<void> signOut() async {
    await authService.signOut();
  }

}