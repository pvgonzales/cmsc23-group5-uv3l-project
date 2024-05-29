import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_project/model/donation_model.dart';
import 'package:flutter_project/provider/donation_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class DonorForm extends StatefulWidget {
  const DonorForm({super.key});

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

  final TextEditingController _dateValue = TextEditingController();
  final TextEditingController _timeValue = TextEditingController();
  XFile? _imageFile;

  Future<void> _selectDate() async {
    DateTime? pickDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(const Duration(days: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));

    if (pickDate != null) {
      setState(() {
        _dateValue.text = pickDate.toString().split(' ')[0];
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? pickTime =
        await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 8, minute: 0));
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

  @override
  Widget build(BuildContext context) {
    final DonationProvider donationProvider = Provider.of<DonationProvider>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Center(
            child: Text('Donation Items',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.5,
                )),
          ),
          CheckboxListTile(
            title: const Text('Food'),
            value: food,
            onChanged: (newValue) {
              setState(() {
                food = newValue;
              });
            },
            activeColor: const Color.fromARGB(255, 112, 0, 0),
            checkColor: Colors.white,
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: const Text('Clothes'),
            value: clothes,
            onChanged: (newValue) {
              setState(() {
                clothes = newValue;
              });
            },
            activeColor: const Color.fromARGB(255, 112, 0, 0),
            checkColor: Colors.white,
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: const Text('Cash'),
            value: cash,
            onChanged: (newValue) {
              setState(() {
                cash = newValue;
              });
            },
            activeColor: const Color.fromARGB(255, 112, 0, 0),
            checkColor: Colors.white,
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: const Text('Necessities'),
            value: necessities,
            onChanged: (newValue) {
              setState(() {
                necessities = newValue;
              });
            },
            activeColor: const Color.fromARGB(255, 112, 0, 0),
            checkColor: Colors.white,
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: const Text('Others'),
            value: others,
            onChanged: (newValue) {
              setState(() {
                others = newValue;
              });
            },
            activeColor: const Color.fromARGB(255, 112, 0, 0),
            checkColor: Colors.white,
            controlAffinity: ListTileControlAffinity.leading,
          ),
          const Center(
            child: Text('Logistics',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.5,
                )),
          ),
          DropdownButton(
              value: logistics,
              items: const [
                DropdownMenuItem<String>(
                    value: 'Pick up', child: Text('Pick up')),
                DropdownMenuItem<String>(
                    value: 'Drop-off', child: Text('Drop-off'))
              ],
              icon: const Icon(Icons.arrow_drop_down),
              style: const TextStyle(color: Colors.black),
              underline: Container(
                color: Colors.white,
                height: 2,
              ),
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
              hintText: "Enter weight in kilograms",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.monitor_weight),
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
                filled: true,
                prefixIcon: Icon(Icons.calendar_today),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 112, 0, 0)))),
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
                filled: true,
                prefixIcon: Icon(Icons.calendar_today),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 112, 0, 0)))),
            readOnly: true,
            onTap: () {
              _selectTime();
            },
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10),
            child: IconButton(
                onPressed: _pickImage,
                icon: const Icon(Icons.camera_alt)
              ),
          ),
          const Text('Upload Photo Proof'),
          const SizedBox(height: 20),
          _imageFile != null ? 
              Image.file(
                File(_imageFile!.path),
                height: 200,
              ) : const SizedBox(height: 20),
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
                          hintText: "Enter your address",
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
                          hintText: "Enter your phone number",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(Icons.phone)),
                    ),
                  ],
                )
              : Container(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                int newDonationId = DateTime.now().millisecondsSinceEpoch;
                List<String> selectedItems = [];
                if (food!) selectedItems.add('Food');
                if (clothes!) selectedItems.add('Clothes');
                if (cash!) selectedItems.add('Cash');
                if (necessities!) selectedItems.add('Necessities');
                if (others!) selectedItems.add('Others');
                Donation newDonation = Donation(
                  id: newDonationId,
                  items: selectedItems,
                  logistics: logistics,
                  address: logistics == 'Pick up' ? address : null,
                  phoneNum: logistics == 'Pick up' ? phoneNum : null,
                  date: _dateValue.text,
                  time: _timeValue.text,
                  proof: _imageFile,
                  status: "Pending"
                );
                // var donationProvider =
                //     Provider.of<DonationProvider>(context, listen: false);
                donationProvider.addDonation(newDonation);
                // donationProvider.fetchDonations();
                Navigator.pop(
                    context, 'Donation submitted! Kindly wait for approval.');
              }
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
