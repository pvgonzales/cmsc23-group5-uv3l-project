import 'package:flutter/material.dart';
import 'package:flutter_project/model/user_model.dart';
import 'package:flutter_project/provider/auth_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final email = arguments['email'] as String?;
    final password = arguments['password'] as String?;

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
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // Update user details using UserModel
                Provider.of<UserModel>(context, listen: false)
                    .updateUserDetails(
                  fullname: fullname,
                  username: username,
                  phoneNumber: phoneNumber,
                  address: address,
                );
                // store in firebase
                context.read<UserAuthProvider>()
                .authService
                .signUp(fullname!, email!, username!, password!, phoneNumber!, address!);
                Navigator.pushNamed(context, '/sign-in');
              }
            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}
