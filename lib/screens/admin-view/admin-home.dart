import 'package:flutter/material.dart';
import 'package:flutter_project/model/donation_model.dart';
import 'package:flutter_project/model/org_model.dart';
import 'package:flutter_project/model/user_model.dart'; // Import UserModel
import 'package:flutter_project/provider/admin_provider.dart';
import 'package:flutter_project/provider/auth_provider.dart';
import 'package:flutter_project/provider/donation_provider.dart';
import 'package:flutter_project/provider/orgdrive_provider.dart';
import 'package:flutter_project/screens/admin-view/admin-donation.dart';
import 'package:flutter_project/screens/admin-view/admin-donors.dart';
import 'package:flutter_project/screens/admin-view/navbar.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController _searchController = TextEditingController();

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<OrganizationProvider>(context, listen: false).fetchOrganizations();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserAuthProvider>(context, listen: false).fetchAllUsers();

    List<Widget> _tabs = [
      // Organizations Tab
      SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 13),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontFamily: "MyFont1",
                  color: Color(0xFF212738),
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
            ),
            const SizedBox(height: 5),
            const OrgCategories(),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 13),
              child: Text(
                "Organizations",
                style: TextStyle(
                  fontFamily: "MyFont1",
                  color: Color(0xFF212738),
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
            ),
            const SizedBox(height: 5),
            // Builder(
            //   builder: (context) {
            //     final organizationProvider =
            //         Provider.of<OrganizationProvider>(context, listen: false);
            //     final List<Organizations> organizations =
            //         organizationProvider.organizations;
            //     return ListView.builder(
            //       shrinkWrap: true,
            //       physics: NeverScrollableScrollPhysics(),
            //       itemCount: organizations.length,
            //       itemBuilder: (context, index) {
            //         return ExpandableCard(
            //           title: organizations[index].name,
            //           description: organizations[index].description,
            //           onPressed: () {
            //             Provider.of<AdminProvider>(context, listen: false)
            //                 .approveOrganizationSignUp(organizations[index]);
            //           },
            //         );
            //       },
            //     );
            //   },
            // ),
            Consumer<OrganizationProvider>(
              builder: (context, organizationProvider, child) {
                if (organizationProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                final List<Organizations> organizations = organizationProvider.organizations;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: organizations.length,
                  itemBuilder: (context, index) {
                    return ExpandableCard(
                      title: organizations[index].name,
                      description: organizations[index].description,
                      onPressed: () {
                        Provider.of<AdminProvider>(context, listen: false)
                            .approveOrganizationSignUp(organizations[index]);
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      // Donations Tab
      DonationScreenAdmin(),
      DonorsScreen(), // Donors Tab
    ];

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
                      "assets/images/admin.png"), // Replace with your image path
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Welcome back,",
                      style: TextStyle(
                        fontFamily: "MyFont1",
                        color: Color.fromARGB(255, 248, 249, 252),
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 0), // Adjust the spacing here
                    Text(
                      "Admin",
                      style: TextStyle(
                        fontFamily: "MyFont1",
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 60,
                ),
                IconButton(
                  icon: Icon(Icons.logout),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, "/");
                  },
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
      body: _tabs[_selectedIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class OrgCategories extends StatelessWidget {
  const OrgCategories({super.key});

  @override
  Widget build(BuildContext context) {
    // SUBJECT TO CHANGE (must be in firebase)
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/images/home1.png", "text": "Non-Profit"},
      {"icon": "assets/images/home2.png", "text": "Religious"},
      {"icon": "assets/images/home3.png", "text": "Academic"},
      {"icon": "assets/images/home4.png", "text": "Health"},
      {"icon": "assets/images/home5.png", "text": "Others"},
    ];
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        spacing: 10.0, // Adjust spacing between items
        runSpacing: 10.0, // Adjust spacing between rows
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {},
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key, required this.icon, required this.text, required this.press});

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 96,
            width: 96,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 238, 243, 251),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(icon),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              fontFamily: "MyFont1",
              color: Color(0xFF212738),
            ),
          )
        ],
      ),
    );
  }
}

class ExpandableCard extends StatefulWidget {
  final String title;
  final String description;
  final VoidCallback onPressed;

  const ExpandableCard({
    Key? key,
    required this.title,
    required this.description,
    required this.onPressed,
  }) : super(key: key);

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 238, 243, 251),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(15), // Add padding to the image
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // Add border radius
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Add border radius
              child: Image.asset(
                "assets/images/org1.jpg",
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, bottom: 16, top: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: "MyFont1",
                      ),
                    ),
                  ),
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                  ),
                ],
              ),
            ),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.description,
                style: TextStyle(
                    fontFamily: "MyFont1",
                    color: Color(0xFF212738),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontStyle: FontStyle.italic),
              ),
            ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: widget.onPressed,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFF212738), // Change button color here
                  ),
                ),
                child: Text(
                  "Approve",
                  style: TextStyle(
                    fontFamily: "MyFont1",
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
