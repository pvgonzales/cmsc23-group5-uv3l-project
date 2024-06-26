import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_project/model/donation_model.dart';
import 'package:flutter_project/provider/auth_provider.dart';
import 'package:flutter_project/provider/donation_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DonationsScreen extends StatelessWidget {
  const DonationsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final UserAuthProvider userProvider =
        Provider.of<UserAuthProvider>(context, listen: false);
    final DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);

    String? username = userProvider.currentUsername;
    donationProvider.fetchCurrentUserDonations(username!);
    
    return Scaffold(
      backgroundColor: Color(0xfff4f6ff),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'List of Donations',
              style: TextStyle(
                fontFamily: "MyFont3",
                color: Color(0xFF212738),
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: Consumer<DonationProvider>(
              builder: (context, donationProvider, _) {
                if (donationProvider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (donationProvider.donations.isEmpty) {
                  return const Center(
                    child: Text('No donations found.'),
                  );
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                    childAspectRatio: 0.85, // Aspect ratio for square cards
                  ),
                  itemCount: donationProvider.donations.length,
                  itemBuilder: (context, index) {
                    var donation = donationProvider.donations[index];
                    return DonationCard(donation: donation);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DonationCard extends StatelessWidget {
  final Donation donation;
  const DonationCard({Key? key, required this.donation}) : super(key: key);

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
    final TextStyle labelTextStyle = TextStyle(
        fontFamily: "MyFont1",
        color: Color(0xFF212738),
        fontWeight: FontWeight.w600,
        fontSize: 12);

    final TextStyle valueTextStyle = TextStyle(
        fontFamily: "MyFont1",
        color: Color(0xFF212738),
        fontWeight: FontWeight.w300,
        fontSize: 12);

    return Container(
      child: Card(
        color: Color(0xFF212738),
        elevation: 7,
        margin: EdgeInsets.symmetric(
          vertical: 7,
          horizontal: 7,
        ),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  backgroundColor: Colors.white,
                  contentPadding: EdgeInsets.only(
                      left: 26.0, right: 25, top: 20, bottom: 20),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.thumb_up,
                            size: 48,
                            color: Color(0xFF212738),
                          ),
                          SizedBox(height: 0),
                          Text(
                            'Thank You!',
                            style: TextStyle(
                              fontFamily: "MyFont1",
                              color: Color(0xFF212738),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(
                              0xFF212738), // Add your desired background color here
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Donation id: ${donation.id}',
                          style: TextStyle(
                            fontFamily: "MyFont1",
                            color: Colors.white, // Adjust text color as needed
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dontate to:',
                            style: labelTextStyle,
                          ),
                          Text(
                            '${donation.org}',
                            style: valueTextStyle,
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                'Items:',
                                style: labelTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.all(0),
                                child: Text(
                                  '${donation.items.join(', ')}',
                                  style: valueTextStyle,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Logistics:',
                            style: labelTextStyle,
                          ),
                          Text(
                            '${donation.logistics}',
                            style: valueTextStyle,
                          ),
                        ],
                      ),
                      if (donation.logistics == 'Pick up') ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Address:',
                              style: labelTextStyle,
                            ),
                            Text(
                              '${donation.address}',
                              style: valueTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Phone Number:',
                              style: labelTextStyle,
                            ),
                            Text(
                              '${donation.phoneNum}',
                              style: valueTextStyle,
                            ),
                          ],
                        ),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date:',
                            style: labelTextStyle,
                          ),
                          Text(
                            '${donation.date}',
                            style: valueTextStyle,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Time:',
                            style: labelTextStyle,
                          ),
                          Text(
                            '${donation.time}',
                            style: valueTextStyle,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Status:',
                            style: labelTextStyle,
                          ),
                          Text(
                            '${donation.status}',
                            style: valueTextStyle,
                          ),
                        ],
                      ),
                      if (donation.proof != null)...[
                        Text('Proof of Donation', style: labelTextStyle,),
                        const SizedBox(height: 10,),
                        Center(
                          child: FutureBuilder<Widget>(
                            future: decodeBase64ToImage(donation.proof!),
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
                      ],
                      const SizedBox(
                        height: 0,
                      ),
                      if (donation.logistics == 'Drop-off' && donation.status == 'Pending')
                        (Column(children: [
                          QrImageView(
                            data:
                                "${donation.id}",
                            version: QrVersions.auto,
                            size: 140.0,
                          ),
                        ])),
                      SizedBox(
                        height: 0,
                      ),
                    ],
                  ),
                  actions: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if(donation.status != 'Canceled' && donation.status == 'Pending')...[
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Cancel Donation"),
                                      content: const Text("Are you sure you want to cancel this donation?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Provider.of<DonationProvider>(context, listen: false)
                                              .cancelDonation(donation.id);
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop(); 
                                            ScaffoldMessenger.of(context)
                                              ..removeCurrentSnackBar()
                                              ..showSnackBar(
                                                const SnackBar(content: Text('Donation Canceled')),
                                              );
                                          },
                                          child: Text("Yes"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Close the dialog
                                          },
                                          child: const Text("No"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  fontFamily: "MyFont1",
                                  color: Color.fromARGB(255, 194, 23, 23), // Adjust text color as needed
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Close',
                              style: TextStyle(
                                fontFamily: "MyFont1",
                                color: Color(
                                    0xFF212738), // Adjust text color as needed
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ]
                      ),
                    )
                  ],
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/org1.jpg',
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  'Donation ID: ${donation.id}',
                  style: TextStyle(
                    fontFamily: "MyFont1",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'For ${donation.logistics}',
                  style: TextStyle(
                    fontFamily: "MyFont1",
                    color: Colors.white,
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
