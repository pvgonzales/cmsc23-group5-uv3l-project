import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project/api/auth_api.dart';
import 'package:flutter_project/model/donation_model.dart';
import 'package:flutter_project/provider/donation_provider.dart';
import 'package:flutter_project/screens/admin-view/navbar.dart';
import 'package:provider/provider.dart';

class DonationScreenAdmin extends StatefulWidget {
  @override
  _DonationScreenAdminState createState() => _DonationScreenAdminState();
}

class _DonationScreenAdminState extends State<DonationScreenAdmin> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<DonationProvider>(context, listen: false).fetchDonations();
  }

  final FirebaseAuthApi authApi = FirebaseAuthApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 13),
              child: Text(
                "Donations",
                style: TextStyle(
                  fontFamily: "MyFont1",
                  color: Color(0xFF212738),
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Consumer<DonationProvider>(
              builder: (context, provider, child) {
                List<Donation> donations = provider.donations;
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
                      color: Color.fromARGB(255, 238, 243, 251),
                      elevation: 3,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      child: ExpansionTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Donation ID',
                                  style: TextStyle(
                                      fontFamily: "MyFont1",
                                      color: Color(0xFF212738),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  '${donations[index].id}',
                                  style: TextStyle(
                                    fontFamily: "MyFont1",
                                    color: Color(0xFF212738),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Flexible(
                              child: Container(
                                width: 80, // Adjust the width as needed
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${donations[index].status}',
                                      style: TextStyle(
                                        fontFamily: "MyFont1",
                                        color: Color(0xFF212738),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8), // Set padding here
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Items: ${donations[index].items.join(', ')}',
                                        style: TextStyle(
                                          fontFamily: "MyFont1",
                                          color: Color(0xFF212738),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        'Logistics: ${donations[index].logistics}',
                                        style: TextStyle(
                                          fontFamily: "MyFont1",
                                          color: Color(0xFF212738),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                      if (donations[index].address != null)
                                        Text(
                                          'Address: ${donations[index].address}',
                                          style: TextStyle(
                                            fontFamily: "MyFont1",
                                            color: Color(0xFF212738),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                      if (donations[index].phoneNum != null)
                                        Text(
                                          'Phone: ${donations[index].phoneNum}',
                                          style: TextStyle(
                                            fontFamily: "MyFont1",
                                            color: Color(0xFF212738),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                      Text(
                                        'Date: ${donations[index].date}',
                                        style: TextStyle(
                                          fontFamily: "MyFont1",
                                          color: Color(0xFF212738),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        'Time: ${donations[index].time}',
                                        style: TextStyle(
                                          fontFamily: "MyFont1",
                                          color: Color(0xFF212738),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ))
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
