import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_project/model/donation_model.dart';
import 'package:flutter_project/provider/donation_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_sms/flutter_sms.dart';

class DonationListOrg extends StatefulWidget {
  const DonationListOrg({super.key});

  @override
  State<DonationListOrg> createState() => _DonationListOrgState();
}

class _DonationListOrgState extends State<DonationListOrg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donations"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Consumer<DonationProvider>(
                  builder: (context, provider, child) {
                    List<Donation> donations = provider.donations;
                    return donations.isNotEmpty
                      ? ListView.builder(
                          itemCount: donations.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text('${donations[index].id}'),
                              subtitle: Text(donations[index].logistics),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DonationStatus(donation: donations[index]),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.arrow_right_outlined),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : const Center(child: Text('No donations available'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DonationStatus extends StatefulWidget {
  final Donation donation;
  const DonationStatus({super.key, required this.donation});

  @override
  State<DonationStatus> createState() => _DonationStatusState();
}

class _DonationStatusState extends State<DonationStatus> {
  late String _currentStatus;
  XFile? _imageFile;
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.donation.status!;
    _initializeNotification();
  }

  Future<void> _initializeNotification() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin!.initialize(initializationSettings);
  }

  Future<void> _pickImage() async {
    final PermissionStatus status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          _imageFile = image;
        });
       // _sendSMS();
        _showNotification();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera permission denied')),
      );
    }
  }

  // void _sendSMS() async {
  //   String message = "Your donation has been successfully completed. Thank you for your contribution!";
  //   List<String> recipients = [widget.donation.phoneNum!];
  //   String result = await sendSMS(message: message, recipients: recipients)
  //       .catchError((onError) {
  //     print(onError);
  //   });
  //   print(result);
  // }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'donation_complete_channel',
      'Donation Notifications',
      channelDescription: 'Status of donations',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin!.show(
      0,
      'Donation Complete',
      'Your donation has been successfully completed. Thank you!',
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.donation.id}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Items: ${widget.donation.items.join(', ')}'),
            Text('Logistics: ${widget.donation.logistics}'),
            Text('Address: ${widget.donation.address}'),
            Text('Phone Number: ${widget.donation.phoneNum}'),
            Text('Date: ${widget.donation.date}'),
            Text('Time: ${widget.donation.time}'),
            Text('Status: ${widget.donation.status}'),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: _currentStatus,
              onChanged: (String? newValue) {
                setState(() {
                  _currentStatus = newValue!;
                });
                final int donationIndex = context
                    .read<DonationProvider>()
                    .donations
                    .indexWhere((d) => d.id == widget.donation.id);
                if (donationIndex != -1) {
                  context
                      .read<DonationProvider>()
                      .editDonationStatus(donationIndex, _currentStatus);
                }
              },
              items: <String>[
                'Pending',
                'Confirmed',
                'Scheduled for Pick-up',
                'Complete',
                'Canceled'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            if (_currentStatus == 'Complete') ...[
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Upload Photo'),
              ),
              if (_imageFile != null) ...[
                const SizedBox(height: 20),
                Image.file(
                  File(_imageFile!.path),
                  height: 200,
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}