import 'package:flutter/material.dart';
import 'package:flutter_project/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/model/user_model.dart';

class OrgProfile extends StatelessWidget {
  const OrgProfile({super.key});

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/org-home-page');
        break;
      case 1:
        // Already on the profile screen
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/');
        break;
    }
  }

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
        backgroundColor: Color(0xFF212738),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Row(
              children: [
                SizedBox(
                  width: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Organization Profile",
                      style: TextStyle(
                        fontFamily: "MyFont1",
                        color: Color.fromARGB(255, 248, 249, 252),
                        fontWeight: FontWeight.w900,
                        fontSize: 23,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
        toolbarHeight: 150,
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 40, bottom: 20, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 60,
              backgroundImage: AssetImage('assets/images/orglogo3.png'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Full Name:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: "MyFont1",
                  ),
                ),
                Text(
                  userModel.fullname ?? 'N/A',
                  style: TextStyle(
                    fontSize: 13,
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
                    fontSize: 15,
                    fontFamily: "MyFont1",
                  ),
                ),
                Text(
                  userModel.username ?? 'N/A',
                  style: TextStyle(
                    fontSize: 13,
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
                    fontSize: 15,
                    fontFamily: "MyFont1",
                  ),
                ),
                Text(
                  userModel.phoneNumber ?? 'N/A',
                  style: TextStyle(
                    fontSize: 13,
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
                    fontSize: 15,
                    fontFamily: "MyFont1",
                  ),
                ),
                Text(
                  userModel.address ?? 'N/A',
                  style: TextStyle(
                    fontSize: 13,
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
                  Navigator.pushNamed(context, "/");
                },
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontFamily: "MyFont1",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: 1, // Set the current index to indicate the profile screen
        selectedItemColor: Colors.blue,
        onTap: (index) => _onItemTapped(context, index),
      ),
    );
  }
}
