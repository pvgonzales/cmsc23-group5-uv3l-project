import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "title": "EFFORTLESS GIVING",
      "text": "Make a difference effortlessly - \ndonate with a tap.",
      "image": "assets/images/logo1.png"
    },
    {
      "title": "EMPOWER\nYOUR CAUSES",
      "text": "Empower causes you care \nabout with seamless giving.",
      "image": "assets/images/logo2.png"
    },
    {
      "title": "GENEROSITY \nMADE EASY",
      "text": "Transform generosity into impact, \nright from your fingertips.",
      "image": "assets/images/logo3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE5E9FC),
              Color(0xFFD8E0FD),
              Color.fromARGB(255, 212, 219, 250),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
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
                        Image.asset(
                          'assets/images/applogo2.png',
                          width: 190,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          splashData[index]['title']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: "MyFont3",
                            color: Color(0xFF212738),
                            height: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          splashData[index]['text']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: "MyFont1",
                            color: Color(0xFF212738),
                          ),
                        ),
                        const Spacer(flex: 1),
                        Image.asset(
                          splashData[index]['image']!,
                          height: 320,
                          width: 320,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
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
                                  ? const Color(0xFF212738)
                                  : const Color(0xFFD8D8D8),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 1),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/sign-up');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF212738),
                        ),
                        child: const Text(
                          "Let's Start!",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "MyFont1",
                              color: Colors.white),
                        ),
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
