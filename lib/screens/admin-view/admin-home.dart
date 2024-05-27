import 'package:flutter/material.dart';
import 'package:flutter_project/model/donation_model.dart';
import 'package:flutter_project/model/org_model.dart';
import 'package:flutter_project/model/user_model.dart'; // Import UserModel
import 'package:flutter_project/provider/admin_provider.dart';
import 'package:flutter_project/provider/auth_provider.dart';
import 'package:flutter_project/provider/donation_provider.dart';
import 'package:flutter_project/provider/orgdrive_provider.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<UserAuthProvider>(context, listen: false).fetchAllUsers();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Organizations",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Builder(
              builder: (context) {
                final organizationProvider =
                    Provider.of<OrganizationProvider>(context, listen: false);
                final List<Organizations> organizations =
                    organizationProvider.orgdrives;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: organizations.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(organizations[index].name),
                      subtitle: Text(organizations[index].description),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Provider.of<AdminProvider>(context, listen: false)
                              .approveOrganizationSignUp(organizations[index]);
                        },
                        child: Text("Approve"),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Donations",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Builder(
              builder: (context) {
                final donationProvider =
                    Provider.of<DonationProvider>(context, listen: false);
                final List<Donation> donations = donationProvider.donations;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: donations.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Donation ${donations[index].id}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Items: ${donations[index].items.join(', ')}'),
                          Text('Logistics: ${donations[index].logistics}'),
                          if (donations[index].address != null)
                            Text('Address: ${donations[index].address}'),
                          if (donations[index].phoneNum != null)
                            Text('Phone: ${donations[index].phoneNum}'),
                          Text('Date: ${donations[index].date}'),
                          Text('Time: ${donations[index].time}'),
                          Text('Status: ${donations[index].status}'),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Donors",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Builder(
              builder: (context) {
                final userProvider = Provider.of<UserAuthProvider>(context,
                    listen: true); // Listen to changes in users list
                final List<UserModel> donors = userProvider.users;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: donors.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Donor ${donors[index].username}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Full Name: ${donors[index].fullname}'),
                          Text('Phone: ${donors[index].phoneNumber}'),
                          Text('Address: ${donors[index].address}'),
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
}
