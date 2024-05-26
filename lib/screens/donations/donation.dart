import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_project/model/donation_model.dart';
import 'package:flutter_project/provider/donation_provider.dart';
import 'package:flutter_project/screens/donations/showqr.dart';
import 'package:provider/provider.dart';

class DonationsScreen extends StatelessWidget {
  const DonationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Donations'),
      ),
      body: Consumer<DonationProvider>(
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
          return ListView.builder(
            itemCount: donationProvider.donations.length,
            itemBuilder: (context, index) {
              var donation = donationProvider.donations[index];
              return ListTile(
                title: Text('Donation ID: ${donation.id}'),
                subtitle: Text('Logistics: ${donation.logistics}'),
                onTap: () {
                  if (donation.logistics == 'Drop-off'){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ShowQR(donation: donation)));
                  }else{
                    Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => ShowDetails(args: donation)));
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ShowDetails extends StatelessWidget {
  final Donation args;
  const ShowDetails({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${args.id}'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Items: ${args.items.join(', ')}'),
            Text('Logistics: ${args.logistics}'),
            Text('Address: ${args.address}'),
            Text('Phone Number: ${args.phoneNum}'),
            Text('Date: ${args.date}'),
            Text('Time: ${args.time}'),
            args.proof != null ?
            Image.file(
                File(args.proof!.path),
                height: 200,
            ) : Container(),
            Text('Status: ${args.status}')
          ],
        )
      ),
    );
  }
}