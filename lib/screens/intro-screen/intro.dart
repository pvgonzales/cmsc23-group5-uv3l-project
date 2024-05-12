import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Elbi Donation System!",
      "image": "assets/images/logo1.png"
    },
    {
      "text": "We help people conect around \nLos Baños through this app.",
      "image": "assets/images/logo2.png"
    },
    {
      "text": "Just stay at home with us \nand show our way to help!",
      "image": "assets/images/logo3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: splashData.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          const Spacer(),
                          const Text(
                            "Elbi Donation System",
                            style: TextStyle(
                              fontSize: 32,
                              color: Color.fromARGB(255, 141, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            splashData[index]['text']!,
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(flex: 2),
                          Image.asset(
                            splashData[index]['image']!,
                            height: 265,
                            width: 265,
                          ),
                        ],
                      );
                    },
                  )),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 5),
                            height: 6,
                            width: currentPage == index ? 20 : 6,
                            decoration: BoxDecoration(
                              color: currentPage == index
                                  ? const Color.fromARGB(255, 0, 97, 10)
                                  : const Color(0xFFD8D8D8),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 3),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/sign-up');
                        },
                        child: const Text("Continue"),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
