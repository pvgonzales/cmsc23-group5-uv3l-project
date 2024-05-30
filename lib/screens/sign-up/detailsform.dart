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
  String usertype = 'Donor';
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
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
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
            decoration: const InputDecoration(
              labelText: "Full Name",
              hintText: "Enter your full name",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.person),
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
            decoration: const InputDecoration(
              labelText: "Username",
              hintText: "Enter your username",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.person),
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
            decoration: const InputDecoration(
              labelText: "Phone Number",
              hintText: "Enter your phone number",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.phone),
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
            decoration: const InputDecoration(
                labelText: "Address",
                hintText: "Enter your address",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: Icon(Icons.pin_drop)),
          ),
          const SizedBox(height: 20),
          if(organization == true)...[
            IconButton(
              onPressed: _pickImage, 
              icon: const Icon(Icons.camera_alt_rounded)
            ),
            const Text('Upload Photo'),
            if (_imageFile != null) ...[
                  const SizedBox(height: 20),
                  Image.file(
                    File(_imageFile!.path),
                    height: 150,
                  ),
                ],
          ],
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                bool usernameExists = await userAuthProvider.isUsernameAlreadyInUse(username!);
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
                  if(organization == true) {
                    usertype = 'Organization';
                    convertedImage = await _convertImage(_imageFile!);
                  }
                  context.read<UserAuthProvider>()
                  .authService
                  .signUp(fullname!, email!, username!, password!, phoneNumber!, address!, usertype, convertedImage);
                  Navigator.pushNamed(context, '/sign-in');
                }
              }
            },
            child: const Text("Sign Up"),
          ),
          const SizedBox(height: 16),
          if(organization == true) ...[
            Text(
                    '''By continuing, you confirm that you are a legitimate organization and agree with our Terms and Conditions. If found otherwise, you agree to be bound by our terms.''',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
          if(organization == false)...[
            Text(
              'By continuing, you confirm that you agree \nwith our Terms and Conditions',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign up as an organization? ",
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      organization = !organization;
                    });
                  },
                  child: const Text(
                    "Click Here",
                    style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 97, 10), decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
