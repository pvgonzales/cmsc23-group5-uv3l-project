import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_project/model/org_model.dart';
import 'package:flutter_project/provider/orgdrive_provider.dart';
import 'package:flutter_project/screens/home/categories.dart';
import 'package:flutter_project/screens/donations/donation.dart';
import 'package:flutter_project/screens/user_profile/user_profile_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<Widget> decodeBase64ToImage(String base64Image) async {
  try {
    Uint8List decodedBytes = base64Decode(base64Image);
    Image image = Image.memory(decodedBytes);
    
    return image;
  } catch (e) {
    throw Exception("Error decoding base64 to Image: $e");
  }
}
      
  @override
  Widget build(BuildContext context) {
    final OrganizationProvider organizationProvider =
    Provider.of<OrganizationProvider>(context, listen: false);
    return FutureBuilder(
      future: organizationProvider.fetchApprovedOrganizations(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else {
        final organizations = organizationProvider.organizations;
      return Scaffold(
        backgroundColor: const Color(0xfff4f6ff),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFF212738),
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: const FlexibleSpaceBar(
                titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 90),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(
                          "assets/images/image1.png"), // Replace with your image path
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                            fontFamily: "MyFont1",
                            color: Color.fromARGB(255, 248, 249, 252),
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 0), // Adjust the spacing here
                        Text(
                          "Dear Donor",
                          style: TextStyle(
                            fontFamily: "MyFont1",
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    // Adjust the spacing between the title and the image
                  ],
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(55.0),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 28),
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search organizations',
                          prefixIcon: const Icon(Icons.search),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8.0), // Adjust padding here

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (value) {
                          // Handle search logic here
                        },
                      ),
                    )),
              ),
            ),
          ],
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 7, right: 7, top: 0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: _selectedIndex == 0
                    ? _buildHomeContent(organizations)
                    : _selectedIndex == 1
                        ? const DonationsScreen()
                        : const ProfileScreen(),
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
              icon: Icon(Icons.favorite),
              label: 'My Donations',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 243, 164, 160),
          onTap: _onItemTapped,
          unselectedItemColor: Colors.white,
        ),
      );
  }});
  }

  Widget _buildHomeContent(List<Organizations> organizations) {

    void updateFilteredOrgs(List<Organizations> orgs) {
      setState(() {
        organizations = orgs;
      });
    }

    return Consumer<OrganizationProvider>(
      builder: (context, provider, _) {
        List<Map<String, dynamic>> categories = [
          {"icon": "assets/images/home1.png", "text": "Non-Profit", "type": "Non-Profit"},
          {"icon": "assets/images/home2.png", "text": "Religious", "type": "Religious"},
          {"icon": "assets/images/home3.png", "text": "Academic", "type": "Academic"},
          {"icon": "assets/images/home4.png", "text": "Health", "type": "Health"},
          {"icon": "assets/images/home5.png", "text": "Others", "type": "Others"},
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 0,
                  bottom: 16), // Adjust the top margin here
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(82, 255, 207, 205),
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
                      text: "Donate Today, Transform Tomorrow!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Row(
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "MyFont3",
                      color: Color(0xFF212738),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  categories.length,
                  (index) => CategoryCard(
                    icon: categories[index]["icon"],
                    text: categories[index]["text"],
                    press: () async {
                      String selectedType = categories[index]["type"];
                      organizations = await provider.filterOrganizationsByCategory(selectedType);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Row(
                children: [
                  Text(
                    "Top Organizations",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "MyFont3",
                      color: Color(0xFF212738),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: organizations.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Center(
                            child: FutureBuilder<Widget>(
                              future: decodeBase64ToImage(organizations[index].image),
                              builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return SizedBox(
                                      height: 150,
                                      child: snapshot.data,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              organizations[index].name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "MyFont1",
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              var res = await Navigator.pushNamed(
                                  context, '/org-details',
                                  arguments: organizations[index]);
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(
                                    SnackBar(content: Text(res as String)));
                            },
                            icon: const Icon(Icons.arrow_right),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        );
      }
    );
  }
}
