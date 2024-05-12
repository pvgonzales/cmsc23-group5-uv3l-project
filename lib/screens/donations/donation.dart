import 'package:flutter/material.dart';
import 'package:flutter_project/provider/donation_provider.dart';
import 'package:provider/provider.dart';

class DonationsScreen extends StatelessWidget {
  const DonationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Donations'),
      ),
      body: Consumer<DonationProvider>(
        builder: (context, donationProvider, _) {
          if (donationProvider.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (donationProvider.donations.isEmpty) {
            return Center(
              child: Text('No donations found.'),
            );
          }
          return ListView.builder(
            itemCount: donationProvider.donations.length,
            itemBuilder: (context, index) {
              var donation = donationProvider.donations[index];
              return ListTile(
                title: Text('Donation ID: ${donation.id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Items: ${donation.items.join(', ')}'),
                    Text('Logistics: ${donation.logistics}'),
                    if (donation.address != null)
                      Text('Address: ${donation.address}'),
                    if (donation.phoneNum != null)
                      Text('Phone Number: ${donation.phoneNum}'),
                    Text('Date: ${donation.date}'),
                    Text('Date: ${donation.time}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
