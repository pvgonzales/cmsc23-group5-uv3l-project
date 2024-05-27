import 'package:flutter/material.dart';
import 'package:flutter_project/model/org_model.dart';
import 'package:flutter_project/provider/orgdrive_provider.dart';
import 'package:flutter_project/screens/organization-view/modal.dart';
import 'package:flutter_project/screens/organization-view/orgprofile.dart';
import 'package:provider/provider.dart';

class HomeScreenOrg extends StatefulWidget {
  const HomeScreenOrg({super.key});

  @override
  State<HomeScreenOrg> createState() => _HomeScreenOrgState();
}

class _HomeScreenOrgState extends State<HomeScreenOrg> {
  final TextEditingController _searchController = TextEditingController();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.pushNamed(context, '/org-home-page');
          break;
        case 1:
          Navigator.pushNamed(context, '/org-profile');

          break;
        case 2:
          Navigator.pushNamed(context, '/');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
      drawer: drawer,
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
              Consumer<OrganizationProvider>(
                builder: (context, provider, child) {
                  List<Organizations> orgdrivesItems = provider.orgdrives;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: orgdrivesItems.length,
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
                          title: Text(orgdrivesItems[index].name),
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
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/list-donations');
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  Drawer get drawer => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                "Organization",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OrgProfile()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home Page'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/org-home-page");
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
}
