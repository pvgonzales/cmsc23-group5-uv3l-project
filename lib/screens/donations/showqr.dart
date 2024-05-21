import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_project/model/donation_model.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class ShowQR extends StatelessWidget {
  final Donation donation;
  ShowQR({super.key, required this.donation});
  final ScreenshotController screenshotcontroller = ScreenshotController();

  Future<void> saveQr() async {
    final Uint8List? uint8list = await screenshotcontroller.capture();
      final PermissionStatus status = await Permission.storage.request();
      if (status.isGranted){
        final result = await ImageGallerySaver.saveImage(uint8list!);
        if(result['isSuccess']){
          print('QR saved to gallery.');
        }else{
          print('Failed to save QR: ${result['error']}');
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text('Items: ${donation.items.join(', ')}'),
                Text('Logistics: ${donation.logistics}'),
                Text('Date: ${donation.date}'),
                Text('Time: ${donation.time}'),
              ],
            ),
            Screenshot(
              controller: screenshotcontroller,
              child: QrImageView(
                data: '12345678', // Must contain donation details
                version: QrVersions.auto,
                size: 150.0,
                gapless: false,
              ),
              
            ),
            const SizedBox(
                height: 20,
              ),
            const Text('Kindly show this QR code for drop off'), 
            ElevatedButton(
              onPressed: ()async{
                await saveQr();
              }, 
              child: const Text('Save QR')
            ),
          ],
        ), 
      )
    );
  }
}