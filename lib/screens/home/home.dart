import 'package:flutter/material.dart';
import 'package:flutter_project/model/org_model.dart';
import 'package:flutter_project/provider/orgdrive_provider.dart';
import 'package:flutter_project/screens/home/categories.dart';
import 'package:flutter_project/screens/donations/donation.dart';
import 'package:flutter_project/screens/user_profile/user_profile_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<String> _appBarTitles = ['Home', 'My Donations', 'Profile'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrganizationProvider>(builder: (context, provider, _) {
      List<Organizations> orgdrivesItems = provider.orgdrives;
      return Scaffold(
        backgroundColor: Color(0xfff4f6ff),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: Color(0xFF212738),
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
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
                preferredSize: Size.fromHeight(55.0),
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
                          prefixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.symmetric(
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
              padding: EdgeInsets.only(left: 7, right: 7, top: 0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: _selectedIndex == 0
                    ? _buildHomeContent(orgdrivesItems)
                    : _selectedIndex == 1
                        ? DonationsScreen()
                        : ProfileScreen(),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF212738),
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
          selectedItemColor: Color.fromARGB(255, 243, 164, 160),
          onTap: _onItemTapped,
          unselectedItemColor: Colors.white,
        ),
      );
    });
  }

  Widget _buildHomeContent(List<Organizations> orgdrivesItems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 0,
              bottom: 16), // Adjust the top margin here
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
        const OrgCategories(),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Text(
                "Top Organizations",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "MyFont1",
                  color: Color(0xFF212738),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: orgdrivesItems.length,
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
                        child: Image.asset(
                          orgdrivesItems[index].image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          orgdrivesItems[index].name,
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
                              arguments: orgdrivesItems[index]);
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
}
