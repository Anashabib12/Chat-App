import 'package:chat_app/components/customButton.dart';
import 'package:chat_app/components/onText1.dart';
import 'package:chat_app/components/onText2.dart';
import 'package:chat_app/views/wrapper.dart';
import 'package:flutter/material.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.084,
            ),
            Image.asset('assets/images/f3.png'),
            SizedBox(
              height: height * 0.1,
            ),
            Ontext1(
              text: "Foodie is Where Your\nComfort Food Resides",
              constraints:
                  BoxConstraints(maxWidth: width), // Adjust accordingly
            ),
            SizedBox(
              height: height * 0.018,
            ),
            Ontext2(
              text: 'Enjoy a fast and smooth food delivery at\nyour doorstep',
              constraints:
                  BoxConstraints(maxWidth: width), // Adjust accordingly
            ),
            SizedBox(
              height: height * 0.06,
            ),
            Custombutton(
              width: width * 0.35,
              height: height * 0.055,
              constraints:
                  BoxConstraints(maxWidth: width), // Adjust accordingly
              text: 'Next',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Wrapper(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
