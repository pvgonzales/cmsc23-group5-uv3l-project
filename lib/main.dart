import 'package:flutter/material.dart';
import 'package:flutter_project/model/org_model.dart';
import 'package:flutter_project/screens/home/home.dart';
import 'package:flutter_project/screens/intro-screen/intro.dart';
import 'package:flutter_project/screens/organization-details/orgdetails.dart';
import 'package:flutter_project/screens/sign-in/signin.dart';
import 'package:flutter_project/screens/sign-up/completedetails.dart';
import 'package:flutter_project/screens/sign-up/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elbi Donation System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 97, 10)),
        useMaterial3: true,
      ),
      
      onGenerateRoute: (setting) {
        if(setting.name == '/'){
          return MaterialPageRoute(builder: (context) => const IntroScreen());
        }else if(setting.name == '/sign-up'){
          return MaterialPageRoute(builder: (context) => const SignUpScreen());
        }else if (setting.name == '/sign-in'){
          return MaterialPageRoute(builder: (context) => const SignInScreen());
        }else if (setting.name == '/home'){
          return MaterialPageRoute(builder: (context) => const HomeScreen());
        }else if (setting.name == '/org-details'){
          var orgname = setting.arguments as Organizations;
          return MaterialPageRoute(builder: (context) => OrgDonation(org: orgname));
        }else if (setting.name == '/forgot-password'){
          return MaterialPageRoute(builder: (context) => const Placeholder());
        }else if (setting.name == '/complete-profile'){
          return MaterialPageRoute(builder: (context) => const CompleteDetailsScreen());
        }
      },
    );
  }
}

