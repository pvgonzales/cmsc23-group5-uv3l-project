import 'package:flutter/material.dart';
import 'package:flutter_project/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  final String destinationRoute;

  const SignInForm({Key? key, required this.destinationRoute})
      : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your email";
              } else if (!value.contains('@')) {
                //SUBJECT TO CHANGE
                return "Please enter a valid email";
              }
              return null;
            },
            decoration: const InputDecoration(
                labelText: "Email",
                hintText: "Enter your email",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: Icon(Icons.email)),
          ),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            onSaved: (newValue) => password = newValue,
            onChanged: (value) {
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your password";
              } else if (value.length < 8) {
                return "Password must be at least 8 characters";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.lock_rounded),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: const Color.fromARGB(255, 0, 97, 10),
                onChanged: (value) {
                  // ADD USER AUTH FUNCTIONALITIES HERE
                  setState(() {
                    remember = value;
                  });
                },
              ),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/forgot-password'),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                String? message = await context
                    .read<UserAuthProvider>()
                    .authService
                    .signIn(email!, password!);

                if (message == "Success") {
                  Navigator.pushReplacementNamed(
                      context,
                      widget
                          .destinationRoute); // Navigate to the specified destination
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Invalid email or password"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}
