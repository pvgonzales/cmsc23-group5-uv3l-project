import 'package:flutter/material.dart';
import 'package:flutter_project/model/org_model.dart';
import 'package:flutter_project/screens/organization-details/donorform.dart';

class OrgDonation extends StatefulWidget {
  final Organizations? org;
  const OrgDonation({super.key, this.org});

  @override
  State<OrgDonation> createState() => _OrgDonationState();
}

class _OrgDonationState extends State<OrgDonation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donate'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Text("Donate to ${widget.org!.name}", style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 112, 0, 0),
                    height: 1.5,
                  )),
                  const SizedBox(height: 16),
                  const DonorForm(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}