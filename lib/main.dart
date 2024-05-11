import 'package:flutter/material.dart';
import 'package:flutter_project/screens/intro-screen/intro.dart';
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
        }else{
          return MaterialPageRoute(builder: (context) => const Placeholder());
        }
      },
    );
  }
}

