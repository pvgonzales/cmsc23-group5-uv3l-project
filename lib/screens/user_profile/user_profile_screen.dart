import 'package:flutter/material.dart';
import 'package:flutter_project/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/model/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    final userAuthProvider = Provider.of<UserAuthProvider>(context);

    final user = userAuthProvider.user;
    if (user != null) {
      userAuthProvider.fetchUserData(user.uid, context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Full Name: ${userModel.fullname ?? 'N/A'}'),
            Text('Username: ${userModel.username ?? 'N/A'}'),
            Text('Phone Number: ${userModel.phoneNumber ?? 'N/A'}'),
            Text('Address: ${userModel.address ?? 'N/A'}'),
          ],
        ),
      ),
    );
  }
}
