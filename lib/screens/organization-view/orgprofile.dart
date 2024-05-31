import 'package:flutter/material.dart';
import 'package:flutter_project/provider/auth_provider.dart';
import 'package:flutter_project/provider/orgdrive_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/model/user_model.dart';

class OrgProfile extends StatefulWidget {
  final bool? initialStatus;
  const OrgProfile({super.key, this.initialStatus});

  @override
  State<OrgProfile> createState() => _OrgProfileState();
}

class _OrgProfileState extends State<OrgProfile> {
  late bool status;

  @override
  void initState() {
    super.initState();
    //status = widget.initialStatus!; // CORRECT APPROACH FOR US TO GET THE CURRENT STATUS OF AN ORG (FIREBASE)
    status = true;
  }

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/org-home-page');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/donation-drives');
        break;
      case 2:
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
        backgroundColor: const Color(0xFF212738),
        title: const Column(
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
        padding: const EdgeInsets.only(top: 40, bottom: 20, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 60,
              backgroundImage: AssetImage('assets/images/orglogo3.png'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Full Name:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: "MyFont1",
                  ),
                ),
                Text(
                  userModel.fullname ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: "MyFont1",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Username:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: "MyFont1",
                  ),
                ),
                Text(
                  userModel.username ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: "MyFont1",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Phone Number:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: "MyFont1",
                  ),
                ),
                Text(
                  userModel.phoneNumber ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: "MyFont1",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Address:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: "MyFont1",
                  ),
                ),
                Text(
                  userModel.address ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: "MyFont1",
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                children: [
                  const Text('Status for accepting donations'),
                  Switch(
                    thumbIcon: thumbIcon,
                    value: status,
                    onChanged: (bool value) {
                      setState(() {
                        status = value;
                      });
                      Provider.of<OrganizationProvider>(context, listen: false)
                      .updateOrganizationStatus(3, status); // 3 is a hardcoded value, it must be the id of the 'organization' user
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  context.read<UserAuthProvider>().authService.signOut();
                  Navigator.pushNamed(context, "/");
                },
                child: const Text(
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
        backgroundColor: const Color(0xFF212738),

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.domain_verification_rounded),
            label: 'Drives',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 2, // Set the current index to indicate the profile screen
        onTap: (index) => _onItemTapped(context, index),
        selectedItemColor: const Color.fromARGB(255, 243, 164, 160),
        unselectedItemColor: Colors.white,
      ),
    );
  }
}
