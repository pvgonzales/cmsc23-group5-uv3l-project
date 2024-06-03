import 'package:flutter/material.dart';
import 'package:flutter_project/model/user_model.dart';
import 'package:flutter_project/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class DonorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 25, top: 19, bottom: 15),
            child: Text(
              "Donors",
              style: TextStyle(
                fontFamily: "MyFont1",
                color: Color(0xFF212738),
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ),
          Expanded( 
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Consumer<UserAuthProvider>(
                builder: (context, userProvider, _) {
                  final List<UserModel> donors = userProvider.donors;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 13.0,
                      mainAxisSpacing: 13.0,
                      childAspectRatio: 1, // Adjust the aspect ratio as needed
                    ),
                    itemCount: donors.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _showDonorDetails(context, donors[index]);
                        },
                        child: Card(
                          color: Color.fromARGB(255, 238, 243, 251),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 17, left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage(
                                      "assets/images/usericon1.png"), // Replace with your image path
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${donors[index].username}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "MyFont1",
                                  ),
                                  maxLines: 2,
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDonorDetails(BuildContext context, UserModel donor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF212738),
          title: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),

            // Set your desired background color here
            child: Text(
              '${donor.username}\'s details',
              style: const TextStyle(
                  fontSize: 12,
                  fontFamily: "MyFont1",
                  color: Color(0xFF212738)),
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Username: ${donor.username}',
                style: const TextStyle(
                    fontSize: 12, fontFamily: "MyFont1", color: Colors.white),
              ),
              Text(
                'Full Name: ${donor.fullname}',
                style: const TextStyle(
                    fontSize: 12, fontFamily: "MyFont1", color: Colors.white),
              ),
              Text(
                'Phone: ${donor.phoneNumber}',
                style: const TextStyle(
                    fontSize: 12, fontFamily: "MyFont1", color: Colors.white),
              ),
              Text(
                'Address: ${donor.address}',
                style: const TextStyle(
                    fontSize: 12, fontFamily: "MyFont1", color: Colors.white),
              ),
            ],
          ),
          actions: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF212738),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
