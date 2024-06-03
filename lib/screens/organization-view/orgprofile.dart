import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project/provider/auth_provider.dart';
import 'package:flutter_project/provider/orgdrive_provider.dart';
import 'package:provider/provider.dart';

class OrgProfile extends StatefulWidget {
  const OrgProfile({super.key});

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
    final UserAuthProvider userProvider =
        Provider.of<UserAuthProvider>(context, listen: false);
    final OrganizationProvider organizationProvider =
        Provider.of<OrganizationProvider>(context, listen: false);

    String? username = userProvider.currentUsername;

    return FutureBuilder(
      future: organizationProvider.fetchOrganizationByUsername(username!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final user = organizationProvider.organizations;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF212738),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            user[0].name,
                            style: const TextStyle(
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
              padding: const EdgeInsets.only(
                  top: 40, bottom: 20, left: 30, right: 30),
              child: user.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 60,
                          backgroundImage:
                              AssetImage('assets/images/orglogo3.png'),
                        ),
                        const SizedBox(height: 20),
                        Flexible(
                          child: AutoSizeText(
                            //"Angat Buhay Foundation, incorporated as Angat Pinas, Inc., is a non-profit, non-governmental organization based in the Philippines. It was founded and officially launched on July 1, 2022, a day after its founder Leni Robredo's term as Vice President of the Philippines expired.",
                            user[0].description,
                            style: const TextStyle(
                              fontFamily: "MyFont1",
                              fontWeight: FontWeight.w900,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 5,
                            minFontSize: 13,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 20),
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
                              user[0].username,
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
                              'Orginzation Type:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                fontFamily: "MyFont1",
                              ),
                            ),
                            Text(
                              user[0].type,
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
                              user[0].contact,
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
                              user[0].address,
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
                                value: user[0].status,
                                onChanged: (bool value) {
                                  if (user[0].approved == true) {
                                    setState(() {
                                      status = value;
                                      user[0].status = value;
                                    });
                                    Provider.of<OrganizationProvider>(context,
                                            listen: false)
                                        .updateOrganizationStatus(
                                            user[0].uid, value);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              context.read<UserAuthProvider>().signOut();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "/", (route) => false);
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
                    )
                  : const Center(
                      child: Text(
                        'No organization data available.',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "MyFont1",
                        ),
                      ),
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
              currentIndex:
                  2, // Set the current index to indicate the profile screen
              onTap: (index) => _onItemTapped(context, index),
              selectedItemColor: const Color.fromARGB(255, 243, 164, 160),
              unselectedItemColor: Colors.white,
            ),
          );
        }
      },
    );
  }
}
