import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_project/model/donation_model.dart';
import 'package:flutter_project/provider/auth_provider.dart';
import 'package:flutter_project/provider/donation_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class DonorForm extends StatefulWidget {
  final String orgusername;
  const DonorForm({super.key, required this.orgusername});

  @override
  _DonorFormFormState createState() => _DonorFormFormState();
}

class _DonorFormFormState extends State<DonorForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  bool? food = false;
  bool? clothes = false;
  bool? cash = false;
  bool? necessities = false;
  bool? others = false;
  String logistics = 'Pick up';
  String? address;
  String? weight;
  String? phoneNum;
  String? convertedImage;

  final TextEditingController _dateValue = TextEditingController();
  final TextEditingController _timeValue = TextEditingController();
  XFile? _imageFile;

  Future<void> _selectDate() async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light().copyWith(
              primary: Color(0xFF212738), // Background color
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickDate != null) {
      setState(() {
        _dateValue.text = pickDate.toString().split(' ')[0];
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? pickTime = await showTimePicker(
        context: context, initialTime: const TimeOfDay(hour: 8, minute: 0));
    if (pickTime != null) {
      setState(() {
        _timeValue.text = pickTime.format(context).toString();
      });
    }
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
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera permission denied')),
      );
    }
  }

  Future<String> _convertImage(XFile image) async {
    try {
      final bytes = await image.readAsBytes();
      String base64Image = base64Encode(bytes);
      return (base64Image);
    } catch (e) {
      return '$e';
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserAuthProvider userProvider = 
        Provider.of<UserAuthProvider>(context);
    final DonationProvider donationProvider =
        Provider.of<DonationProvider>(context);
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Center(
              child: Text('Donation Items',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF212738),
                      fontFamily: "MyFont1",
                      fontStyle: FontStyle.italic)),
            ),
            CheckboxListTile(
              title: const Text('Food',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF212738),
                    fontFamily: "MyFont1",
                  )),
              value: food,
              onChanged: (newValue) {
                setState(() {
                  food = newValue;
                });
              },
              activeColor: Color.fromARGB(255, 255, 227, 225),
              checkColor: Colors.white,
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text('Clothes',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF212738),
                    fontFamily: "MyFont1",
                  )),
              value: clothes,
              onChanged: (newValue) {
                setState(() {
                  clothes = newValue;
                });
              },
              activeColor: Color.fromARGB(255, 255, 227, 225),
              checkColor: Colors.white,
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text('Cash',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF212738),
                    fontFamily: "MyFont1",
                  )),
              value: cash,
              onChanged: (newValue) {
                setState(() {
                  cash = newValue;
                });
              },
              activeColor: Color.fromARGB(255, 255, 227, 225),
              checkColor: Colors.white,
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text('Necessities',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF212738),
                    fontFamily: "MyFont1",
                  )),
              value: necessities,
              onChanged: (newValue) {
                setState(() {
                  necessities = newValue;
                });
              },
              activeColor: Color.fromARGB(255, 255, 227, 225),
              checkColor: Colors.white,
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text('Others',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF212738),
                    fontFamily: "MyFont1",
                  )),
              value: others,
              onChanged: (newValue) {
                setState(() {
                  others = newValue;
                });
              },
              activeColor: Color.fromARGB(255, 255, 227, 225),
              checkColor: Colors.white,
              controlAffinity: ListTileControlAffinity.leading,
            ),
            SizedBox(
              height: 10,
            ),
            const Center(
              child: Text('Logistics',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF212738),
                      height: 1.5,
                      fontFamily: "MyFont1",
                      fontStyle: FontStyle.italic)),
            ),
            DropdownButton(
                dropdownColor: Color.fromARGB(255, 255, 237, 236),
                borderRadius: BorderRadius.circular(20),
                value: logistics,
                underline: Container(
                  height: 1,
                  color: Color(0xFF212738),
                ),
                items: const [
                  DropdownMenuItem<String>(
                      value: 'Pick up',
                      child: Text(
                        'Pick up',
                        style: TextStyle(
                          fontFamily: "MyFont1",
                          color: Color(0xFF212738),
                          fontSize: 13,
                        ),
                      )),
                  DropdownMenuItem<String>(
                      value: 'Drop-off',
                      child: Text(
                        'Drop-off',
                        style: TextStyle(
                          fontFamily: "MyFont1",
                          color: Color(0xFF212738),
                          fontSize: 13,
                        ),
                      ))
                ],
                icon: const Icon(Icons.arrow_drop_down),
                style: const TextStyle(color: Colors.black),
                onChanged: (String? newValue) {
                  setState(() {
                    logistics = newValue!;
                  });
                }),
            TextFormField(
              keyboardType: TextInputType.number,
              onSaved: (newValue) => weight = newValue,
              onChanged: (value) {
                return;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter the weight of the items";
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: "Weight of Items",
                labelStyle: TextStyle(
                  fontFamily: "MyFont1",
                  color: Color(0xFF212738),
                  fontSize: 14,
                ),
                hintText: "Enter weight in kilograms",
                hintStyle: TextStyle(
                  fontFamily: "MyFont1",
                  color: Colors.grey,
                  fontSize: 14,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: Icon(Icons.monitor_weight),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF212738), // Change the color here
                    width: 2.0, // Change the thickness here
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _dateValue,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please select a date";
                }
                return null;
              },
              decoration: const InputDecoration(
                  labelText: 'Pick a date',
                  labelStyle: TextStyle(
                    fontFamily: "MyFont1",
                    color: Color(0xFF212738),
                    fontSize: 14,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.calendar_today),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFF212738),
                  ))),
              readOnly: true,
              onTap: () {
                _selectDate();
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _timeValue,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please select a time";
                }
                return null;
              },
              decoration: const InputDecoration(
                  labelText: 'Pick time',
                  labelStyle: TextStyle(
                    fontFamily: "MyFont1",
                    color: Color(0xFF212738),
                    fontSize: 14,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.calendar_today),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFF212738),
                  ))),
              readOnly: true,
              onTap: () {
                _selectTime();
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                  onPressed: _pickImage, icon: const Icon(Icons.camera_alt)),
            ),
            const Text(
              'Upload Photo Proof',
              style: TextStyle(
                fontFamily: "MyFont1",
                color: Color(0xFF212738),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            _imageFile != null
                ? Image.file(
                    File(_imageFile!.path),
                    height: 200,
                  )
                : const SizedBox(height: 20),
            logistics == 'Pick up'
                ? Column(
                    children: [
                      TextFormField(
                        onSaved: (newValue) => address = newValue,
                        onChanged: (value) {
                          return;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your address";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: "Address",
                            labelStyle: TextStyle(
                              fontFamily: "MyFont1",
                              color: Color(0xFF212738),
                              fontSize: 14,
                            ),
                            hintText: "Enter your address",
                            hintStyle: TextStyle(
                              fontFamily: "MyFont1",
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: Icon(Icons.pin_drop)),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        onSaved: (newValue) => phoneNum = newValue,
                        onChanged: (value) {
                          return;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your phone number";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: "Phone Number",
                            labelStyle: TextStyle(
                              fontFamily: "MyFont1",
                              color: Color(0xFF212738),
                              fontSize: 14,
                            ),
                            hintText: "Enter your phone number",
                            hintStyle: TextStyle(
                              fontFamily: "MyFont1",
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: Icon(Icons.phone)),
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  int newDonationId = DateTime.now().millisecondsSinceEpoch;
                  List<String> selectedItems = [];
                  if (food!) selectedItems.add('Food');
                  if (clothes!) selectedItems.add('Clothes');
                  if (cash!) selectedItems.add('Cash');
                  if (necessities!) selectedItems.add('Necessities');
                  if (others!) selectedItems.add('Others');
                  if (_imageFile != null){
                    convertedImage = await _convertImage(_imageFile!);
                  }else{
                    convertedImage = null;
                  }
                  Donation newDonation = Donation(
                      id: newDonationId,
                      items: selectedItems,
                      logistics: logistics,
                      address: logistics == 'Pick up' ? address : null,
                      phoneNum: logistics == 'Pick up' ? phoneNum : null,
                      date: _dateValue.text,
                      time: _timeValue.text,
                      proof: convertedImage,
                      status: "Pending",
                      donor: userProvider.currentUsername,
                      org: widget.orgusername);
                  // var donationProvider =
                  //     Provider.of<DonationProvider>(context, listen: false);
                  donationProvider.addDonation(newDonation);
                  // donationProvider.fetchDonations();
                  Navigator.pop(
                      context, 'Donation submitted! Kindly wait for approval.');
                }
              },
              child: const Text(
                "Submit",
                style: TextStyle(
                  fontFamily: "MyFont1",
                  color: Color(0xFF212738),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
