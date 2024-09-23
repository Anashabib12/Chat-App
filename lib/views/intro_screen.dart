import 'package:chat_app/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  getPages() {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: IntroductionScreen(
        showSkipButton: true,
        skip: Text(
          'Skip',
          style: TextStyle(
              color: Color(0xffEC2578),
              fontWeight: FontWeight.w600,
              fontSize: width * 0.05),
        ),
        next: Icon(
          Icons.arrow_forward_rounded,
          color: Color(0xffEC2578),
          size: width * 0.08,
        ),
        done: Text(
          'Get Started',
          style: TextStyle(
              color: Color(0xffEC2578),
              fontWeight: FontWeight.w600,
              fontSize: width * 0.044),
        ),
        dotsDecorator:
            DotsDecorator(color: Colors.grey, activeColor: Color(0xffEC2578)),
        onDone: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
        pages: [
          PageViewModel(
              decoration: PageDecoration(imageFlex: 3),
              image: Padding(
                padding: EdgeInsets.only(bottom: height * 0.15),
                child: Image.asset('assets/images/f2.png'),
              ),
              titleWidget: Text(
                "Track your Comfort\nFood here",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w800, fontSize: width * 0.07),
              ),
              bodyWidget: Text(
                'Here You Can find a chef or dish for every\ntaste and color. Enjoy!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xff646464), fontSize: width * 0.035),
              )),
          PageViewModel(
              decoration: PageDecoration(imageFlex: 3),
              image: Padding(
                padding: EdgeInsets.only(bottom: height * 0.1),
                child: Image.asset('assets/images/f3.png'),
              ),
              titleWidget: Column(
                children: [
                  Text(
                    "Foodie is Where Your Comfort Food Resides",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w800, fontSize: width * 0.07),
                  ),
                ],
              ),
              bodyWidget: Text(
                'Enjoy a fast and smooth food delivery at\nyour doorstep',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xff646464), fontSize: width * 0.035),
              )),
          PageViewModel(
              decoration: PageDecoration(imageFlex: 3),
              image: Padding(
                padding: EdgeInsets.only(bottom: height * 0.15),
                child: Image.asset('assets/images/f6.png', width: width*0.87,),
              ),
              titleWidget: Text(
                "Track your Comfort\nFood here",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w800, fontSize: width * 0.07),
              ),
              bodyWidget: Text(
                'Here You Can find a chef or dish for every\ntaste and color. Enjoy!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xff646464), fontSize: width * 0.035),
              )),
        ],
      ),
    );
  }
}
