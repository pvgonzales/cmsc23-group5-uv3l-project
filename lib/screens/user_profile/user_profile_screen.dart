import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/model/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Full Name: ${userModel.fullname}'),
            Text('Username: ${userModel.username}'),
            Text('Phone Number: ${userModel.phoneNumber}'),
            Text('Address: ${userModel.address}'),
          ],
        ),
      ),
    );
  }
}
