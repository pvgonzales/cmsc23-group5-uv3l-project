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
import 'package:telephony/telephony.dart';

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

  void _sendSMS() async {
    String message =
        "Your donation has been successfully completed. Thank you for your contribution!";
    String recipient = widget.donation.phoneNum!;

    final Telephony telephony = Telephony.instance;

    bool? permissionsGranted = await telephony.requestSmsPermissions;

    if (permissionsGranted ?? false) {
      telephony.sendSms(
        to: recipient,
        message: message,
        statusListener: (SendStatus status) {
          if (status == SendStatus.SENT) {
            print("SMS is sent!");
          } else if (status == SendStatus.DELIVERED) {
            print("SMS is delivered!");
          } else {
            print("Failed to send SMS.");
          }
        },
      );
    } else {
      print("SMS permissions not granted.");
    }
  }

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
    if (_currentStatus == 'Complete') {
      _sendSMS();
      _showNotification();
    }
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Color.fromARGB(255, 255, 216, 214),
        content: Text(
          'Donation Status Updated',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: "MyFont1",
            color: Color(0xFF212738),
          ),
        )));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Donation Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: "MyFont1",
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xFF212738),
          iconTheme: IconThemeData(
            color: Colors.white, // Change this color to the desired color
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 50, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        '${widget.donation.id}',
                        style: TextStyle(
                          fontFamily: "MyFont1",
                          color: Color(0xFF212738),
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Text(
                        'Donation ID',
                        style: TextStyle(
                          fontFamily: "MyFont1",
                          color: Color(0xFF212738),
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                _buildDataRow('Items', '${widget.donation.items.join(', ')}'),
                SizedBox(height: 10.0),
                _buildDataRow('Logistics', '${widget.donation.logistics}'),
                if (widget.donation.address != null &&
                    widget.donation.phoneNum != null) ...[
                  SizedBox(height: 10.0),
                  _buildDataRow('Address', '${widget.donation.address}'),
                  SizedBox(height: 10.0),
                  _buildDataRow('Phone Number', '${widget.donation.phoneNum}'),
                ],
                SizedBox(height: 10.0),
                _buildDataRow('Date', '${widget.donation.date}'),
                SizedBox(height: 10.0),
                _buildDataRow('Time', '${widget.donation.time}'),
                SizedBox(height: 10.0),
                _buildDataRow('Status', '${widget.donation.status}'),
                if (widget.donation.proof != null &&
                    widget.donation.donationdrive != null) ...[
                  SizedBox(height: 10.0),
                  _buildDataRow(
                      'Donation Drive', '${widget.donation.donationdrive}'),
                  Image.file(
                    File(widget.donation.proof!.path),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ],
                SizedBox(height: 6.0),
                if (widget.donation.status != 'Complete') ...[
                  if (widget.donation.logistics == 'Pick up') ...[
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: DropdownButton<String>(
                          dropdownColor: Color.fromARGB(255, 255, 227, 225),
                          borderRadius: BorderRadius.circular(20),
                          value: _currentStatus,
                          onChanged: (String? newValue) {
                            setState(() {
                              _currentStatus = newValue!;
                            });
                          },
                          underline: Container(
                            height: 1,
                            color: Color(0xFF212738),
                          ),
                          items: <String>[
                            'Pending',
                            'Confirmed',
                            'Scheduled for Pick-up',
                            'Complete',
                            'Canceled'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontFamily: "MyFont1",
                                  color: Color(0xFF212738),
                                  fontSize: 13,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ] else ...[
                    Center(
                      child: DropdownButton<String>(
                        dropdownColor: Color.fromARGB(255, 255, 227, 225),
                        value: _currentStatus,
                        borderRadius: BorderRadius.circular(20),
                        onChanged: (String? newValue) {
                          setState(() {
                            _currentStatus = newValue!;
                          });
                        },
                        underline: Container(
                          height: 1,
                          color: Color(0xFF212738),
                        ),
                        items: <String>[
                          'Pending',
                          'Confirmed',
                          'Complete',
                          'Canceled'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                fontFamily: "MyFont1",
                                color: Color(0xFF212738),
                                fontSize: 13,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                  if (_currentStatus == 'Complete') ...[
                    SizedBox(height: 10.0),
                    Consumer<DonationDriveProvider>(
                      builder: (context, driveProvider, child) {
                        return Center(
                          child: Container(
                            child: DropdownButton<String>(
                              dropdownColor: Color.fromARGB(255, 255, 227, 225),
                              borderRadius: BorderRadius.circular(20),
                              hint: Text(
                                'Select Donation Drive',
                                style: TextStyle(
                                  fontFamily: "MyFont1",
                                  color: Color(0xFF212738),
                                  fontSize: 13,
                                ),
                              ),
                              value: _selectedDrive,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedDrive = newValue!;
                                });
                              },
                              underline: Container(
                                height: 1,
                                color: Color(0xFF212738),
                              ),
                              items: driveProvider.orgdrives
                                  .map<DropdownMenuItem<String>>(
                                      (DonationDrive drive) {
                                return DropdownMenuItem<String>(
                                  value: drive.name,
                                  child: Text(
                                    drive.name,
                                    style: TextStyle(
                                      fontFamily: "MyFont1",
                                      color: Color(0xFF212738),
                                      fontSize: 13,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 5.0),
                    Center(
                        child: Column(
                      children: [
                        ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color?>(null),
                          ),
                          onPressed: _pickImage,
                          icon: Icon(
                            Icons.camera_alt,
                            color: Color(0xFF212738),
                          ),
                          label: Text(
                            'Upload Photo',
                            style: TextStyle(
                                fontFamily: "MyFont1",
                                color: Color(0xFF212738),
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        if (_imageFile != null) ...[
                          SizedBox(height: 10.0),
                          Image.file(
                            File(_imageFile!.path),
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ],
                    ))
                  ],
                  SizedBox(height: 5.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color?>(null),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontFamily: "MyFont1",
                            color: Color(0xFF212738),
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ],
            ),
          ),
        ));
  }

  Widget _buildDataRow(String label, String value) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(82, 255, 207, 205),
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: EdgeInsets.all(6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: EdgeInsets.all(6.0),
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  fontFamily: "MyFont1",
                  color: Color(0xFF212738),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          Container(
            width: 120,
            decoration: BoxDecoration(
              color: Color(0xFF212738),
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: EdgeInsets.all(6.0),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                fontFamily: "MyFont1",
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
