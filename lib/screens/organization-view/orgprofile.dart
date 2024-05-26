import 'package:flutter/material.dart';
import 'package:flutter_project/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/model/user_model.dart';

class OrgProfile extends StatelessWidget {
  const OrgProfile({super.key});

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
        title: const Text('Organization Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Organization: ${userModel.fullname ?? 'N/A'}'),
            Text('Username: ${userModel.username ?? 'N/A'}'),
            Text('Phone Number: ${userModel.phoneNumber ?? 'N/A'}'),
            Text('Address: ${userModel.address ?? 'N/A'}'),
          ],
        ),
      ),
    );
  }
}
