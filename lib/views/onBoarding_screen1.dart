import 'package:chat_app/components/customButton.dart';
import 'package:chat_app/components/onText1.dart';
import 'package:chat_app/components/onText2.dart';
import 'package:chat_app/views/onBoarding_screen2.dart';
import 'package:flutter/material.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery to get screen size
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.15,
            ),
            Image.asset('assets/images/f2.png'),
            SizedBox(
              height: height * 0.17,
            ),
            Ontext1(
              text: "Track your Comfort\nFood here",
              constraints: BoxConstraints(
                  maxWidth: width), // Pass constraints if required
            ),
            SizedBox(
              height: height * 0.018,
            ),
            Ontext2(
              text:
                  'Here You Can find a chef or dish for every\ntaste and color. Enjoy!',
              constraints: BoxConstraints(
                  maxWidth: width), // Pass constraints if required
            ),
            SizedBox(
              height: height * 0.07,
            ),
            Custombutton(
              width: width * 0.35,
              height: height * 0.055,
              constraints: BoxConstraints(
                  maxWidth: width), // Pass constraints if required
              text: 'Next',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OnboardingScreen2()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
