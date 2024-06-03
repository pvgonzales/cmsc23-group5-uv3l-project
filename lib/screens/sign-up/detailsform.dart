import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project/provider/auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class DetailsForm extends StatefulWidget {
  const DetailsForm({super.key});

  @override
  _DetailsFormFormState createState() => _DetailsFormFormState();
}

class _DetailsFormFormState extends State<DetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? fullname;
  String? username;
  String? phoneNumber;
  String? address;
  String? orgdesc;
  String orgtype = 'Non-Profit';
  String usertype = 'donor';
  bool organization = false;
  XFile? _imageFile;
  String? convertedImage;

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
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final email = arguments['email'] as String?;
    final password = arguments['password'] as String?;

    final userAuthProvider = Provider.of<UserAuthProvider>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            onSaved: (newValue) => fullname = newValue,
            onChanged: (value) {
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your name";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Full Name",
              hintText: "Enter your full name",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.person),
              filled: true,
              fillColor:
                  Colors.white, // Change to your desired background color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    10.0), // Change to your desired border radius
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // ADD A FUNCTIONALITY HERE TO CHECK IF A USERNAME ENTERED ALREADY EXISTS
          TextFormField(
            onSaved: (newValue) => username = newValue,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter a username";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Username",
              hintText: "Enter your username",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.person),
              filled: true,
              fillColor:
                  Colors.white, // Change to your desired background color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    10.0), // Change to your desired border radius
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.phone,
            onSaved: (newValue) => phoneNumber = newValue,
            onChanged: (value) {
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your phone number";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Phone Number",
              hintText: "Enter your phone number",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.phone),
              filled: true,
              fillColor:
                  Colors.white, // Change to your desired background color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    10.0), // Change to your desired border radius
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
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
            decoration: InputDecoration(
              labelText: "Address",
              hintText: "Enter your address",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.pin_drop), filled: true,
              fillColor:
                  Colors.white, // Change to your desired background color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    10.0), // Change to your desired border radius
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (organization == true) ...[
            IconButton(
                onPressed: _pickImage,
                icon: const Icon(Icons.camera_alt_rounded)),
            const Text(
              'Upload Photo',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF212738),
                fontFamily: "MyFont1",
              ),
            ),
            if (_imageFile != null) ...[
              const SizedBox(height: 20),
              Image.file(
                File(_imageFile!.path),
                height: 150,
              ),
            ],
            const SizedBox(height: 20),
            TextFormField(
              onSaved: (newValue) => orgdesc = newValue,
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
                labelText: "Description",
                hintText: "Describe your Organization",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: Icon(Icons.description)
              ),
            ),
            const SizedBox(height: 20),
            const Text('Type of Organization'),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: DropdownButton<String>(
                  dropdownColor: const Color.fromARGB(255, 255, 227, 225),
                  borderRadius: BorderRadius.circular(20),
                  value: orgtype,
                  onChanged: (String? newValue) {
                    setState(() {
                      orgtype = newValue!;
                    });
                  },
                  underline: Container(
                    height: 1,
                    color: const Color(0xFF212738),
                  ),
                  items: <String>[
                    'Non-Profit',
                    'Religious',
                    'Academic',
                    'Health',
                    'Others'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
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
          ],
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF212738),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                bool usernameExists =
                    await userAuthProvider.isUsernameAlreadyInUse(username!);
                if (usernameExists) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Username already exists"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                } else {
                  // store in firebase
                  if (organization == true) {
                    usertype = 'Organization';
                    convertedImage = await _convertImage(_imageFile!);
                  }
                  context.read<UserAuthProvider>().authService.signUp(
                      fullname!,
                      email!,
                      username!,
                      password!,
                      phoneNumber!,
                      address!,
                      usertype,
                      convertedImage,
                      orgdesc!,
                      orgtype
                    );
                  Navigator.pushNamed(context, '/sign-in');
                }
              }
            },
            child: const Text(
              "Continue",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontFamily: "MyFont1",
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (organization == true) ...[
            Text(
              '''By continuing, you confirm that you are a legitimate organization and agree with our Terms and Conditions. If found otherwise, you agree to be bound by our terms.''',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Color(0xFF212738),
                fontFamily: "MyFont1",
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          if (organization == false) ...[
            Text(
              'By continuing, you confirm that you agree \nwith our Terms and Conditions',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF212738),
                  fontFamily: "MyFont1",
                  fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign up as an organization? ",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF212738),
                    fontFamily: "MyFont1",
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        organization = !organization;
                      });
                    },
                    child: const Text(
                      "Click Here",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF212738),
                          fontFamily: "MyFont1",
                          decoration: TextDecoration.underline),
                    )),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
