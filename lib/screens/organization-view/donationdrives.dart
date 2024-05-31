import 'package:flutter/material.dart';
import 'package:flutter_project/model/donationdrive_model.dart';
import 'package:flutter_project/provider/auth_provider.dart';
import 'package:flutter_project/provider/donationdrive_provider.dart';
import 'package:flutter_project/screens/organization-view/modal.dart';
import 'package:provider/provider.dart';

class DonationDriveScreen extends StatefulWidget {
  const DonationDriveScreen({super.key});

  @override
  State<DonationDriveScreen> createState() => _DonationDriveScreenState();
}

class _DonationDriveScreenState extends State<DonationDriveScreen> {
  int _selectedIndex = 0;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final userProvider = Provider.of<UserAuthProvider>(context, listen: false);
      final donationDriveProvider = Provider.of<DonationDriveProvider>(context, listen: false);
      String? orgName = userProvider.currentUsername;
      if (orgName != null) {
        donationDriveProvider.fetchCurrentOrgDrives(orgName);
      }
      _isInit = false;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.pushNamed(context, '/org-home-page');
          break;
        case 1:
          Navigator.pushNamed(context, '/donation-drives');
          break;
        case 2:
          Navigator.pushNamed(context, '/org-profile');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF212738),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage("assets/images/orglogo2.png"),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Org Name's",
                      style: TextStyle(
                        fontFamily: "MyFont1",
                        color: Color.fromARGB(255, 248, 249, 252),
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 0), // Adjust the spacing here
                    Text(
                      "Donation Drives",
                      style: TextStyle(
                        fontFamily: "MyFont1",
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        toolbarHeight: 190,
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<DonationDriveProvider>(
                builder: (context, provider, child) {
                  List<DonationDrive> donationsdrives = provider.orgdrives;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: donationsdrives.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          title: Text(
                            donationsdrives[index].name,
                            style: TextStyle(
                              fontFamily: "MyFont1",
                              color: Color(0xFF212738),
                              fontWeight: FontWeight.w900,
                              fontSize: 13,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        DriveModal(
                                      type: 'Edit',
                                      index: index,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.create_outlined),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        DriveModal(
                                            type: 'Delete', index: index),
                                  );
                                },
                                icon: const Icon(Icons.delete_outlined),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => const DriveModal(
              type: 'Add',
              index: -1,
            ),
          );
        },
        child: const Icon(Icons.add_outlined),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF212738),
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
        currentIndex: 1,
        selectedItemColor: Color.fromARGB(255, 243, 164, 160),
        onTap: _onItemTapped,
        unselectedItemColor: Colors.white,
      ),
    );
  }
}
