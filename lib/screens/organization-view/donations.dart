import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_project/model/donation_model.dart';
import 'package:flutter_project/model/donationdrive_model.dart';
import 'package:flutter_project/provider/donation_provider.dart';
import 'package:flutter_project/provider/donationdrive_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_sms/flutter_sms.dart';

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
  String? _selectedDrive;

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

  void _submit() {
    final int donationIndex = context
        .read<DonationProvider>()
        .donations
        .indexWhere((d) => d.id == widget.donation.id);
    if (donationIndex != -1) {
      context.read<DonationProvider>().donations[donationIndex] = Donation(
        id: widget.donation.id,
        items: widget.donation.items,
        logistics: widget.donation.logistics,
        address: widget.donation.address,
        phoneNum: widget.donation.phoneNum,
        date: widget.donation.date,
        time: widget.donation.time,
        proof: _imageFile,
        status: _currentStatus,
        donationdrive: _selectedDrive,
      );
      context.read<DonationProvider>().notifyListeners();
    }
    Navigator.pop(context);
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
            if (widget.donation.address != null && widget.donation.phoneNum != null)...[
              Text('Address: ${widget.donation.address}'),
              Text('Phone Number: ${widget.donation.phoneNum}')
            ], 
            Text('Date: ${widget.donation.date}'),
            Text('Time: ${widget.donation.time}'),
            Text('Status: ${widget.donation.status}'),
            if (widget.donation.proof != null && widget.donation.donationdrive != null) ... [
              Text('Donation Drive: ${widget.donation.donationdrive}'),
              Image.file(
                File(widget.donation.proof!.path),
                height: 200,
              ),
            ],
            const SizedBox(height: 20),
            if(widget.donation.status != 'Complete') ...[
              if(widget.donation.logistics == 'Pick up')...[
                DropdownButton<String>(
                  value: _currentStatus,
                  onChanged: (String? newValue) {
                    setState(() {
                      _currentStatus = newValue!;
                    });
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
              ]
              else ... [
                DropdownButton<String>(
                  value: _currentStatus,
                  onChanged: (String? newValue) {
                    setState(() {
                      _currentStatus = newValue!;
                    });
                  },
                  items: <String>[
                    'Pending',
                    'Confirmed',
                    'Complete',
                    'Canceled'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
              if (_currentStatus == 'Complete') ...[
                const SizedBox(height: 20),
                Consumer<DonationDriveProvider>(
                  builder: (context, driveProvider, child) {
                    return DropdownButton<String>(
                      hint: const Text('Select Donation Drive'),
                      value: _selectedDrive,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedDrive = newValue!;
                        });
                      },
                      items: driveProvider.orgdrives.map<DropdownMenuItem<String>>((DonationDrive drive) {
                        return DropdownMenuItem<String>(
                          value: drive.name,
                          child: Text(drive.name),
                        );
                      }).toList(),
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Column(
                    children: [
                      Icon(Icons.camera_alt),
                      Text('Upload Photo')
                    ],
                  ),
                ),
                if (_imageFile != null) ...[
                  const SizedBox(height: 20),
                  Image.file(
                    File(_imageFile!.path),
                    height: 200,
                  ),
                ],
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Submit'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}