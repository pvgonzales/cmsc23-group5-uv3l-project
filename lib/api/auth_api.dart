import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthApi {
  late FirebaseAuth auth;

  FirebaseAuthApi() {
    auth = FirebaseAuth.instance;
  }

  Stream<User?> fetchUser() {
    return auth.authStateChanges();
  }

  User? getUser() {
    return auth.currentUser;
  }

  Future<bool> isEmailAlreadyInUse(String email) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: 'password');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return false;
      }
      return false;
    }
  }

  Future<bool> isUsernameAlreadyInUse(String username) async {
    try {
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection("users")
          .where("username", isEqualTo: username)
          .get();
      if (query.docs.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<String> signUp(
      String fullName,
      String email,
      String username,
      String password,
      String contactNumber,
      String address,
      String type,
      String? image,
      String? orgdesc,
      String? orgtype) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .set({
        "uid": userCredential.user!.uid,
        "fullName": fullName,
        "email": email,
        "username": username,
        "contact": contactNumber,
        "address": address,
        "usertype": type,
      });

      if (type == "Organization") {
        await FirebaseFirestore.instance
            .collection("organizations")
            .doc(userCredential.user!.uid)
            .set({
          "uid": userCredential.user!.uid,
          "name": fullName,
          "email": email,
          "username": username,
          "contact": contactNumber,
          "address": address,
          "photo": image,
          "description": orgdesc,
          "status": false,
          "approved": false,
          "orgtype": orgtype,
          "usertype": type
        });
      }
      print("User created: ${userCredential.user!.uid}");
      return "Success";
      // return true;
    } on FirebaseException catch (e) {
      print("Firebase Error: ${e.code} : ${e.message}");
      return ("${e.message}");
      // return false;
    } catch (e) {
      return ("Error: $e");
      // return false;
    }
  }

  Future<Map<String, String>> signIn(String email, String password) async {
    try {
      UserCredential credentials = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(credentials.user!.uid)
          .get();

      if (userDoc.exists) {
        var userData = userDoc.data() as Map<String, dynamic>;
        String? userType = userData["usertype"];
        if (userType != null) {
          return {"status": "Success", "usertype": userType.toLowerCase()};
        } else {
          return {"status": "Error", "message": "User type not found"};
        }
      } else {
        return {"status": "Error", "message": "User document not found"};
      }
    } on FirebaseException catch (e) {
      return {
        "status": "Firebase Error",
        "message": "${e.code} : ${e.message}"
      };
    } catch (e) {
      return {"status": "Error", "message": "$e"};
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
