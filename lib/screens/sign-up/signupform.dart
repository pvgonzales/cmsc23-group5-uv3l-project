import 'package:flutter/material.dart';
import 'package:flutter_project/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? confirmPassword;

  @override
  Widget build(BuildContext context) {
    final userAuthProvider = Provider.of<UserAuthProvider>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
              } else if (value.contains("@")) {
                // SUBJECT TO CHANGE
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your email";
              } else if (!value.contains("@")) {
                // SUBJECT TO CHANGE
                return "Please enter a valid email";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.email),
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
            obscureText: true,
            onSaved: (newValue) => password = newValue,
            onChanged: (value) {
              password = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your password";
              } else if (value.length < 8) {
                return "Password must be at least 8 characters";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.password),
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
            obscureText: true,
            onSaved: (newValue) => confirmPassword = newValue,
            onChanged: (value) {
              confirmPassword = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your password";
              } else if ((password != value)) {
                return "Passwords do not match";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Confirm Password",
              hintText: "Re-enter your password",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.lock_rounded),
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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF212738),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                bool emailExists =
                    await userAuthProvider.isEmailAlreadyInUse(email!);
                if (emailExists) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Email is already in use"),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  Navigator.pushNamed(context, '/complete-profile', arguments: {
                    'email': email,
                    'password': password,
                  });
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
        ],
      ),
    );
  }
}
