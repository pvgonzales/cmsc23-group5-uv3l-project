import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_project/api/auth_api.dart';
import 'package:flutter_project/model/donation_model.dart';
import 'package:flutter_project/provider/auth_provider.dart';
import 'package:flutter_project/provider/donation_provider.dart';
import 'package:flutter_project/screens/organization-view/donations.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomeScreenOrg extends StatefulWidget {
  const HomeScreenOrg({super.key});

  @override
  State<HomeScreenOrg> createState() => _HomeScreenOrgState();
}

class _HomeScreenOrgState extends State<HomeScreenOrg> {
  final TextEditingController _searchController = TextEditingController();

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
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

  final FirebaseAuthApi authApi = FirebaseAuthApi();

  @override
  Widget build(BuildContext context) {
    final UserAuthProvider userProvider =
      Provider.of<UserAuthProvider>(context, listen: false);
  final DonationProvider donationProvider =
      Provider.of<DonationProvider>(context, listen: false);

  String? username = userProvider.currentUsername;

    return FutureBuilder(
      future: donationProvider.fetchDonationsByOrganizationName(username!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF212738),
            title: Column(
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
                      backgroundImage: AssetImage(
                          "assets/images/orglogo2.png"), // Replace with your image path
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Hello there,",
                          style: TextStyle(
                            fontFamily: "MyFont1",
                            color: Color.fromARGB(255, 248, 249, 252),
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 0), // Adjust the spacing here
                        Text(
                          "Org Name",
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
                SizedBox(height: 20),
                Center(
                  // Centering the search bar
                  child: Container(
                    // Wrapping with a container to control width
                    width: MediaQuery.of(context).size.width *
                        0.8, // Adjust width as needed
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        hintText: 'Search donations...',
                        hintStyle: TextStyle(
                          fontFamily: "MyFont1",
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
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
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(82, 255, 207, 205),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text.rich(
                      TextSpan(
                        style: TextStyle(
                          color: Color(0xFF212738),
                          fontFamily: "MyFont1",
                        ),
                        children: [
                          TextSpan(text: "Empower Change:\n"),
                          TextSpan(
                            text: "Be the Catalyst in Someone's Life!",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "MyFont1",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 23),
                    child: Row(
                      children: [
                        Text(
                          "Donations",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "MyFont1",
                            color: Color(0xFF212738),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Consumer<DonationProvider>(
                    builder: (context, provider, child) {
                      List<Donation> donations = donationProvider.donations;
                      if (provider.isLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (donations.isEmpty) {
                        return Center(child: Text('No donations found.'));
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: donations.length,
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
                                '${donations[index].id}',
                                style: TextStyle(
                                  fontFamily: "MyFont1",
                                  color: Color(0xFF212738),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DonationStatus(
                                              donation: donations[index]),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.remove_red_eye),
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
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QRScanner()),
              );
            },
            child: const Icon(Icons.qr_code_scanner_rounded),
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
            currentIndex: _selectedIndex,
            selectedItemColor: Color.fromARGB(255, 243, 164, 160),
            onTap: _onItemTapped,
            unselectedItemColor: Colors.white,
          ),
        );
        }
  });
  }
}

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<StatefulWidget> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QR Scanner")),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 300,
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      final donationId = int.tryParse(scanData.code ?? '');
      if (donationId != null) {
        Provider.of<DonationProvider>(context, listen: false)
            .editDropOffStatus(donationId, 'Confirmed');
      }
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
