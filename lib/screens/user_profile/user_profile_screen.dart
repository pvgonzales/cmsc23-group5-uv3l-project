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

    return ListView(
      children: [
        Container(
          padding: EdgeInsets.only(top: 0, bottom: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 80,
                backgroundImage: AssetImage('assets/images/usericon1.png'),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Full Name:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: "MyFont1",
                    ),
                  ),
                  Text(
                    userModel.fullname ?? 'N/A',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "MyFont1",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Username:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: "MyFont1",
                    ),
                  ),
                  Text(
                    userModel.username ?? 'N/A',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "MyFont1",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Phone Number:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: "MyFont1",
                    ),
                  ),
                  Text(
                    userModel.phoneNumber ?? 'N/A',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "MyFont1",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Address:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: "MyFont1",
                    ),
                  ),
                  Text(
                    userModel.address ?? 'N/A',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "MyFont1",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
                  },
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontFamily: "MyFont1",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
